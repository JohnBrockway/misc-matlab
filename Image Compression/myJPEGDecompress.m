% function f = myJPEGDecompress(G, T, D)
%
% Input
%    G is the compressed encoding, a 2D array of real numbers
%    T is the tile size for reassembling the decompressed image
%    D is the size of the blocks of Fourier coefficients that were
%      kept when the image was compressed
%      (Bigger values of D result in less loss, but less compression)
%
% Output
%    f is the decompressed, reconstructed image
%
% Example: If G is 48x48, then
%
%    f = myJPEGDecompress(G, 10, 4);
%
% would return an array (f) of size 120x120.
%
function f = myJPEGDecompress(G, T, D)

    [h,w] = size(G);  % returns the width and height of f
    
	f = zeros(h*T/D, w*T/D);
	
    for i = 0:h/D-1
	    for j = 0:w/D-1
		    dxd = G(1+i*D:D+i*D, 1+j*D:D+j*D);
			txt = zeros(T, T);
			txt(1:D, 1:D) = dxd;
			idct = myIDCT(txt);
			f(1+i*T:T+i*T, 1+j*T:T+j*T) = idct;
		end
	end
    
