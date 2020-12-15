%Pivotlama yöntemi ile matris tersi hesabý.
%Dengeleme Hesabý 1, Ergün Öztürk, syf: 36

function c = pivot(b)

n = length(b(: , 1));

for k = 2 : n + 1
    for i = 1 : n
        for j = 1 : n
            if (i == (k - 1)) & (j == (k - 1))
                b(i , j , k) = 1 / b(k - 1 , k - 1 , k - 1);
            end
            if i ~= (k - 1)
                b(i , j , k) = b(i , j , k - 1) / b(k - 1 , k - 1 , k - 1);
            end
            if j ~= (k - 1)
                b(i , j , k) = - b(i , j , k - 1) / b(k - 1 , k - 1 , k - 1);
            end
            if (i ~= (k - 1)) & (j ~= (k - 1))
                b(i , j , k) = b(i , j , k - 1) - (b(i , k - 1 , k - 1) * b(k - 1 , j , k - 1)) / (b (k - 1 , k - 1 , k - 1));
            end
        end
    end
end
c = b(:, :, n + 1);