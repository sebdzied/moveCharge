%declaration of physical constants and initial conditions
%if you only want to play, please don't change anything
%if you want to run single simulation run test_run.n
%modifiable for advanced users, among other change of simulation conditions and game levels
global simulation

simulation.language = 1; %defualt 1 ENG / 2 PL

% choose simulation method 
% 1 - central central finite difference technique
% 2-  EULER method
% recommended first - more stable and accurate
simulation.method = 1; 
simulation.step=0.0001; % its time [s] if active 1st method
%simulation.step=0.01; % its the constant distance between by further points [m] if active EULER method

simulation.q=1.60217653*10^-19; %elementary charge value in coulombs [C]
simulation.m=9.10938*10^-31;  %elementary charge mass in [kg]
simulation.v=[0,100,0]; %initial velocity [m/s]
simulation.r=[0.5,0,0]; %coordinates initial charge location [m]
simulation.areaDim = [0,1;0,1]; %area (game board) dimision [x;y] [m]
simulation.current=0.001; %aeamperage in wires [A]

nrOfMesh = 50;
simulation.path = zeros(nrOfMesh,nrOfMesh);  % discretisation matrix 0,1 { 1 charge was at a given particular point / 0 wasnt};
simulation.gridSize=abs(simulation.areaDim(:,2) - simulation.areaDim(:,1)) ./ size(simulation.path)'; 

simulation.Rsmall= 0.01;  % radius smaller charge [m]
simulation.Rlarge = 0.02; %radius bigger charge  [m]
simulation.Rwire = 0.02;  %radius wire  [m]

simulation.maxLevel = 5;
simulation.level = [];
simulation.gameFlag=[]; % win or lose
simulation.nrOfAttempts = zeros(1,simulation.maxLevel);

simulation.isSimCorrect = []; % checking the correctness of performed calculations
simulation.rSaved = []; 

