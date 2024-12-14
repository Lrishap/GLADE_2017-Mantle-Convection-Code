load f005.txt

load ha001.txt
H = ha001;
Y = H(1:128, 2);
T = H(1:128, 3);
V = H(1:128, 9);


for i =1:126
    slope(i) = (V((i+2)) - V(i))./(Y(i+2)-Y(i));
end
s = min(slope);
x = find(slope == min(slope(:)));

y1 = Y(x);
v1 = V(x);
c = v1 - (s*y1);
y = (-c)/s;

%Getting respective i for given value of y
 i = 128*y + (1/2);
%Parameters for linear interpolation
i1 = floor(i);
i2 = ceil(i);

Y1 = Y(i1, 1);
Y2 = Y(i2, 1);
T1 = T(i1, 1);
T2 = T(i2, 1);

%Linear Interpolation
t = T1 + (y - Y1)*((T2-T1)/(Y2-Y1));

load f000.txt;
F = f000;
Yn = F(1:128, 2);
n=0;
for i=1:1:512
    for j=1:1:128
        n=n+1;
        Tn(j,i) = F(n, 3);
        ED(j, i) = F(n, 7);
        if (j==128)
            X(i) = F(n,1);
        end
    end
end

% Avg. ED above lid
[row, column] = find(Tn < t);
p = [row, column];
n =0;
for i = 1:1:11303
        n = n+1;
        D(i)= ED(p(i,1), p(i,2));
end
%Calculating the Average
M = max(D);
sumD = sum(D);
dy = Yn(2,1)- Yn(1, 1);
dxdy = dy^2;
Area = 11303 * dxdy;
Avg = (sumD *dxdy)/ Area

%Avg ED below lid
[row, column] = find(Tn > t);
p = [row, column];
n =0;
for i = 1:1:11303
        n = n+1;
        D(i)= ED(p(i,1), p(i,2));
end
%Calculating the Average
M = max(D);
sumD = sum(D);
dy = Yn(2,1)- Yn(1, 1);
dxdy = dy^2;
Area = 11303 * dxdy;
Avg = (sumD *dxdy)/ Area








