function ArcLengthPostProcessingv2

CodePath  =  'P:\TopologyCode\code'; 
JobsPath  =  'P:\TopologyCode\jobs\MBBv2';
InputPath =  'P:\TopologyCode\jobs\MBBv2\input_file';
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
jobfolder  =  'P:\TopologyCode\jobs\Benchmark1\resultsVolume_fraction_0.4_MooneyRivlin_model_load_factor_0.0045';
addpath(genpath(fullfile(jobfolder)));
load_    =  251;
cd(jobfolder);  
load(['Results_Optimisation_Iteration_' num2str(load_) '.mat']);
UserDefinedFuncs.ArcLengthControl   =  @UserDefinedArcLength;    
ControlOutPut1    =  ArcLengthNewtonRaphson(Data,NR,Geometry,Mesh,UserDefinedFuncs,...
                              Bc,FEM,Quadrature,MatInfo,Optimisation,...
                              TimeIntegrator,'~',0);
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
plot(u(1:40),P(1:40),'-','LineWidth',4)
hold on
xx  =  linspace(min(u(1:40)),max(u(1:40)),100);
P1  = 4.5e-6;
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
end
