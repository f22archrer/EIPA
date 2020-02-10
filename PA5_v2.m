clc
clear all

% The script presents a solver for the wave equation.
%
% The solutions returned by this solver will have boundary conditions 
%  of amplitude=0 on all sides.
%
% The solver workers for a wave in 2D and it uses the Finite Difference 
% 	technique to model the wave. By default the number of nodes in each
%	dimension is 50 (nx=ny=50).

nx = 50;
ny = 50;

%%2.i)
G = sparse(nx*ny,nx*ny);
%%S = sparse(m,n)
    
for i = 1:50
    for j = 1:ny
        n = j + (i-1)*ny;
        
        if i == 1 || i == nx ||j == 1 || j == ny
            G(n, :) = 0;
            G(n, n) = 1;
            
        elseif i > 10 & i < 20 & j> 10 & j < 20
            G(n, n) = -2;  % 2.iX  -> -4 to -2 
            G(n, n+1) = 1;
            G(n, n-1) = 1;
            G(n, n+ny) = 1;
            G(n, n-ny) = 1;
        else
            G(n, n) = -4;  
            G(n, n+1) = 1;
            G(n, n-1) = 1;
            G(n, n+ny) = 1;
            G(n, n-ny) = 1;
        end
    end
end
figure(3) ;
spy(G,3)
[E, D] = eigs(G, 9, 'SM');  %%9 eigenvectors and values

Val = zeros(nx, ny, 9);
figure(4)

for m = 1:9
   Val(:, :, m) = reshape(E(:, m), nx, ny);
   subplot(3, 3, m)
   surf(Val(:, :, m))   %%Plot the eigenvectors using surf().
end