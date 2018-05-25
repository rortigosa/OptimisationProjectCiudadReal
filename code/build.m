%function build(instruction)
instruction  =  'release';

if ispc
    blas_lib = '-lmwblas';
    mex_ext  = 'mexw64';
elseif isunix
%     blas_lib = '-lmblas';
    blas_lib = '-lblas';

    if ismac
        mex_ext  = 'mexmaci64';
    else
        mex_ext  = 'mexa64';
    end
end



%CPath  = fullfile(pwd,'code','mexfiles');
CPath  = fullfile(pwd,'code','mexfilesv2');
cdir   =  pwd;
cd(CPath)

cfunctions  =  dir(CPath); 


c_files       =  cell(1);
c_file_names  =  cell(1);
compiler  =  cell(1);

aux      =  0;
for ifile=1:size(cfunctions,1)
    filename  =  cfunctions(ifile).name;
    parts     =  strsplit(filename,'.');
    if strcmp(parts(2),'c') || strcmp(parts(2),'cpp')
       aux  =  aux + 1;
       c_files{aux}  =  filename;
       c_file_names{aux}  =  parts(1);
       if strcmp(parts(2),'c')
           compiler{aux} = 'gcc ';
       else
           compiler{aux} = 'g++ -std=c++14';
       end
    end
end

mex_available  =  true;

try
  for ifile=1:size(c_files,2)
%       mex(c_files{ifile});
      mex c_files{ifile} blas_lib;
  end
    
catch exception
  mex_available  =  false;
end

if mex_available==false
    for ifile=1:size(c_files,2)
        compile    =  [char(compiler{ifile}) ' -shared ' c_files{ifile} ' -o ' char(c_file_names{ifile}) '.' mex_ext];
%        compile  =  ['gcc -shared ' c_files{ifile} ' -o ' c_file_names{ifile}];
%         inc_dir  =  'C:\Program Files\MATLAB\R2015b\extern\include';
        inc_dir    = fullfile(matlabroot,'extern','include');
%         code_include  =  'C:\SoftwareDevelopment\MECHANICAL_SOLID_CODE_OPTIMISED\code\include';
        code_dir   = fullfile(cdir,'code','include');
        fastor_dir = fullfile(cdir,'code','include','Fastor-master');
%         lib_dir  =  'C:\Program Files\MATLAB\R2015b\bin\win64';
switch computer
    case('GLNXA64')
        lib_dir    = fullfile(matlabroot,'bin','glnxa64');
    otherwise
        lib_dir    = fullfile(matlabroot,'bin','win64');
end
        libraries  = [' -lmex -lmat -leng -lmx '];
%         blas_path  =  'C:\Program Files\MATLAB\R2015b\extern\lib\win64\mingw64';
switch computer
    case('GLNXA64')
        blas_path  =  '/usr/lib/libblas';
    otherwise
        blas_path  =  fullfile(matlabroot,'extern','lib','win64','mingw64');
end

        if strcmp(instruction,'release')
            opt_flags  =  ' -O3 -march=native -DNDEBUG';
        else   
            opt_flags = '';
        end
        
        fastorpath=  fullfile(pwd,'Fastor-master');
        
        
         compilation_instruction  = [compile ' -fPIC' ' -I"'  inc_dir '" -I"' code_dir '"  -I"' fastor_dir  '" -L"' lib_dir '"' libraries ' -L"' blas_path '" ' blas_lib opt_flags ];

        system(compilation_instruction);
    end
end


cd(cdir)


%end

