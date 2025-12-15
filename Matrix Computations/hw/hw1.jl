### A Pluto.jl notebook ###
# v0.20.17

using Markdown
using InteractiveUtils

# ╔═╡ ca0206b9-e4ee-4f5f-8685-80efaf7ff0ba
using LinearAlgebra

# ╔═╡ 97e46e8a-227b-11ed-3ad4-bf493f45d214
md"""
# HW1 for CS 6210

You may (and probably should) talk about problems with the each other, with the TA, and with me, providing attribution for any good ideas you might get. Your final write-up should be your own.
"""

# ╔═╡ 6294b596-0cb1-4613-b9a6-057e0bad6d5b
md"""
## 1. All about you

- How do you prefer to be called? 
Xinyi (sounds like Shin-ee)

- Why are you taking the class? 
Want to deepen understanding of numerical linear algebra and learning basic concepts for computational science.

- Are there things you particularly hope to learn? 
efficient algorithms for large-scale problems, error analysis, and new practical programming implementations in Julia.

- Do you have any concerns (about background, schedule, etc)? 
No major concerns so far, but need time to familiar with Julia as this is the first time to learn this programming languages.

- Is there anything else I should know about your situation? 
I want to apply for PhD and want to learn more to connect theory to practice with numerical computations.
"""

# ╔═╡ 19d8e00f-2e9c-44f1-af54-3272300f4135
md"""
## 2. A little differentiation

Differentiate $\|Ax\|^2$ with respect to $x$ and $A$, and write the result in the form

$$\delta[ \|Ax\|^2 ] = g^T \delta x + \langle G, \delta A \rangle_F$$

You may use the following tester as a sanity check.

Differentiation: Using Frobenius inner product $\langle G, \delta A \rangle_F = \operatorname{tr}(G^T \delta A)$.
$\|Ax\|^2 = (Ax)^T(Ax) = x^T A^T Ax$.

When treat A as constant to differentiate with respect to x, considering a perturbation $x\rightarrow x +\delta x$: $\delta[\|Ax\|^2] = \delta(x^T A^T A x) = (\delta x)^T A^T A x + x^T A^T A (\delta x)$. Since $A^T A$ is symmetric, this can simplify to $2x^T A^T A \delta x = (2A^T Ax)^T \delta x$ and it identifies $g = 2A^T Ax$.

Then, differentiate with respect to A, considering a pertubation $A \rightarrow A + \delta A$: Think $\|Ax\|^2 = \sum_{i=1}^m [(Ax)_i]^2$, and then $\frac{\partial}{\partial a_{ij}} \|Ax\|^2 = 2 (Ax)_i x_j$. THus, $g_{ij} = 2 (Ax)_i x_j $ and $ G = 2 (Ax) x^T$.

Therefore, $\delta[\|Ax\|^2] = (2 A^T A x)^T \delta x + \langle 2 (Ax) x^T, \delta A \rangle_F$, the Frobenius term is $\langle G, \delta A \rangle_F = \operatorname{tr}(G^T \delta A) = \operatorname{tr}(2x (Ax)^T \delta A) = 2(Ax)^T (\delta Ax)$.

"""

# ╔═╡ 5fc27366-77d8-4ea2-8e7b-748c483a469e
function check_p2(A, x, G, g, h = 1e-4)

	# Pick a random direction
	δA = rand(size(A)...)
	δx = rand(size(x)...)

	# Compute an estimated directional derivative by finite differences
	np = norm((A+h*δA)*(x+h*δx))^2
	nm = norm((A-h*δA)*(x-h*δx))^2
	dn_fd = (np-nm)/(2*h)

	# Compute the analytical directional derivative
	dn_analytical = dot(g, δx) + dot(G, δA)

	# Return the relative error between the two computations
	abs((dn_fd-dn_analytical)/dn_fd)
end

# ╔═╡ 45f9a506-8ac0-4998-bfdc-1338e5b7a1e1
A = rand(5,3)

# ╔═╡ 31d99899-89b7-4495-bd0e-1fbd5f2b188e
x = rand(3)

# ╔═╡ d8b24787-2263-4282-b08e-58ae65bf028e
G = 2*(A*x)*transpose(x)

# ╔═╡ c34388d2-c882-43a2-a1a8-351e26c27401
g = 2*transpose(A) * A*x

# ╔═╡ ee43afc8-26fa-4dde-8e98-f3e3b228973a
error = check_p2(A, x, G, g)

# ╔═╡ f359a5a1-de51-41b1-96f4-d75e2902735c
println(error)

