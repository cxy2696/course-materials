### A Pluto.jl notebook ###
# v0.20.17

using Markdown
using InteractiveUtils

# ╔═╡ ca0206b9-e4ee-4f5f-8685-80efaf7ff0ba
using LinearAlgebra

# ╔═╡ 97e46e8a-227b-11ed-3ad4-bf493f45d214
md"""
# HW10 for CS 6210

You may (and probably should) talk about problems with the each other, with the TA, and with me, providing attribution for any good ideas you might get. Your final write-up should be your own.
"""

# ╔═╡ 22f06cec-14ac-434b-865a-8f360f09fb62
md"""
## 1. Your turn

Submit a course evaluation!  I can see if you have submitted an evaluation (even if I don't see what it is).  This is worth 2 points on the final grade.
"""

# ╔═╡ 87d3be02-41fe-4222-ae6c-ae207e5649aa
md"""
## 2. Scaled iteration

Suppose $A = QR$ is an economy QR decomposition for $A \in \mathbb{R}^{m \times n}$ a tall thin matrix of full column rank.  Consider the stationary iteration

$$x^{(k+1)} = R^{-1} (Q^T b - \lambda R^{-T} x^{(k)})$$

Suppose $x^{(0)} = 0$.  Then write the other iterates $x^{(k)}$ in the form $x^{(k)} = V f_k(\Sigma) U^T b$ where $A = U \Sigma V^T$ is the economy SVD.  For what range of $\lambda$ does the iteration converge?
"""

# ╔═╡ cc076c1e-92c0-4207-b97c-83d3d9f4d139
md"""
Note that $A^T A = R^T R$, so $R^T R$ is symmetric positive definite (SPD) since $A$ has full column rank. The iteration can be rewritten as $x^{(k+1)} = s - \lambda P x^{(k)}$ where $s = R^{-1} Q^T b$ and $P = R^{-1} R^{-T}$.

Can verify that $P = (A^T A)^{-1} = (R^T R)^{-1}$ because $P^{-1} = (R^{-1} R^{-T})^{-1} = R^T R = A^T A$ Also, $s = (A^T A)^{-1} A^T b$, which is the least-squares solution to $A x = b$.

Starting from $x^{(0)} = 0$:

$$x^{(1)} = s$$

$$x^{(2)} = s - \lambda P s$$

$$x^{(3)} = s - \lambda P (s - \lambda P s) = s - \lambda P s + \lambda^2 P^2 s$$
and in general $x^{(k)} = \sum_{j=0}^{k-1} (-\lambda)^j P^j s$

use the SVD $A = U \Sigma V^T$. Then $A^T A = V \Sigma^2 V^T, \quad P = (A^T A)^{-1} = V \Sigma^{-2} V^T$, $P^j = V \Sigma^{-2j} V^T$

Also $A^T b = V \Sigma U^T b, \quad s = V \Sigma^{-1} U^T b$

Thus $P^j s = V \Sigma^{-2j} V^T \cdot V \Sigma^{-1} U^T b = V \Sigma^{-2j-1} U^T b$, $x^{(k)} = V \left( \sum_{j=0}^{k-1} (-\lambda)^j \Sigma^{-2j-1} \right) U^T b$

The term in parentheses is $\sum_{j=0}^{k-1} (-\lambda)^j \Sigma^{-2j-1} = \Sigma^{-1} \sum_{j=0}^{k-1} \left( -\lambda \Sigma^{-2} \right)^j$ (Operations are elementwise on the diagonals.) Thus, $f_k(\Sigma) = \Sigma^{-1} \sum_{j=0}^{k-1} \left( -\lambda \Sigma^{-2} \right)^j$

For convergence as $k \to \infty$, the infinite series $\sum_{j=0}^{\infty} r_i^j$ must converge for each ratio $r_i = -\lambda / \sigma_i^2$, requiring $|r_i| < 1$ for all $i$, i.e., $\left| \frac{\lambda}{\sigma_i^2} \right| < 1 \quad \forall i$

This holds if $|\lambda| < \min_i \sigma_i^2 = \sigma_n^2$ (the smallest singular value squared).
"""

