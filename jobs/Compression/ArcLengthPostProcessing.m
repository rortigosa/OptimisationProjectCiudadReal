function ArcLengthPostProcessing

CodePath  =  'C:\SoftwareDevelopment\OptimisationProjectCiudadReal\code'; 
JobsPath  =  'C:\SoftwareDevelopment\OptimisationProjectCiudadReal\jobs\MBBv2';
InputPath =  'C:\SoftwareDevelopment\OptimisationProjectCiudadReal\jobs\MBBv2';
%--------------------------------------------------------------------------
% Path to the code  
%--------------------------------------------------------------------------
if ~exist(CodePath,'dir')
    error('No such folder or directory');
end
addpath(genpath(fullfile(CodePath,'code')));
addpath(JobsPath);
addpath(InputPath);


%--------------------------------------------------------------------------
% Simulation 1  
%--------------------------------------------------------------------------
jobfolder  =  'C:\SoftwareDevelopment\OptimisationProjectCiudadReal\jobs\MBBv2\resultsVolume_fraction_0.4_MooneyRivlin_model_load_factor_0.0304';
addpath(genpath(fullfile(jobfolder)));
load_    =  29; 
cd(jobfolder);  
load(['Results_Optimisation_Iteration_' num2str(load_) '.mat']);
UserDefinedFuncs.ArcLengthControl   =  @UserDefinedArcLength;    
ControlOutPut1    =  ArcLengthNewtonRaphson(Data,NR,Geometry,Mesh,UserDefinedFuncs,...
                              Bc,FEM,Quadrature,MatInfo,Optimisation,...
                              TimeIntegrator,'~',0);
%--------------------------------------------------------------------------
% Simulation 2
%--------------------------------------------------------------------------
jobfolder  =  'P:\TopologyCode\jobs\MBBv2\Results for Meeting Friday\resultsVolume_fraction_0.4_MooneyRivlin_model_load_factor_0.0025333';
addpath(genpath(fullfile(jobfolder)));
load_   =  290;
cd(jobfolder);
load(['Results_Optimisation_Iteration_' num2str(load_) '.mat']);
UserDefinedFuncs.ArcLengthControl   =  @UserDefinedArcLength;    
ControlOutPut3    =  ArcLengthNewtonRaphson(Data,NR,Geometry,Mesh,UserDefinedFuncs,...
                              Bc,FEM,Quadrature,MatInfo,Optimisation,...
                              TimeIntegrator,'~',0);
%--------------------------------------------------------------------------
% Simulation 3
%--------------------------------------------------------------------------
jobfolder  =  'P:\TopologyCode\jobs\MBBv2\Results for Meeting Friday\resultsVolume_fraction_0.4_MooneyRivlin_model_load_factor_0.0050667';
addpath(genpath(fullfile(jobfolder)));
load_   =  200;
cd(jobfolder);
load(['Results_Optimisation_Iteration_' num2str(load_) '.mat']);
UserDefinedFuncs.ArcLengthControl   =  @UserDefinedArcLength;    
ControlOutPut2    =  ArcLengthNewtonRaphson(Data,NR,Geometry,Mesh,UserDefinedFuncs,...
                              Bc,FEM,Quadrature,MatInfo,Optimisation,...
                              TimeIntegrator,'~',0);
%--------------------------------------------------------------------------
% Simulation 4
%--------------------------------------------------------------------------
jobfolder  =  'P:\TopologyCode\jobs\MBBv2\Results for Meeting Friday\resultsVolume_fraction_0.4_MooneyRivlin_model_load_factor_0.0152';
addpath(genpath(fullfile(jobfolder)));
load_   =  260;
cd(jobfolder);
load(['Results_Optimisation_Iteration_' num2str(load_) '.mat']);
UserDefinedFuncs.ArcLengthControl   =  @UserDefinedArcLength;    
ControlOutPut4    =  ArcLengthNewtonRaphson(Data,NR,Geometry,Mesh,UserDefinedFuncs,...
                              Bc,FEM,Quadrature,MatInfo,Optimisation,...
                              TimeIntegrator,'~',0);
