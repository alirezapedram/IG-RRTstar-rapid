function [ d12, dInf, P_prime_list ] = dist_ig_mat( x1_mat,P1_mat,x2,P2,alpha,R)
% This Function computes the total cost = Euclidean+ Info gain
% from nodes in (x1_mat, P1_mat) to node (x,P)
% d12 is the total cost 
% dInf is the information cost
% P_prime_list is the minimizer of the optimization program in the
% definition of total cost 

d_cont = sqrt( sum( (x2 - x1_mat ).^2, 1) );
num_dcont = numel(d_cont);

d12 = zeros(1, num_dcont);
dInf = zeros(1, num_dcont);
P_prime_list = zeros(2, 2, num_dcont);

%inv_P2 = inv(P2);

for j = 1:num_dcont
    P_hat = P1_mat(:,2*(j-1)+1:2*j) + R*d_cont(j);


    P_prime = Q_hat_sol(P_hat, P2);    

    P_prime( abs(P_prime) < 10^-14 ) = 0;
    P_prime_list(:,:,j) = P_prime;
    
    dInf(1,j) = (alpha/2)*(log2(det(P_hat))-log2(det(P_prime)));
    d12(1,j) = d_cont(j) + dInf(1,j);
end