using LinearAlgebra
function p4eval(z, F, b, c, d)
    n = size(F.H, 1)
    Id = I(n)
    Q = F.Q
    H = F.H
    qb = Q' * b
    w = (z * Id - H) \ qb
    v = Q * w
    f = c' * v + d
    uu = (z * Id - H) \ w
    df = -c' * (Q * uu)
    
    f, df
end

function p4critical(A, b, c, d)
    n = size(A, 1)
    S = zeros(2n + 1, 2n + 1)
    # Order: v (1:n), u (n+1:2n), s (2n+1)
    S[1:n, 1:n] = A          # A v
    S[1:n, 2n+1] = b         # b s
    S[n+1:2n, n+1:2n] = A    # A u
    S[n+1:2n, 1:n] = I(n)    # v
    S[2n+1, n+1:2n] = c'     # c^T u
    L = zeros(2n + 1, 2n + 1)
    L[1:n, 1:n] = I(n)
    L[n+1:2n, n+1:2n] = I(n)
    evs = eigvals(S, L)
    finite_real = filter(e -> isfinite(e) && isreal(e), evs)
    zs = sort(real.(finite_real))
    
    zs
end

function polyinv(F, d)
    n = size(F, 1)
    A = I(n) - F
    Phi = zeros(n*n, d+1)
    A_power = A  
    for i in 1:(d+1)
        Phi[:, i] = vec(A_power)
        A_power = A_power * A
    end
    target = vec(Matrix(I(n)))
    c = Phi \ target
    
    c
end