function s = basedir_fem()
s = mfilename('fullpath');
[s,f,e]=fileparts(s);
s = strrep(s,['code' dirsep 'support'],'');
