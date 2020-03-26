% INFECT  Disease spread model
% by Jim Goodall, March 2020

clear
warning('off','map:geodesic:longGeodesic'); 

% Configuration
save_video = true;
planet = referenceEllipsoid('earth','m');
num_people = 500000;
marksize = 1;
marksize_infected = 5;
marksize_immune = 3;
stepsperday = 5;
airtravel_dist = 500000; % threshold for airtravel to prevent infectinbg people along route

%Disease config
length_days = 12; % 
midpoint_days = length_days/2; %
incubation_days = 2; %how long the pathogen stays in a person without inducing any symptoms
health_step = 0.1; 
death_rate = 0.01;

% Initialize map
load coastlines
geoshow(coastlat,coastlon)
hold on

% Generate individuals
minLAT = -55;
maxLAT = 60;
minLONG = -135;
maxLONG = 150;
LAT = minLAT + (maxLAT-minLAT).*rand(1,num_people);
LONG = minLONG + (maxLONG-minLONG)*rand(1,num_people);
Infected = false(1,num_people);
Contagious = false(1,num_people);
Immune = false(1,num_people);
DaysInfected = zeros(1,num_people);
Health = ones(1,num_people);
Health(randi(num_people,[1 ceil(num_people*death_rate)])) = 0.4;

% Generate infected individual
n = randi([1 num_people]);
Infected(n) = true;
LAT(n) = 30.5928;
LONG(n) = 114.3055;

% plot individuals
%healthy = plot(LONG(~Infected&~Immune),LAT(~Infected&~Immune),'k.','markersize',marksize);
infected = plot(LONG(Infected),LAT(Infected),'r.','markersize', marksize_infected);
%immune = plot(LONG(Immune),LAT(Immune),'g.','markersize', marksize_immune);
set(gcf,'units','normalized','outerposition',[0 0 1 1])

% Initialize video
if save_video
    vid1 = VideoWriter('Pandemic.mp4','MPEG-4');
    open(vid1);
end

for t = 1:365
    % Determine daily travel
    Direction = 360 .* rand(1,num_people);
        
    % Getting sick
    DaysInfected(Infected) = DaysInfected(Infected) + 1;
    filt_worsening = Infected & (DaysInfected < midpoint_days);
    Health(filt_worsening) = Health(filt_worsening) - health_step;
    
    % Getting contagious
    filt_contagious = (DaysInfected > incubation_days) & (DaysInfected < length_days);
    Contagious(filt_contagious) = true;
    Contagious(~filt_contagious) = false;
    
    % Recovering
    filt_recovering = Infected & (DaysInfected > midpoint_days) & (Health > 0) & (Health < 1);
    Health(filt_recovering) = Health(filt_recovering) + health_step;
    filt_recovered = (DaysInfected > length_days);
    Infected(filt_recovered) = false;
    Immune(filt_recovered) = true;

    % Sick people don't move
    filt_sick = (Health < 0.5);
    Mobility(filt_sick) = 0;            
    Mobility(~filt_sick) = lognrnd(7.5,2.5,1,nnz(~filt_sick));
    
    Step = Mobility./stepsperday;
    
    % Travel
    for hour = 1:stepsperday
        % Move hourly
        [LAT, LONG] = reckon(LAT, LONG, Step, Direction, planet);

        % Infect nearby individuals
        Idx = rangesearch([LAT' LONG'], [LAT' LONG'],  0.1);
        for n = 1:num_people
            if (Contagious(n)) && (Mobility(n) < airtravel_dist)
                for nearby = 1:size(Idx{n},2)
                    if ~Immune(Idx{n}(nearby))
                        Infected(Idx{n}(nearby)) = true;
                    end
                end
            end
        end
        clear Idx

        % Update graph
        % plot individuals
        title(['Pandemic - Day ' num2str(t) newline num2str(nnz(Infected)) ' Infected, ' num2str(nnz(Health <=0)) ' Deaths, ' num2str(nnz(Immune)) ' Recovered'])
        %healthy.YData = LAT(~Infected & ~Immune);
        %healthy.XData = LONG(~Infected & ~Immune);
        infected.YData = LAT(Infected);
        infected.XData = LONG(Infected);
        %immune.YData = LAT(Immune);
        %immune.XData = LONG(Immune);
        drawnow
        if save_video
            writeVideo(vid1,getframe(gcf));
        end
    end
    clear filt_*
end

if save_video
    close(vid1)
end

warning('on','map:geodesic:longGeodesic'); 