%--------------------------------------------------------------------------
% Simulation 5
%--------------------------------------------------------------------------
jobfolder  =  'P:\TopologyCode\jobs\MBBv2\Results for Meeting Friday\resultsVolume_fraction_0.4_MooneyRivlin_model_load_factor_0.0304';
addpath(genpath(fullfile(jobfolder)));
load_   =  267;
cd(jobfolder);
load(['Results_Optimisation_Iteration_' num2str(load_) '.mat']);
UserDefinedFuncs.ArcLengthControl   =  @UserDefinedArcLength;    
ControlOutPut5    =  ArcLengthNewtonRaphson(Data,NR,Geometry,Mesh,UserDefinedFuncs,...
                              Bc,FEM,Quadrature,MatInfo,Optimisation,...
                              TimeIntegrator,'~',0);
%--------------------------------------------------------------------------
% Simulation 6
%--------------------------------------------------------------------------
jobfolder  =  'P:\TopologyCode\jobs\MBBv2\Results for Meeting Friday\resultsVolume_fraction_0.4_MooneyRivlin_model_load_factor_0.0456';
addpath(genpath(fullfile(jobfolder)));
load_   =  265;
cd(jobfolder);
load(['Results_Optimisation_Iteration_' num2str(load_) '.mat']);
UserDefinedFuncs.ArcLengthControl   =  @UserDefinedArcLength;    
ControlOutPut6    =  ArcLengthNewtonRaphson(Data,NR,Geometry,Mesh,UserDefinedFuncs,...
                              Bc,FEM,Quadrature,MatInfo,Optimisation,...
                              TimeIntegrator,'~',0);

P1  =  0.506666666666667e-07;                          
P2  =  0.253333333333333e-06;
P3  =  0.506666666666667e-05;
P4  =  1.520000000000000e-05;
P5  =  3.040000000000000e-05;
P6  =  4.560000000000001e-05;

save('ArcLengthResults.mat')

%--------------------------------------------------------------------------
% Plot 1
%--------------------------------------------------------------------------
ControlOutPut  =  ControlOutPut1;
u  =  zeros(size(ControlOutPut,2),1);
P  =  zeros(size(ControlOutPut,2),1);
for i=1:size(ControlOutPut,2)
  u(i)  =  sum(ControlOutPut{i}.Output);
  %u(i)  =  ControlOutPut{i}.Output(1);
  P(i)  =  ControlOutPut{i}.Input(1);
end
figure(1)
plot(-u(1:127),-P(1:127),'-','LineWidth',1)
hold on
xx  =  linspace(min(-u(1:40)),max(-u(1:40)),100);
yy  =  P1*ones(length(xx));
plot(xx,yy,'--')
yy  =  P2*ones(length(xx));
plot(xx,yy,'--')
yy  =  P3*ones(length(xx));
plot(xx,yy,'--')
% yy  =  P4*ones(length(xx));
% plot(xx,yy,'--')
% yy  =  P5*ones(length(xx));
% plot(xx,yy,'--')
% yy  =  P6*ones(length(xx));
% plot(xx,yy,'--')
x1 = max(-u)/2;
y1 = P1;
txt1 = 'P1';
text(x1,y1,txt1)

x1 = max(-u)/2;
y1 = P2;
txt1 = 'P2';
text(x1,y1,txt1)

x1 = max(-u)/2;
y1 = P3;
txt1 = 'P3';
text(x1,y1,txt1)

grid on
ylabel('P\, (N)')
xlabel('x\, (m)')
set_latex_font(12)
%--------------------------------------------------------------------------
% Plot 2
%--------------------------------------------------------------------------
ControlOutPut  =  ControlOutPut2;
u  =  zeros(size(ControlOutPut,2),1);
P  =  zeros(size(ControlOutPut,2),1);
for i=1:size(ControlOutPut,2)
  u(i)  =  sum(ControlOutPut{i}.Output);
  %u(i)  =  ControlOutPut{i}.Output(1);
  P(i)  =  ControlOutPut{i}.Input(1);