# ╔═╡ 0ac2e51e-99e3-4f7a-b5e7-70a897968413
md"""
## 3: Norm!

For $A = xy^T$, verify the following

$$\begin{aligned}
\|A\|_1      &= \|x\|_1 \|y\|_\infty \\
\|A\|_\infty &= \|x\|_\infty \|y\|_1 \\
\|A\|_F      &= \|x\|_2 \|y\|_2 \\
\|A\|_2      &= \|x\|_2 \|y\|_2
\end{aligned}$$

The 1-norm is the maximum column sum:
$\|A\|_1 = \max_j \sum_{i=1}^n |a_{ij}| = \max_j \sum_{i=1}^n |x_i| |y_j| = \max_j |y_j| \cdot \|x\|_1 = \|y\|_\infty \|x\|_1 = \|x\|_1 \|y\|_\infty$

The infinite-norm is the maximum row sum:
$\|A\|_\infty = \max_i \sum_{j=1}^n |a_{ij}| = \max_i \sum_{j=1}^n |x_i| |y_j| = \max_i |x_i| \cdot \|y\|_1 = \|x\|_\infty \|y\|_1$

The Frobenius norm:
$\|A\|_F^2 = \sum_{i=1}^n \sum_{j=1}^n a_{ij}^2 = \sum_{i=1}^n \sum_{j=1}^n (x_i y_j)^2 = \sum_{i=1}^n x_i^2 \sum_{j=1}^n y_j^2 = \|x\|_2^2 \|y\|_2^2$. 
Thus, $\|A\|_F = \|x\|_2 \|y\|_2$.

The 2-norm: For $A = x y^T$, the rank is 1, and the non-zero singular value is $\|A\|_2 = \|x\|_2 \|y\|_2$ from SVD, where $A = \sigma u v^T$, and $\sigma = \|x\|_2 \|y\|_2$.
"""

# ╔═╡ a2542e2f-a118-4473-a84a-0245ef2381f8
md"""
## 4: Seeking structure

Suppose $A = D + uv^T$ where $D = \operatorname{diag}(d)$ for $d, u, v \in \mathbb{R}^n$.  Rewrite each of the computations in the following code to take $O(n)$ time:
"""

# ╔═╡ 52bdd428-f762-4554-adbc-f6e1ad56b873
# Reference computations
function p4ref(d, u, v, x)
	D = Diagonal(d)
	A = D + u*v'
	y1 = A*x      # Part 1
	y2 = A'*x     # Part 2
	d = diag(A)   # Part 3
	t = tr(A)     # Part 4
	y1, y2, d, t
end

# ╔═╡ 5f466282-6fd5-453d-8330-503a90a7d5d3
# Your computations (rewrite this)
function p4mine(d, u, v, x)
	vT_x = dot(v, x)
	uT_x = dot(u,x)
	vT_u = dot(v, u)
	y1 = Diagonal(d) * x + u * vT_x
	y2 = Diagonal(d) * x + v * uT_x
	dm = d + Diagonal(u) * v
	t = sum(d) + vT_u
	y1, y2, dm, t
end

# ╔═╡ d0344353-0e3b-4e23-84cd-9618115178b4
let
	n = 1000     # Change this to 10000 as a sanity check!
	d = rand(n)
	u = rand(n)
	v = rand(n)
	x = rand(n)
	y1r, y2r, dr, tr = p4ref(d, u, v, x)
	y1m, y2m, dm, tm = p4mine(d, u, v, x)
	println(y1r ≈ y1m, y2r ≈ y2m, dr ≈ dm, tr ≈ tm)
end

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
# ╟─6294b596-0cb1-4613-b9a6-057e0bad6d5b
# ╟─19d8e00f-2e9c-44f1-af54-3272300f4135
# ╠═5fc27366-77d8-4ea2-8e7b-748c483a469e
# ╠═45f9a506-8ac0-4998-bfdc-1338e5b7a1e1
# ╠═31d99899-89b7-4495-bd0e-1fbd5f2b188e
# ╠═d8b24787-2263-4282-b08e-58ae65bf028e
# ╠═c34388d2-c882-43a2-a1a8-351e26c27401
# ╠═ee43afc8-26fa-4dde-8e98-f3e3b228973a
# ╠═f359a5a1-de51-41b1-96f4-d75e2902735c
# ╟─0ac2e51e-99e3-4f7a-b5e7-70a897968413
# ╟─a2542e2f-a118-4473-a84a-0245ef2381f8
# ╠═52bdd428-f762-4554-adbc-f6e1ad56b873
# ╠═5f466282-6fd5-453d-8330-503a90a7d5d3
# ╠═d0344353-0e3b-4e23-84cd-9618115178b4
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
