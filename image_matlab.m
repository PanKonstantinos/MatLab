A = imread('CHNCXR_0096_0.png');
I = im2double(A);
whos A
whos I
figure(1);
imshow(I);

tic;
[U,S,V] = svd(I,'econ');
toc;

R = diag(S);
ran = nnz(R);%RANK of A = non zero elements of diag(S)
% sigma = var(S);
semilogy(R);


k = [2,10,30,500];
%Where kmine = 500
% ==================== I2: k(1) = 2 =========================================
figure(2);
U2 = U(:,1:k(1));
S2 = S(1:k(1),1:k(1));
V2 = V(:,1:k(1));
I2 = U2*S2*V2';
imshow(I2);
err(1) = norm(I-I2,'fro');
E(1) = S(k(1)+1,k(1)+1);
% ==================== I3: k(2) = 10 ========================================
figure(3);
U3 = U(:,1:k(2));
S3 = S(1:k(2),1:k(2));
V3 = V(:,1:k(2));
I3 = U3*S3*V3';
imshow(I3);
err(2) = norm(I-I3,'fro');
E(2) = S(k(2)+1,k(2)+1);
% ==================== I4: k(3) = 30 ========================================
figure(4)
U4 = U(:,1:k(3));
S4 = S(1:k(3),1:k(3));
V4 = V(:,1:k(3));
I4 = U4*S4*V4';
imshow(I4);
err(3) = norm(I-I4,'fro');
E(3) = S(k(3)+1,k(3)+1);

% ==================== I5: k(4) = kmine =====================================
figure(5)
U5 = U(:,1:k(4));
S5 = S(1:k(4),1:k(4));
V5 = V(:,1:k(4));
I5 = U5*S5*V5';
imshow(I5);
err(4) = norm(I-I5,'fro');
E(4) = S(k(4)+1,k(4)+1);

plot(k,err,k,E)
legend('DisplayName',{'Norm 2' 'Norm F'})
xlabel('Rank (k)')
ylabel('Error')

sizes(5) = ((size(U,1)*size(U,2))+(size(S,1)*size(S,2))+(size(V,1)*size(V,2)))*8;
sizes(1) = ((size(U2,1)*size(U2,2))+(size(S2,1)*size(S2,2))+(size(V2,1)*size(V2,2)))*8; 
sizes(2) = ((size(U3,1)*size(U3,2))+(size(S3,1)*size(S3,2))+(size(V3,1)*size(V3,2)))*8; 
sizes(3) = ((size(U4,1)*size(U4,2))+(size(S4,1)*size(S4,2))+(size(V4,1)*size(V4,2)))*8; 
sizes(4) = ((size(U5,1)*size(U5,2))+(size(S5,1)*size(S5,2))+(size(V5,1)*size(V5,2)))*8; 