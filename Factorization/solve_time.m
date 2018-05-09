%
% solve_time.m
%
% Solve NxN systems using 2 methods, for various sizes of N.
 
Ns = 10:1:200;
M = 20;
 
% Store the timing results here
t_method1 = zeros(size(Ns));
t_method2 = zeros(size(Ns));
 
idx = 1;
 
% Loop over N-values (for both methods)
% Generate random A and B
 
for N = Ns
    % Generate random matrices
    A = rand(N);
    B = rand(N,M);
    X = zeros(size(B)); % allocate space for X
     
     
    % === Method 1 ===
    tic;
     
    for i = 1:M
        X(:,i) = A\B(:,i);
    end
     
    t_method1(idx) = toc;  % Use tic and toc to measure time
     
     
    % === Method 2 ===
    tic;

    % Compute LU factorization, then use it to solve each of the M vector
    % systems.
    
    [L,U,P] = lu(A);
    
    for i = 1:M
        z = L\B(:,i);
        X(:,i) = U\z;
    end
     
    t_method2(idx) = toc;
     
    idx = idx + 1;
     
end
 
 
%% Plot
 
% Plot both lines on one axis.
% Be sure to label your plot.

t_method1.'
t_method2.'