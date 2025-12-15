using LinearAlgebra

function rateval(z, F, b, c, d)
    H = F.H
    Q = F.Q
    n = size(H, 1)
    qb = Q' * b
    y = (z * I(n) - H) \ qb 
    x = Q * y
    
    dot(c, x) + d
end

function ratroots(A, b, c, d)
    n = size(A, 1)
    M = [A b; c' d]
    B = [I(n) zeros(n,1); zeros(1,n) 0.0]
    zs = eigvals(M, B)
    real_zs = [real(z) for z in zs if isfinite(z) && isreal(z) && abs(imag(z)) < 1e-10]

    real_zs
end