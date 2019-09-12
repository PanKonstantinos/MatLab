function [B,ER]= compress_multi(A,p,K)
%K = Rank matrix for reconstruction of A
if (isnumeric(p)==0 || (int8(p) < 0))
    fprintf('p is not acceptable.\n')
    return
else
%     p = int8(p);
    [m,n] = size(A);
    if((m<p) || (n<p))
        fprintf('%dx%d is more than %dx%d\n',p,p,m,n)
        return
    end

%======== if A is not double ===========        
    if (isa(A,'double')~=1)
        A = im2double(A);
    end
% ======= div,mod  div = fix() in Matlab ================ 
    B = zeros(size(A));
    ER = zeros(size(K));
% ======= mod(m,p)=0 , mod(n,p)=0 =========
    if((fix(m/p)>p) && (fix(n/p) > p))
        if(mod(m,p)==0 && mod(n,p)==0)
            r = 1; % index for j in K(i,j)
            fprintf('Running No 1')
            for j=0:(fix(n/p)):(n-fix(n/p))
                q = 1; % index for i in K(i,j)
                for i=0:(fix(m/p)):(m-fix(m/p))
                    [I,Err] = compress_mono(A((i+1):i+fix(m/p),(j+1):j+fix(n/p)),K(q,r));
                    B((i+1):i+fix(m/p),(j+1):j+fix(n/p)) = I;
                    ER(q,r) = Err; 
                    q = q+1;
                end
                r = r+1;
            end
    % ======= mod(m,p)~=0 , mod(n,p)=0 =========
        elseif(mod(m,p)~=0 && mod(n,p)==0)
            r = 1; % index for j in K(i,j)
            fprintf('Running No 2')
            for j=0:(fix(n/p)):(n-fix(n/p))
                q = 1; % index for i in K(i,j)
                for i=0:(fix(m/p)):(m-(2*fix(m/p)))
                    [I,Err] = compress_mono(A((i+1):i+fix(m/p),(j+1):j+fix(n/p)),K(q,r));
                    B((i+1):i+fix(m/p),(j+1):j+fix(n/p)) = I;
                    ER(q,r) = Err; 
                    q = q+1;
                end
                [I,Err] = compress_mono(A((i+fix(m/p)+1):end,(j+1):j+fix(n/p)),K(q,r));
                B((i+fix(m/p)+1):end,(j+1):j+fix(n/p)) = I;
                ER(q,r) = Err;
                r = r+1;
            end
    % ======= mod(m,p)=0 , mod(n,p)~=0 =========
        elseif(mod(m,p)==0 && mod(n,p)~=0)
            q = 1; % index for i in K(i,j)
            fprintf('Running No 3')
            for i=0:(fix(m/p)):(m-fix(m/p))
                r = 1; % index for i in K(i,j)
                for j=0:(fix(n/p)):(n-(2*fix(n/p)))
                    [I,Err] = compress_mono(A((i+1):i+fix(m/p),(j+1):j+fix(n/p)),K(q,r));
                    B((i+1):i+fix(m/p),(j+1):j+fix(n/p)) = I;
                    ER(q,r) = Err; 
                    r = r+1;
                end
                [I,Err] = compress_mono(A((i+1):i+fix(m/p),(j+fix(n/p)):end),K(q,r));
                B((i+1):i+fix(m/p),(j+fix(n/p)):end) = I;
                ER(q,r) = Err; 
                q = q+1;
            end
    % ======= mod(m,p)~=0 , mod(n,p)~=0 =========
        elseif(mod(m,p)~=0 && mod(n,p)~=0)
            fprintf('Running No4')
            r = 1; %index for i in K(r,q)
            for j=0:(fix(n/p)):(n-2*fix(n/p))
                q = 1;
                for i=0:(fix(m/p)):(m-(2*fix(m/p)))
                    [I,Err] = compress_mono(A((i+1):(i+fix(m/p)),(j+1):(j+fix(n/p))),K(q,r));
                    B((i+1):(i+fix(m/p)),(j+1):(j+fix(n/p))) = I;
                    ER(q,r) = Err;
                    q = q+1;
                end
                [I,Err] = compress_mono(A((i+fix(m/p)+1):end,(j+1):(j+fix(n/p))),K(q,r));
                B((i+fix(m/p)+1):end,(j+1):(j+fix(n/p)))=I;
                ER(q,r) = Err;
                r = r+1;
            end

            q = 1;
            for i=0:(fix(m/p)):(m-(2*fix(m/p)))
                [I,Err] = compress_mono(A((i+1):(i+fix(m/p)),((j+fix(n/p))+1):end),K(q,r));
                B((i+1):(i+fix(m/p)),((j+fix(n/p))+1):end)=I;
                ER(q,r) = Err;
                q = q+1;
            end
            [I,Err] = compress_mono(A((i+fix(m/p)+1):end,(j+fix(n/p)+1):end),K(q,r));
            B((i+fix(m/p)+1):end,(j+fix(n/p)+1):end) = I;
            ER(q,r) = Err;

        end
 %-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
    else
        fprintf('Sory...div(m,p) or div(n,p) is smaller than p itself\n')
    end
end
end
