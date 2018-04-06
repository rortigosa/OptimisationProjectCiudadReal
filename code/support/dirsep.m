function d = dirsep()
if isunix()
    d = '/';
else
    d = '\';
end