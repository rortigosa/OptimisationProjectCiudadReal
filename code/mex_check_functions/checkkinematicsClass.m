N  =  1e3;
tic
for i=1:N
    a   =  kinematicsClass;
end
toc


F                 =  rand(3,3,4);
H                 =  rand(3,3,4);
J                 =  rand(4,1);
tic
for i=1:N
    kinematics.F  =  F;
    kinematics.H  =  H;
    kinematics.J  =  J;
    a   =  kinematics;
end
toc



