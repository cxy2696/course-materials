function poisson_dst(n, f)
	F = grid_sample(n, f)
    h = 1.0 / (n + 1)
	h2 = h * h
    lambda = λ1D(n)
    tilde_F = dst(F)
    tilde_U = similar(tilde_F)
    for j = 1:n, k = 1:n
        tilde_U[j, k] = -h2 * tilde_F[j, k] / (lambda[j] + lambda[k])
    end
    U = dst(tilde_U)

	U
end

function schrodinger_iter(W, F, U, nsteps)
	n = size(F, 1)
    h = 1.0 / (n + 1)
    T = T1D(n)
    lambda = λ1D(n)
    resids = Float64[]
    for step = 1:nsteps
        G = F + W .* U
        tilde_G = dst(G)
        tilde_U = similar(tilde_G)
        for j = 1:n, k = 1:n
            tilde_U[j, k] = -h^2 * tilde_G[j, k] / (lambda[j] + lambda[k])
        end
        U = dst(tilde_U)
        R = T * U + U * T + h^2 * (W .* U + F)
        push!(resids, norm(R) / norm(F))
    end
    U, resids
end