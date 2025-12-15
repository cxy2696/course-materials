### A Pluto.jl notebook ###
# v0.20.17

using Markdown
using InteractiveUtils

# ╔═╡ ca0206b9-e4ee-4f5f-8685-80efaf7ff0ba
using LinearAlgebra

# ╔═╡ 97e46e8a-227b-11ed-3ad4-bf493f45d214
md"""
# Final CS 6210

You may talk about problems with the TA and with me, or reference any relevant literature (including the Julia documentation!), providing attribution for any good ideas you might get. You should not consult with other people or with AI tools, and your final write-up should be your own.
"""

# ╔═╡ dd7e7d53-24ff-4c27-8344-e8ac81cdad1b
md"""
## 1. Truth or dare

State whether each of the following is true and give a short argument why or why not.
(One point each)

- In the Tikhonov-regularized least squares problem, choosing the regularization parameter $\lambda$ via leave-one-out cross validation minimizes the overall residual norm.
- If $A \in \mathbb{R}^{n \times n}$ is symmetric positive definite and $A = R^T R$ is the Cholesky factorization, then the column two-norms of $R$ satisfy $\lambda_n(A) \leq \|R_{:,j}\|^2 \leq \lambda_1(A)$, where $\lambda_1(A)$ and $\lambda_n(A)$ are the largest and smallest eigenvalues of $A$, respectively.
- Suppose $A \in \mathbb{R}^{n \times n}$ is written as $A = M-N$ where $M$ is invertible.  If the iteration $M x^{(k+1)} = N x^{(k)} + b$ converges to a limiting fixed point $x^*$, then $Ax^* = b$.
- If $A$ is diagonalizable and $p$ is a polynomial such that $p(\lambda) = \lambda^{-1}$ for every eigenvalue $\lambda$ in the spectrum of $A$, then $p(A) = A^{-1}$.
"""

# ╔═╡ e6de1bd9-8cc8-407b-8e89-cb7df5421201
md"""
1. False. Leave-one-out cross-validation (LOOCV) selects $\lambda$ to minimize the average prediction error on held-out data points, balancing bias and variance for better generalization (as in the bias-variance decomposition). It does not minimize the training residual $\|A x - b\|^2$, which is smallest at $\lambda = 0$.

2. True. For SPD $A$, the Rayleigh quotient gives $\lambda_1(A) = \max_{\|x\|=1} x^T A x \geq e_j^T A e_j = A_{jj}$ for all $j$ (so $A_{jj} \leq \lambda_1(A)$), and $\lambda_n(A) = \min_{\|x\|=1} x^T A x \leq A_{jj}$ (so $A_{jj} \geq \lambda_n(A)$). From Cholesky, $\|R_{:,j}\|^2 = e_j^T R^T R e_j = e_j^T A e_j = A_{jj}$. Thus, the bounds hold for all $j$.

3. True. At the fixed point, $M x^* = N x^* + b$, so $(M - N) x^* = b$, i.e., $A x^* = b$. This holds regardless of convergence rate, as long as a limit exists.

4. True. Since $A = V \Lambda V^{-1}$ (diagonalizable), $p(A) = V p(\Lambda) V^{-1}$ where $p(\Lambda) = diag(p(\lambda_i)) = diag(\lambda_i^{-1}) = \Lambda^{-1}$. Thus, $p(A) = V \Lambda^{-1} V^{-1} = A^{-1}$.
"""

# ╔═╡ 87d3be02-41fe-4222-ae6c-ae207e5649aa
md"""
## 2. Scaled iteration

Consider the stationary iteration

$$x^{(k+1)} = x^{(k)} + M^{-1} A^T (b-Ax^{(k)})$$

where $A \in \mathbb{R}^{m \times n}$ has full column rank and $M \in \mathbb{R}^{n \times n}$ is positive definite.

- (1 point): What is the fixed point?
- (1 point): Write an iteration equation for the error
- (2 points): Argue that if $\|Ax\|^2/\|x\|_M^2 < 2$ for all $x \neq 0$, then the iteration converges.
"""

