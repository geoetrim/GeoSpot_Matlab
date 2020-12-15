% W.H. Press, S.A. Teukolsky, W.T. Vetterling and B.P. Flannery (2002),
% < Numerical Recipes in C, The Art of Scientific Computing >
% Second Edition, Cambridge University Press, ISBN 0-521-43108-5.
% page 64 . svbksb algorithm .

% Solves A·X = B for a vector X, where A is specified by the arrays u[1..m][1..n], w[1..n],
% v[1..n][1..n] as returned by svdcmp. m and n are the dimensions of a, and will be equal for
% square matrices. b[1..m] is the input right-hand side. x[1..n] is the output solution vector.
% No input quantities are destroyed, so the routine may be called sequentially with different b’s.

% Matlab codes are modified by O. KURT (12.09.2007), Kocaeli University, Kocaeli/Turkey
% A x = b --> U W V' x = b
%                    x = V W-1 U' b
%                   Qx = V W-2 V'
function [ x , Qx ] = Ax_b( A , b, Threshold ); % A x = b --
    [ m , n ] = size( A ) ;
	tmp = zeros(1,n) ;
    [ U , W , V ] = svd( A ) ;      %... OK
    %Mtrx('U',U,'%10.4f');Mtrx('V',V,'%10.4f');Mtrx('W',W,'%10.4f');
	for j=1:n
		s = 0 ;
		if ( W(j,j) > Threshold ) 
			for i=1:m
                s = s + U(i,j) * b(i) ;
            end
            W(j,j) = 1 / W(j,j) ; % W = W^(-1)
			s =  s * W(j,j) ;       
        end
		tmp( j ) = s ;
    end
    %Mtrx('W',W,'%10.4f');
	for j=1:n
		s = 0 ;
		for k=1:n
            s = s + V(j,k) * tmp(k);
        end
		x(j,1) = s ;
    end
    if ( m > n )
        %... Qx = V W^(-2) V'
	    for i=1:n
		    for j=1:i
			    s = 0 ;
                for k=1:n
                    s = s + V(i,k) * W(k,k)^2 * V(j,k) ;
                end
			    Qx(j,i) = s ; Qx(i,j) = s ;
            end    
        end
    elseif ( m == n )
         %... Qx = V W^(-1) U'
 	    for i=1:n
 		    for j=1:i
 			    s = 0 ;
                 for k=1:n
                     s = s + V(i,k) * W(k,k) * U(j,k) ;
                 end
			    Qx(j,i) = s ; Qx(i,j) = s ;
            end    
        end
    end
    %Mtrx('Qx',Qx,'%10.4f');
return

