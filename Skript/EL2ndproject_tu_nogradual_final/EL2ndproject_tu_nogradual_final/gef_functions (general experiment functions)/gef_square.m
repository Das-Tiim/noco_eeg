function mSquare = gef_square(isSquareS, dim, color, transp)

if nargin < 1 || isempty(isSquareS); isSquareS = 1; end
if nargin < 2 || isempty(dim); dim = 300; end
if nargin < 3 || isempty(color); color = [0 0 0]; end
if nargin < 4 || ismpty(transp); transp = 255; end

if isSquareS
    matrix(:,:,1) = ones(dim,dim)*color(1);
    matrix(:,:,2) = ones(dim,dim)*color(1);
    matrix(:,:,3) = ones(dim,dim)*color(1);
    matrix(:,:,4) = ones(dim,dim)*transp;
else
    matrix(:,:,1) = ones(dim,dim/2)*color(1);
    matrix(:,:,2) = ones(dim,dim/2)*color(1);
    matrix(:,:,3) = ones(dim,dim/2)*color(1);
    matrix(:,:,4) = ones(dim,dim/2)*transp;
end

mSquare = matrix;

end