# ╔═╡ b40c138d-0710-4583-b371-4b873c35a85f
md"""
1. Fixed point: Set $x^* = x^{(k+1)} = x^{(k)}$, so $0 = M^{-1} A^T (b - A x^*)$. Since $M$ is invertible, $A^T (b - A x^*) = 0$, the normal equations for least squares. Thus, $x^* = (A^T A)^{-1} A^T b$ (exists since $A$ full column rank). The fixed point is independent of $M$.

2. Iteration for error: Let $e^{(k)} = x^{(k)} - x^*$. Then $e^{(k+1)} = e^{(k)} + M^{-1} A^T (b - A x^{(k)}) = e^{(k)} + M^{-1} A^T ((b - A x^*) - A e^{(k)})$. Since $A^T (b - A x^*) = 0$, this simplifies to $e^{(k+1)} = e^{(k)} - M^{-1} A^T A e^{(k)} = (I - M^{-1} A^T A) e^{(k)}$.

3. Convergence if $\|A x\|^2 / \|x\|_M^2 < 2$ for all $x \neq 0$: The iteration matrix is $G = I - M^{-1} A^T A$, and convergence requires $\rho(G) < 1$. The eigenvalues of $M^{-1} A^T A$ are $\mu$ where $\mu = x^T A^T A x / x^T M x = \|A x\|^2 / \|x\|_M^2$ (Rayleigh quotients). Since $A$ full column rank and $M > 0$, $\inf \mu > 0$; given $\sup \mu < 2$, all $\mu \in (0, 2)$. Thus, eigenvalues of $G$ are $1 - \mu \in (-1, 1)$, so $\rho(G) < 1$. Let $B = A M^{-1/2}$; the condition is $\sigma_{\max}(B)^2 < 2$, confirming clustered eigenvalues for fast convergence.
"""

# ╔═╡ 01afcd57-e86a-45ef-b86c-0a49223417ea
md"""
## 3. Factorization free

Given an initial guess $x^{(0)}$ with $|x^{(0)}-\lambda^{-1}| < |\lambda^{-1}|$
the Newton iteration

$$x^{(k+1)} = x^{(k)} + x^{(k)}(1-\lambda x^{(k)})$$

converges quadratically to $\lambda^{-1}$; more specifically, the error $e^{(k)} = x^{(k)} - \lambda^{-1}$ satisfies

$$e^{(k+1)} = -\lambda (e^{(k)})^2.$$

Similarly, the matrix iteration

$$X^{(k+1)} = X^{(k)} + X^{(k)} (I - A X^{(k)})$$

converges quadratically to $A^{-1}$ given a good initial guess.

(1 point): Argue that for the initial guess $x^{(0)} = 2-\lambda$, the scalar Newton iteration converges for $|1-\lambda| < 1$.  You may take the convergence condition given at the start of the problem as true without proof.

(1 point): Argue that if $A$ is diagonalizable and $X^{(0)} = p_0(A)$ for some polynomial $p_0$, then the matrix Newton iteration converges iff the scalar Newton iteration converges for each eigenvalue $\lambda$ of $A$ starting from $p_0(\lambda)$.

(2 points): Argue that if $\|I-A\| < 1$ for some operator norm, then the matrix Newton iteration converges starting from the initial guess $X^{(0)} = 2I-A$
"""