end
figure(2)
plot(-u(1:47),-P(1:47),'-','LineWidth',4)
hold on
xx  =  linspace(min(-u(1:47)),max(-u(1:47)),100);
yy  =  P1*ones(length(xx));
plot(xx,yy,'--')
yy  =  P2*ones(length(xx));
plot(xx,yy,'--')
yy  =  P3*ones(length(xx));
plot(xx,yy,'--')
% yy  =  P4*ones(length(xx));
% plot(xx,yy,'--')
% yy  =  P5*ones(length(xx));
% plot(xx,yy,'--')
% yy  =  P6*ones(length(xx));
% plot(xx,yy,'--')

x1 = max(-u)/2;
y1 = P1;
txt1 = 'P1';
text(x1,y1,txt1)

x1 = max(-u)/2;
y1 = P2;
txt1 = 'P2';
text(x1,y1,txt1)

x1 = max(-u)/2;
y1 = P3;
txt1 = 'P3';
text(x1,y1,txt1)

ylabel('P\, (N)')
xlabel('x\, (m)')

grid on
set_latex_font(12)
%--------------------------------------------------------------------------
% Plot 3
%--------------------------------------------------------------------------
ControlOutPut  =  ControlOutPut3;
u  =  zeros(size(ControlOutPut,2),1);
P  =  zeros(size(ControlOutPut,2),1);
for i=1:size(ControlOutPut,2)
  u(i)  =  sum(ControlOutPut{i}.Output);
  P(i)  =  ControlOutPut{i}.Input(1);
end
figure(3)
plot(-u,-P,'-','LineWidth',4)
hold on
xx  =  linspace(min(-u),max(-u),100);
yy  =  P1*ones(length(xx));
plot(xx,yy,'--')
yy  =  P2*ones(length(xx));
plot(xx,yy,'--')
yy  =  P3*ones(length(xx));
plot(xx,yy,'--')

x1 = max(-u)/2;
y1 = P1;
txt1 = 'P1';
text(x1,y1,txt1)

x1 = max(-u)/2;
y1 = P2;
txt1 = 'P2';
text(x1,y1,txt1)

x1 = max(-u)/2;
y1 = P3;
txt1 = 'P3';
text(x1,y1,txt1)

% yy  =  P4*ones(length(xx));
% plot(xx,yy,'--')
% yy  =  P5*ones(length(xx));
% plot(xx,yy,'--')
% yy  =  P6*ones(length(xx));
% plot(xx,yy,'--')
ylabel('P\, (N)')
xlabel('x\, (m)')

grid on
set_latex_font(12)
%--------------------------------------------------------------------------
% Plot 4
%--------------------------------------------------------------------------
ControlOutPut  =  ControlOutPut4;
u  =  zeros(size(ControlOutPut,2),1);
P  =  zeros(size(ControlOutPut,2),1);
for i=1:size(ControlOutPut,2)
  u(i)  =  sum(ControlOutPut{i}.Output);
  P(i)  =  ControlOutPut{i}.Input(1);
end
figure(4)
plot(-u,-P,'-','LineWidth',4)
hold on
xx  =  linspace(min(-u),max(-u),100);
yy  =  P1*ones(length(xx));
plot(xx,yy,'--')
yy  =  P2*ones(length(xx));
plot(xx,yy,'--')
yy  =  P3*ones(length(xx));
plot(xx,yy,'--')
yy  =  P4*ones(length(xx));
plot(xx,yy,'--')
yy  =  P5*ones(length(xx));
plot(xx,yy,'--')

x1 = max(-u)/2;
y1 = P1;
txt1 = 'P1';
text(x1,y1,txt1)

x1 = max(-u)/2;
y1 = P2;
txt1 = 'P2';
text(x1,y1,txt1)

