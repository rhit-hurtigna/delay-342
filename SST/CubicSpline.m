function [z] = CubicSpline(x,y,v)
%function [z] = CubicSpline(x,y,v)
%INPUTS
% x -- A vector of length n, either as a row or a column, that specifies
%      the x-coordinates of the data.
% y -- A vector of length n, either as a row or a column, that specifies
%      the y-coordinates of the data.
% v -- An optional argument, with default value x. The cubic spline
%      will be evaluated at all the values in v.
%OUTPUTS
% z -- f(v) where f is the cubic spline of the x-y points given

lx = length(x);
if (lx ~= length(y))
    fprintf(2,"Error: x,y must be same size.\n");
    z = NaN;
    return;
end
sx=size(x);
if (sx(1)==1)
    x = x';
end
sy = size(y);
if (sy(1)==1)
    y = y';
end
if ~exist('v','var')
  v = x;
else
  sz = size(v);
  if sz(1)==1
      v=v';
  end
end

I = sortrows([x,y]);
x = I(:,1);
y = I(:,2);

delx = x(2:end) - x(1:end-1);
dely = y(2:end) - y(1:end-1);
delFrac = dely./delx;
b = 6*(delFrac(2:end)-delFrac(1:end-1));

A = zeros(lx-2);
A(1,1) = delx(1);
for i=2:lx-2
    A(i-1,i-1) =A(i-1,i-1)+delx(i);
    A(i-1,i)=delx(i);
    A(i,i)=delx(i);
end
A(lx-2,lx-2) = A(lx-2,lx-2)+delx(lx-1);
A = A+A';
s = zeros(lx,1);
s(2:end-1) = A\b;
s1Plus2s = ((s(2:end)+2*s(1:end-1)).*delx)/6;
dels = s(2:end)-s(1:end-1);
C = zeros(lx-1,4);
C(:,4)=y(1:end-1);
C(:,3) = delFrac-s1Plus2s;
C(:,2) = s(1:end-1)/2;
C(:,1) = (dels./delx)/6;

function [yp] = evalSpline(xp)
    if (xp < x(1) || xp > x(end))
        yp = 0;
        return;
    end
    [~,i]=max((x - xp) >= 0);
    i = max(1,i-1);
    yp=polyval(C(i,:),xp-x(i));
end

z = arrayfun(@(x) evalSpline(x),v);
end

