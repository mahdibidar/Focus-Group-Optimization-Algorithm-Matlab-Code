function y = Dejoung( xx )

x1 = xx(1);
x2 = xx(2);
sum = 0;

A = zeros(2, 25);
a = [-32, -16, 0, 16, 32];
A(1, :) = repmat(a, 1, 5);
ar = repmat(a, 5, 1);
ar = ar(:)';
A(2, :) = ar;

for ii = 1:25
    a1i = A(1, ii);
    a2i = A(2, ii);
    term1 = ii;
    term2 = (x1 - a1i)^6;
    term3 = (x2 - a2i)^6;
    new = 1 / (term1+term2+term3);
    sum = sum + new;
end

y = 1 / (0.002 + sum);


end