x1 = max(-u)/2;
y1 = P3;
txt1 = 'P3';
text(x1,y1,txt1)

x1 = max(-u)/2;
y1 = P4;
txt1 = 'P4';
text(x1,y1,txt1)

x1 = max(-u)/2;
y1 = P5;
txt1 = 'P5';
text(x1,y1,txt1)

% yy  =  P6*ones(length(xx));
% plot(xx,yy,'--')

ylabel('P\, (N)')
xlabel('x\, (m)')

grid on
set_latex_font(12)
%--------------------------------------------------------------------------
% Plot 5
%--------------------------------------------------------------------------
ControlOutPut  =  ControlOutPut5;
u  =  zeros(size(ControlOutPut,2),1);
P  =  zeros(size(ControlOutPut,2),1);
for i=1:size(ControlOutPut,2)
  u(i)  =  sum(ControlOutPut{i}.Output);
  P(i)  =  ControlOutPut{i}.Input(1);
end
figure(5)
plot(-u,-P,'-','LineWidth',4)
hold on
xx  =  linspace(min(-u),max(-u),100);
yy  =  P1*ones(length(xx));
plot(xx,yy,'--')
yy  =  P2*ones(length(xx));
plot(xx,yy,'--')
yy  =  P3*ones(length(xx));
plot(xx,yy,'--')
yy  =  P4*ones(length(xx));
plot(xx,yy,'--')
yy  =  P5*ones(length(xx));
plot(xx,yy,'--')
yy  =  P6*ones(length(xx));
plot(xx,yy,'--')

% x1 = max(-u)/2;
% y1 = P1;
% txt1 = 'P1';
% text(x1,y1,txt1)

x1 = max(-u)/2;
y1 = P2;
txt1 = 'P2';
text(x1,y1,txt1)

x1 = max(-u)/2;
y1 = P3;
txt1 = 'P3';
text(x1,y1,txt1)

x1 = max(-u)/2;
y1 = P4;
txt1 = 'P4';
text(x1,y1,txt1)

x1 = max(-u)/2;
y1 = P6;
txt1 = 'P6';
text(x1,y1,txt1)

ylabel('P\, (N)')
xlabel('x\, (m)')

grid on
set_latex_font(12)
%--------------------------------------------------------------------------
% Plot 6
%--------------------------------------------------------------------------
ControlOutPut  =  ControlOutPut6;
u  =  zeros(size(ControlOutPut,2),1);
P  =  zeros(size(ControlOutPut,2),1);
for i=1:size(ControlOutPut,2)
  u(i)  =  sum(ControlOutPut{i}.Output);
  P(i)  =  ControlOutPut{i}.Input(1);
end
figure(6)
plot(-u,-P,'-','LineWidth',4)
hold on
xx  =  linspace(min(-u),max(-u),100);
yy  =  P1*ones(length(xx));
plot(xx,yy,'--')
yy  =  P2*ones(length(xx));
plot(xx,yy,'--')
yy  =  P3*ones(length(xx));
plot(xx,yy,'--')
yy  =  P4*ones(length(xx));
plot(xx,yy,'--')
yy  =  P5*ones(length(xx));
plot(xx,yy,'--')
yy  =  P6*ones(length(xx));
plot(xx,yy,'--')

% x1 = max(-u)/2;
% y1 = P1;
% txt1 = 'P1';
% text(x1,y1,txt1)

x1 = max(-u)/2;
y1 = P2;
txt1 = 'P2';
text(x1,y1,txt1)

x1 = max(-u)/2;
y1 = P3;
txt1 = 'P3';
text(x1,y1,txt1)

x1 = max(-u)/2;
y1 = P4;
txt1 = 'P4';
text(x1,y1,txt1)

x1 = max(-u)/2;
y1 = P6;
txt1 = 'P6';
text(x1,y1,txt1)

ylabel('P\, (N)')
xlabel('x\, (m)')

grid on
set_latex_font(12)


asdf=98;                  
end
                  