# ╔═╡ 403cfe94-8900-4c59-9451-5655e83aad8e
md"""
Scalar Newton: $x^{(k+1)} = x^{(k)} + x^{(k)} (1 - \lambda x^{(k)}) = x^{(k)} (2 - \lambda x^{(k)})$, converges quadratically if $|x^{(0)} - \lambda^{-1}| < |\lambda^{-1}|$, with $e^{(k+1)} = -\lambda (e^{(k)})^2$.

1. For $x^{(0)} = 2 - \lambda$, converges if $|1 - \lambda| < 1$ (i.e., $\lambda \in (0, 2)$): Compute $e^{(0)} = (2 - \lambda) - \lambda^{-1} = 2 - \lambda - \lambda^{-1}$. Need $|2 - \lambda - \lambda^{-1}| < \lambda^{-1}$ (since $\lambda > 0$). Let $f(\lambda) = 2 - \lambda - \lambda^{-1} \leq 0$ for $\lambda \in (0, 2)$, so $|f| = \lambda + \lambda^{-1} - 2$. Then $|f| - \lambda^{-1} = \lambda - 2 < 0$ (strict since $\lambda < 2$). Thus, the condition holds.

2. If $A$ diagonalizable and $X^{(0)} = p_0(A)$, matrix Newton converges iff scalar does for each $\lambda_i$ from $p_0(\lambda_i)$: Let $A = V \Lambda V^{-1}$; then $X^{(0)} = V p_0(\Lambda) V^{-1}$. The recursion $X^{(k+1)} = X^{(k)} (2I - A X^{(k)})$ preserves diagonalization: by induction, $X^{(k)} = V Y^{(k)} V^{-1}$ where $Y^{(k+1)}_i = Y^{(k)}_i (2 - \lambda_i Y^{(k)}_i)$, the scalar recursion. Convergence (quadratic) holds iff each scalar does.

3. If $\|I - A\| < 1$ for some operator norm, converges from $X^{(0)} = 2I - A$: The norm bound implies $\rho(I - A) < 1$, so $\max_i |1 - \lambda_i| < 1$ (all $\lambda_i \in (0, 2)$). By (ii), since diagonalizable not assumed but $X^{(0)}$ commutes with $A$ (preserves simultaneous diagonalizability if needed; convergence follows from spectral radius). Each scalar starts at $2 - \lambda_i$.
"""

# ╔═╡ 7e3dfbbd-690f-43d5-8e17-7e77e13a4168
md"""
## 4. Rational extrema

Consider a rational function of the form

$$f(z) = c^T (zI-A)^{-1} b + d$$

Note that this can also be written via a Schur complement in the matrix

$$\begin{bmatrix} A-zI & b \\ c^T & d \end{bmatrix} = M-zD$$

The poles of $f$ are the eigenvalues of $A$ and the zeros are the eigenvalues of $M-zD$ (as discussed in HW 10).

(1 point): Argue that if $d \neq 0$, then the zeros of $f$ are the eigenvalues of $A-bc^T/d$.

(1 point): Write a function to evaluate the function and derivative in $O(n^2)$ time given a Hessenberg factorization object `F = hessenberg(A)`.  Your code should take $O(n^2)$ time, and should look like

    f, df = p4eval(z, F, b, c, d)

(1 point): Introducing variables $v = (zI-A)^{-1} b$ and $u = (zI-A)^{-1} v$, write a generalized eigenvalue problem whose solutions correspond to critical points of $f(z)$.

(1 point): Using `eigvals(A,B)` (which computes solutions to the generalized eigenvalue problem $Ax = \lambda Bx$), find the (real) critical points of $f$.  Your code should look like

    zs = p4critical(A, b, c, d)

Note that you should write testers for each code.
"""

# ╔═╡ 517ee4da-cbdf-410f-a1c6-4c7dd84ae697
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

# ╔═╡ 5704c428-fb21-4be5-8fd9-e93c3785ab3f
begin
	n = 5; A = randn(n,n); F = hessenberg(A); b = randn(n); c = randn(n); d = 1.0; z = 10.0
	f, df = p4eval(z, F, b, c, d)
	f_direct = c' * ((z*I - A) \ b) + d
	df_direct = -c' * ((z*I - A) \ ((z*I - A) \ b))
	print(abs(f - f_direct) < 1e-10 && abs(df - df_direct) < 1e-10)
