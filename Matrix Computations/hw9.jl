using LinearAlgebra
function solve_schrod_galerkin(Q)
    n, k = size(Q)
    h = 1 / (n + 1)
    T = SymTridiagonal(2 * ones(n), -ones(n - 1))  # Tridiagonal matrix
    xx = (1:n) / (n + 1)  # Mesh points
    d = xx .* (1 .- xx)  # Diagonal elements for D
    Dmat = Diagonal(d)  # D as diagonal matrix
    F = [x^2 + y^2 for x in xx, y in xx]  # Right-hand side matrix
    
    # Reduced matrices (O(n k^2) setup)
    hatT = Q' * (T * Q)
    hatD = Q' * (Dmat * Q)
    hatF = Q' * (F * Q)  # F*Q first to avoid O(n^3)
    
    # Form the k^2 x k^2 system
    Ik = Diagonal(ones(k))
    Asmall = kron(hatT, Ik) + kron(Ik, hatT) + h^2 * kron(hatD, hatD)
    bsmall = -h^2 * vec(hatF)
    
    # Solve for vec(X)
    x = Asmall \ bsmall
    U = reshape(x, k, k)
    
    U
end