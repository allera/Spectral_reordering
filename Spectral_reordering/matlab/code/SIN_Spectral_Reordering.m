function [orderedB]= SIN_Spectral_Reordering(B)
%[orderedB]= SIN_Spectral_Reordering(B)
%
%INPUT: B is a correlation matrix
%
%OUTPUT: orderedB is the spectrally reordered version of B. 
%
%Based on: Changes in connectivity profiles define functionally desitinct regions in
%human medial frontal cortex (PNAS). 
%
%Implemented by Alberto Llera, a.llera@donders.ru.nl
%Statistics in Neuroimaging Group
%Donders Center for Brain Cognition and Behaviour
%
% % Illustrative Example:
%     %generate data
%             %I generate timeseries (N voxels, t timesteps)
%                 N=20; % even!, corr matrix of size NxN
%                 t=100;% time samples
%             %all voxels are dependent in two signals
%                 signal1=randn(1,t);
%                 signal2=randn(1,t);
%             %half of voxels dependent on each of the two signals
%             % and lambda is the dependence factor.
%                 m=N/2;
%                 lambda=0.8;    
%             %I put data in x
%                 x(1,1:t)=signal1;
%                 for i=2:m
%                     x(i,:)=(1-lambda).* randn(1,t)+ (lambda .*signal1);
%                 end
%                 x(m+1,1:t)=signal2;
%                 for i=m+2:2*m
%                     x(i,:)=(1-lambda).* randn(1,t)+ (lambda .* signal2);
%                 end 
%             %I call it data
%             data=x';
%             %compute correlation
%             corrMatrix=corr(data); % we want to recover this ordered structure
%             %mix it 
%             mix=randperm(N);
%             B=corrMatrix(mix,mix);  
%     %run this function
%     [orderedB]= SIN_Spectral_Reordering(B);    
%     %plot results
%     figure(1);clf
%     subplot(3,1,1);imagesc(corrMatrix);title('Original Pattern')
%     subplot(3,1,2);imagesc(B);title('Randomized Original Pattern')
%     subplot(3,1,3);imagesc(orderedB);title('Reordered Pattern')











%add one to make all postive entries
    C=B+1;

%compute Q
    Q=-C;%init Q
    Q=Q-diag(diag(Q));%zeros in diagonal
    tmp=sum(Q);
    Q=Q-diag(tmp);

%compute t
    tmp2=1./sqrt(sum(C));
    t=diag(tmp2);

%compute D
    D=t*Q*t;

%eigevalue decomposition
    [W D]=eig(D);
    v=W(:,2);

%scale v
    v2=t*v;

%find the searched permutation p
    [orderedv2 permutation]=sort(v2,'ascend');

% Reorder B ;)
    orderedB=B(permutation,:);
    orderedB=orderedB(:,permutation);


end