# ╔═╡ 7e3dfbbd-690f-43d5-8e17-7e77e13a4168
md"""
## 3. Rational roots

Consider a rational function of the form

$$f(z) = c^T (zI-A)^{-1} b + d$$

Write a routine `rateval(z, F, b, c, d)` to compute $f(z)$ in $O(n^2)$ time given the precomputed Hessenberg factorization from `F = hessenberg(A)`.

Note that we can write this by as $f(z) = c^T u$ where $u = (zI-A)^{-1} b$, or equivalently

$$(A-zI) u + b = 0.$$

Putting it all together, we have

$$\begin{bmatrix} A-zI & b \\ c^T & d \end{bmatrix} \begin{bmatrix} u \\ 1 \end{bmatrix}
 = \begin{bmatrix} 0 \\ f(z) \end{bmatrix}.$$

The function call `eigvals(A,B)` finds all solutions of the eigenvalue problem $Ax = \lambda Bx$.  Using this function, write a routine `ratroots(A, b, c, d)` to compute all the *real* zeros of $f$.

You should check correctness of the roots returned by `ratroots` using the fast evaluation code from `rateval`.
"""

# ╔═╡ 2f9cf6c0-7515-4d20-9508-73d8f3eff1c7
function rateval(z, F, b, c, d)
    H = F.H
    Q = F.Q
    n = size(H, 1)
    qb = Q' * b
    y = (z * I(n) - H) \ qb 
    x = Q * y
    
    dot(c, x) + d
end

# ╔═╡ 7d654493-2a9e-44ad-a03b-583be70e8378
function ratroots(A, b, c, d)
    n = size(A, 1)
    M = [A b; c' d]
    B = [I(n) zeros(n,1); zeros(1,n) 0.0]
    zs = eigvals(M, B)
    real_zs = [real(z) for z in zs if isfinite(z) && isreal(z) && abs(imag(z)) < 1e-10]

    real_zs
end

# ╔═╡ 63dc0733-12b4-4c00-82b0-0c3df6ebb072
md"""
rateval: The function $f(z) = c^T (z I - A)^{-1} b + d$ requires solving $(z I - A) u = b$ to compute $f(z) = c^T u + d$, using the precomputed Hessenberg factorization $F$ where $F.Q' A F.Q = F.H$ (upper Hessenberg).
To achieve O(n²) time:

Compute $rhs = F.Q' b$.
Solve $(z I - H) v = rhs$ using Hessenberg factorization.
Compute $u = F.Q v$, then $f(z) = c^T u + d$.


ratroots: The real zeros of $f(z) = 0$ are the real finite generalized eigenvalues of the pencil $(M, B)$, where:
$$M = \begin{bmatrix} A & b \\ c^T & d \end{bmatrix}, \quad B = \begin{bmatrix} I_n & 0 \\ 0^T & 0 \end{bmatrix}.$$
This follows from $\det(M - z B) = 0$ implying $f(z) = 0$ (Schur complement or block determinant).
Compute using eigvals(M, B), filter real and finite values, and verify with rateval
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.6"
manifest_format = "2.0"
project_hash = "ac1187e548c6ab173ac57d4e72da1620216bce54"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"
version = "1.11.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"
version = "1.11.0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.11.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.27+1"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.11.0+0"
"""

# ╔═╡ Cell order:
# ╟─97e46e8a-227b-11ed-3ad4-bf493f45d214
# ╠═ca0206b9-e4ee-4f5f-8685-80efaf7ff0ba
# ╟─22f06cec-14ac-434b-865a-8f360f09fb62
# ╟─87d3be02-41fe-4222-ae6c-ae207e5649aa
# ╟─cc076c1e-92c0-4207-b97c-83d3d9f4d139
# ╟─7e3dfbbd-690f-43d5-8e17-7e77e13a4168
# ╠═2f9cf6c0-7515-4d20-9508-73d8f3eff1c7
# ╠═7d654493-2a9e-44ad-a03b-583be70e8378
# ╟─63dc0733-12b4-4c00-82b0-0c3df6ebb072
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
