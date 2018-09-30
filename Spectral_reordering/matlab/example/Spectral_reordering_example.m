% based on: Changes in connectivity profiles define functionally desitinct regions in
%human medial frontal cortex.PNAS: [orderedB]= SIN_Spectral_Reordering(B) 
clear

addpath(genpath('../code/'))

%generate data  
    %I generate timeseries (N voxels, t timesteps)
        N=20; % even!, corr matrix of size NxN
        t=100;% time samples
    %all voxels are dependent in two signals
        signal1=randn(1,t);
        signal2=randn(1,t);
    %half of voxels dependent on each of the two signals
    % and lambda is the dependence factor.
        m=N/2;
        lambda=0.8;    
    %I put data in x
        x(1,1:t)=signal1;
        for i=2:m
            x(i,:)=(1-lambda).* randn(1,t)+ (lambda .*signal1);
        end
        x(m+1,1:t)=signal2;
        for i=m+2:2*m
            x(i,:)=(1-lambda).* randn(1,t)+ (lambda .* signal2);
        end    
    %I call it data
    data=x';


%compute correlation
corrMatrix=corr(data); % we want to recover this ordered structure

%mix it 
    mix=randperm(N);
    B=corrMatrix(mix,:);
    B=B(:,mix);

%recover it    
[orderedB]= SIN_Spectral_Reordering(B); 


%Make a plot

figure(1);clf

subplot(3,1,1)
imagesc(corrMatrix)
title('Original Pattern')

subplot(3,1,2)
imagesc(B)
title('Randomized Original Pattern')


subplot(3,1,3)
imagesc(orderedB)
title('Reordered Pattern')


