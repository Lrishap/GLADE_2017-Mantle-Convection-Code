for k = 0:153
    filename1 = sprintf('ha%03d.txt',k);
    filename2 = sprintf('f%03d.txt',k);
    H = load(filename1);
    Y = H(1:128, 2);
    time(k+1) = H(1, 1);
    T = H(1:128, 3);
    V = H(1:128, 9);

%Getting respective i for given value of y
    for i =1:126
        slope(i) = (V((i+2)) - V(i))./(Y(i+2)-Y(i));
    end
    s = min(slope);
    x = max(find(slope == min(slope(:))));
    y1 = Y(x);
    v1 = V(x);
    c = v1 - (s*y1);
    y = (-c)/s;
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
%Avergage Calculations
    F = load(filename2);
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
    p1 = [row, column];
    A = size(p1,1);
    n =0;
    for i = 1:1:A
        n = n+1;
        D(i)= ED(p1(i,1), p1(i,2));
    end
%Calculating the Average
    M1(k+1) = max(D);
    sumD = sum(D);
    dy = Yn(2,1)- Yn(1, 1);
    dxdy = dy^2;
    Area = A * dxdy;
    Avg1(k+1) = (sumD *dxdy)/ Area;

%Avg ED below lid
    [row, column] = find(Tn > t);
    p2 = [row, column];
    B = size(p2, 1);
    n =0;
    for i = 1:1:B
        n = n+1;
        D(i)= ED(p2(i,1), p2(i,2));
    end
%Calculating the Average
    M2(k+1) = max(D);
    sumD = sum(D);
    dy = Yn(2,1)- Yn(1, 1);
    dxdy = dy^2;
    Area = B * dxdy;
    Avg2(k+1) = (sumD *dxdy)/ Area;
end
Final(1:154,1) = time;
Final(1:154,2) = M1;
Final(1:154,3) = Avg1;
Final(1:154,4) = M2;
Final(1:154, 5) = Avg2;




    
    
  
    

    

    