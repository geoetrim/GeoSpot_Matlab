%Gauss yöntemi ile matris tersi hesaplama.
%Dengeleme Hesabý 1, Ergün Öztürk, syf: 42
% clear all; clc;

function [Qxx_gauss_ters , dx_gauss_ters] = gauss_ters(A,w)

n = length(A(1 , :));

for i = 1 : n
    
    b(1 , i) = A(1 , i); 
    c(i , 1) = A(i , 1) / A(1 , 1);
    c(i , i) = 1;

end

    b(2 , 2 : n) = A(2 , 2 : n) - c(2 , 1) * b(1 , 2 : n);
    c(3 : n , 2) = (A(3 : n , 2) - c(3 : n , 1) * b(1 , 2)) / b(2 , 2);    

for i = 3 : n
    for j = i : n
        for k = 1 : i-1
            A(k , n + 1) = c(i , k) * b(k , j);
            A(k , n + 2) = c(j , k) * b(k , i);
        end
        b(i , j) = A(i , j) - sum(A(: , n + 1));
        c(j , i) = (A(j , i) - sum(A(: , n + 2))) / b(i , i);
    end
        c(i , i) = 1;
end

    Qxx_gauss_ters = inv(b) * inv(c);
    dx_gauss_ters = inv(b) * inv(c) * w;
    
end