end

# ╔═╡ 324f65c3-c125-40ec-bdae-1846e4a06220
md"""
1. If $d \neq 0$, zeros are eigenvalues of $A - b c^T / d$: Using the matrix determinant lemma https://en.wikipedia.org/wiki/Matrix_determinant_lemma, $\det(zI - A + b c^T / d) = \det(zI - A) (1 + (c^T / d) (zI - A)^{-1} b) = \det(zI - A) f(z) / d$. Zeros of $f(z)$ (non-poles) are eigenvalues of $A - b c^T / d$.

2. Function for $f, f'$ using Hessenberg $F = hessenberg(A)$. $A = Q H Q^T$, so $(zI - A)^{-1} b = Q (zI - H)^{-1} (Q^T b)$; $f' = -c^T (zI - A)^{-2} b = -c^T (zI - A)^{-1} v$. Each is $O(n^2)$ for Hessenberg (LU factorization efficient).
"""

# ╔═╡ 776f9fcc-99c3-4e6c-b0e7-7f48f3eda1bd
function p4critical(A, b, c, d)
    n = size(A, 1)
    S = zeros(2n + 1, 2n + 1)
    # Order: v (1:n), u (n+1:2n), s (2n+1)
    S[1:n, 1:n] = A # A v
    S[1:n, 2n+1] = b # b s
    S[n+1:2n, n+1:2n] = A # A u
    S[n+1:2n, 1:n] = I(n) # v
    S[2n+1, n+1:2n] = c' # c^T u
    L = zeros(2n + 1, 2n + 1)
    L[1:n, 1:n] = I(n)
    L[n+1:2n, n+1:2n] = I(n)
    evs = eigvals(S, L)
    finite_real = filter(e -> isfinite(e) && isreal(e), evs)
    zs = sort(real.(finite_real))
    
    zs
end

# ╔═╡ ae51f45e-d8b5-438a-bdee-e8c30a6ce6eb
begin
	n2 = 3; A2 = diagm([1.0, 2.0, 3.0]); b2 = ones(n2); c2 = [1, -1, 1]; d2 = 1.0
	zs = p4critical(A2, b2, c2, d2)
	F2 = hessenberg(A2)
	for z in zs
    	_, df = p4eval(z, F2, b2, c2, d2)
    	print(abs(df) < 1e-10)
	end
end

# ╔═╡ 9a7e70e0-34e8-4cb1-81fe-17e966e85729
md"""
3. Critical points satisfy $f'(z) = 0$, i.e., $-c^T (zI - A)^{-2} b = 0$. Let $v = (zI - A)^{-1} b$, so $(zI - A) v = b$. Let $u = (zI - A)^{-1} v$, so $(zI - A) u = v$ and $c^T u = 0$. Introduce scalar $s$ for homogeneity: the GEP is $\begin{bmatrix} A & 0 & b \\ I & A & 0 \\ 0 & c^T & 0 \end{bmatrix} \begin{bmatrix} v \\ u \\ s \end{bmatrix} = z \begin{bmatrix} I & 0 & 0 \\ 0 & I & 0 \\ 0 & 0 & 0 \end{bmatrix} \begin{bmatrix} v \\ u \\ s \end{bmatrix}$ Finite eigenvalues $z$ where $s \neq 0$ are critical points (normalize $s=1$).

4. eigvals(S, L) solves the GEP. Filters finite real eigenvalues (infinite ones from singular $L$) and sorts them.
"""

# ╔═╡ ca64c90c-09da-4a34-9e81-c5ce04c37bf6
md"""
## 5. Playing with polynomials

Suppose $A = I - F$ where $\|F\|_2 < 1$.

(2 points): Find $p \in \mathcal{P}_d$ such that 
$\|I-A p(A)\|_2 \leq \|F\|_2^{d+1}$.

(2 points): Given a particular $F$, write a function `polyinv(F,d)` to compute the $d+1$ coefficients with respect to the power basis for the polynomial $p \in \mathcal{P}_d$ such that $\|I-A p(A)\|_F^2$ is minimal.  Also give an explanation for your code!
"""

