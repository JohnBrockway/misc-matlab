% function G = myJPEGCompress(f, T, D)
%
% Input
%    f is the input image, a 2D array of real numbers
%    T is the tile size to break the input image into
%    D is the size of the block of Fourier coefficients to keep
%      (Bigger values of D result in less loss, but less compression)
%
% Output
%    G is the compressed encoding of the image
%
% Example: If f is 120x120, then
%
%    G = myJPEGCompress(f, 10, 4);
%
% would return an array (G) of size 48x48.
%
function G = myJPEGCompress(f, T, D)

	[h,w] = size(f);  % returns the width and height of f
    
	G = zeros(floor(h/T)*D, floor(w/T)*D);
	
    for i = 0:floor(h/T)-1
	    for j = 0:floor(w/T)-1
		    txt = f(1+i*T:T+i*T, 1+j*T:T+j*T);
			dct = myDCT(txt);
			G(1+i*D:D+i*D, 1+j*D:D+j*D) = dct(1:D, 1:D);
		end
	end

    
