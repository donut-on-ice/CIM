% k Nearest Neighbors

% functiile din acest fisier sunt preluate din cele de la link-ul urmator:
% https://git.osuv.de/m/fastKNN/src/branch/master/fastKNN.m
%{
    The MIT License (MIT)

    Copyright (c) 2016 Markus Bergholz

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
%}

% trained data should be a point per line and have an id at the end of each line
% new data should be just one line without id, code will ignore the rest of the lines
% k should be odd and not a multiple of the number of ids or numbers below the number of ids

function id=kNN(trained, newData, k)
	order = getOrderByDistance(trained(:, 1:end-1), newData);
	id = mode(trained(order(1:k), end));
end

function order=getOrderByDistance(points, newPoint)
	[~, order] = sort( sum( (points - newPoint(ones(size(points, 1), 1), :)).^2 , 2) );
end