# ╔═╡ 3078c484-9c70-4907-8489-3420b0a26c25
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

# ╔═╡ b3bf7231-3281-44e0-b38f-359b7b5192cf
md"""
1. Consider the polynomial $p(x) = \sum_{k=0}^{d} (1 - x)^k \in \mathcal{P}_d$. Since $A = I - F$, we have $p(A) = \sum_{k=0}^{d} F^k$ Then, $A p(A) = (I - F) \sum_{k=0}^{d} F^k = \sum_{k=0}^{d} F^k - \sum_{k=1}^{d+1} F^k = I - F^{d+1},$ so $I - A p(A) = F^{d+1}.$ Taking the 2-norm yields $\|I - A p(A)\|_2 = \|F^{d+1}\|_2 \leq \|F\|_2^{d+1}$ as required.


2. The minimization is reformulated as a standard linear least-squares problem by vectorizing the matrices. Since the Frobenius norm satisfies $\|M\|_F = \|\mathrm{vec}(M)\|_2$, we have $\|I - A p(A)\|_F = \left\|I - \sum_{k=0}^d c_k A^{k+1}\right\|_F = \left\|\sum_{k=0}^d c_k A^{k+1} - I\right\|_F = \|\Phi \mathbf{c} - \mathrm{vec}(I)\|_2$ where $\Phi$ is the $n^2 \times (d+1)$ matrix whose columns are $\mathrm{vec}(A), \mathrm{vec}(A^2), \dots, \mathrm{vec}(A^{d+1})$, and $\mathbf{c} = [c_0; c_1; \dots; c_d]$. The code solves for the $\mathbf{c}$ that minimizes this via QR factorization. Phi = zeros(n*n, d+1): Allocates the design matrix $\Phi$ as a dense $n^2 \times (d+1)$ array of zeros. A_power = A: Initializes a temporary matrix to hold powers of $A$, starting with $A^1 = A$. Phi[:, i] = vec(A_power): Flattens the current power $A^i$ into a column vector and assigns it to the $i$-th column of $\Phi$. target = vec(Matrix(I(n))): Vectorizes the identity matrix into an $n^2 \times 1$ target vector. c = Phi \ target: Solves the least-squares system $\Phi \mathbf{c} \approx \mathrm{vec}(I)$.
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
# ╟─dd7e7d53-24ff-4c27-8344-e8ac81cdad1b
# ╟─e6de1bd9-8cc8-407b-8e89-cb7df5421201
# ╟─87d3be02-41fe-4222-ae6c-ae207e5649aa
# ╟─b40c138d-0710-4583-b371-4b873c35a85f
# ╟─01afcd57-e86a-45ef-b86c-0a49223417ea
# ╟─403cfe94-8900-4c59-9451-5655e83aad8e
# ╟─7e3dfbbd-690f-43d5-8e17-7e77e13a4168
# ╠═517ee4da-cbdf-410f-a1c6-4c7dd84ae697
# ╠═5704c428-fb21-4be5-8fd9-e93c3785ab3f
# ╟─324f65c3-c125-40ec-bdae-1846e4a06220
# ╠═776f9fcc-99c3-4e6c-b0e7-7f48f3eda1bd
# ╠═ae51f45e-d8b5-438a-bdee-e8c30a6ce6eb
# ╟─9a7e70e0-34e8-4cb1-81fe-17e966e85729
# ╟─ca64c90c-09da-4a34-9e81-c5ce04c37bf6
# ╠═3078c484-9c70-4907-8489-3420b0a26c25
# ╟─b3bf7231-3281-44e0-b38f-359b7b5192cf
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
