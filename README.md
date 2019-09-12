# MatLab
Matlab code for Image compression with SVD
This code works good only if "cuts" to create the sub-matrices are fewer than the rows/columns you are trying to fit.
For example:

if matrix A is the one you are trying to compress and is A(2080x2119) and you try to cut it  in a pxp (e.g. 2x2) matrix so:
div(m,p) = 1040 and mod(m,p) = 0
div(n,p) = 1059 and mod(m,p) = 1 
A11 = (1040x1059)
A12 = (1040x1060)
A21 = (1040x1059)
A22 = (1040x1060)

But it will not work if p is too big. For example if div(m,p) < p or div(n,p) < p
