%Burada ölçülerle bilinmeyenler arasýndaki korelasyon hesaplanmaktadýr (Bknz:
%[1] Mikhail, 1976, syf: 116
%[2] Öztürk ve Þerbetçi, 1992, syf: 235

function korlp = Qlv(A, B, Qxx);

    N1 = B * B'; %[1] nolu kaynakta "N"
    
    N2 = A' * inv(B * B') * A; %[2] nolu kaynakta "N"
    
%     Qll = eye(size(B)) - B' * inv(N1) * B + B' * inv(N1) * A * inv(A' * inv(N1) * A) * A' * inv(N1) * B; %[2] nolu kaynak
    
    Qld_1 = - B' * inv(N1) * A * inv(N2);
    
    for j = 1 : length(Qld_1(1 , :))
        for i = 1 : 2
            korlp (i , j) = Qld_1(i , j) / sqrt(Qxx(j , j)); %Qll = I olduðundan.
        end
    end