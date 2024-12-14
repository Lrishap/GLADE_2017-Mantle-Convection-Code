load f000.txt
D = f000;
Y = D(1:128,2);
n=0;
for i=1:1:512
    for j=1:1:128
        n=n+1;
        T(j,i) = D(n, 3);
        IG(j,i) = D(n, 4);
        P(j, i) = D(n, 5);
        V(j, i) = D(n, 6);
        ED(j, i) = D(n, 7);
        if (j==128)
            X(i) = D(n,1);
        end
    end
end

figure(1)
contourf(X,Y,T)
colorbar


figure(2)
contourf(X,Y,IG)
colorbar


figure(3)
contourf(X,Y,P)
colorbar

figure(4)
contourf(X,Y,log10(V))
colorbar

figure(5)
contourf(X,Y,ED)
colorbar




