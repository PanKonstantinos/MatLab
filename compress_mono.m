function [B,er] = compress_mono(A,k)
if (isa(A,'double')~=1)
    A = im2double(A);
end
[U,S,V] = svd(A,'econ');
if (nnz(diag(S))>=k)
    U2 = U(:,1:k);
    S2 = S(1:k,1:k);
	V2 = V(:,1:k);
	B = U2*S2*V2';
else
	B = A;
end
er = norm(A-B,'fro');
end