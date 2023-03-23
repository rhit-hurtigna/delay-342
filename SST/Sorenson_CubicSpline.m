%
% Elliya Sorenson
% Cubic splines code
%
% I pledge this is my code and that it is submitted with all due
% ethical standards.
%
function [z]=Sorenson_CubicSpline(x, y, varargin)
% Initilizations and sorting
[x_sorted,idx] = sort(x);
[rows, cols] = size(x);
len = max(rows, cols);
y_sorted = y(idx);
z = x;

% Calculate dx
dx = diff(x_sorted);

% Form the matrix A
A = diag(2*(dx(2:end)+dx(1:end-1)))...
    +diag(dx(2:end-1), 1)...
    +diag(dx(2:end-1), -1);

% Calculate b used to solve A
r = diff(y_sorted)./dx;
b = zeros(len-2, 1);
b(1:end) = 6*(r(2:end)-r(1:end-1));

% Calculate and form s
s = A\b;
s = s';
s = [0 s 0];

% Calculate a, b, c, and d
a = y_sorted(1:end-1);
b = r - ((s(2:end)+2*s(1:end-1))/6).*dx;
c = s(1:end-1)./2;
d = diff(s)./(6*dx);

% Check inputs and check v
if ~isempty(varargin)
    v = varargin{1};
else
    % Default condition
    v = x;
end

% Initialize v related variables
[v_rows, v_cols]=size(v);
len_varargin = max(v_rows, v_cols);
z = zeros(1, len_varargin);

% Loop through v to calculate corresponding z
for p=1:len_varargin
    % Find correct interval
    for f=1:len-1
        % Correct interval found
        if v(p) <= x_sorted(f+1) && v(p) >= x_sorted(f)
            % Calculate z(p) based on a, b, c, and d
            z(p)=a(f)+b(f)*(v(p)-x_sorted(f))+c(f)*(v(p)-x_sorted(f))^2+d(f)*(v(p)-x_sorted(f))^3;
        end
    end
end
% Format the output
z=z';