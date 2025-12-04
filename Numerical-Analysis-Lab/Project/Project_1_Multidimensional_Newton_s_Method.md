<p>Multidimensional Newton’s Method
MATH 310 Project 1
Anny
February 2024</p>

<p>Multidimensional Newton’s Method Page 1
1 Methodology and Implementation
Consider a system of nonlinear equations given by the function
R → R
F : n n
∈ R
We need to find a solution of x n such tha(cid:18)t F(x) =(cid:19)0.
For the two-dimensional case with 2 functions, the function F and its system is given
below:
f(x,y)
F(x,y) =
g(x,y)
(cid:32) (cid:33)
The Jacobian matrix J of F is a square matrix of all first-order derivatives of components
of F, shown below:
∂f ∂f
J(x,y) = ∂x ∂y
∂g ∂g
∂x ∂y
(cid:18) (cid:19) (cid:18) (cid:19)
The Newton iteration in multidimensional with the Jacobian matrix is given by
x x − −
n+1 = n J 1(x ,y )F(x ,y )
y y n n n n
n+1 n
where x and y are approximations.
(cid:18) (cid:19)
1.1 Example 1
(cid:18) xsin(y) (cid:19)
F(x,y) =
cos(x)+sin(y2)
sin(y) xcos(y)
J(x,y) = −
sin(x) 2ycos(y2)
In Python, we need to firstly define the functions of F and their corresponding Jacobian
matrix.
1 # Define the function F(x, y) = [f(x, y), g(x, y)]
2 def F(x, y):
3 return np.array([x * np.sin(y), np.cos(x) + np.sin(y<strong>2)])
4
5 # Define the Jacobian matrix of F
6 def J(x, y):
7 return np.array([[np.sin(y), x * np.cos(y)],
8 [-np.sin(x), 2 * y * np.cos(y</strong>2)]])
FortheimplementationoftheMultidimentionalNewton’smethod, weneedtoperformit-
erations for solving for the updated step b. Instead of calculating the inverse of the Jacobian,
we can solve the system:
−
J(x ,y )b = F(x ,y )
n n n n</p>

<p>Multidimensional Newton’s Method Page 2
1 # Multidimensional Newton’s method for 2 functions
2 def newtons<em>method(F, J, x0, y0, tol):
3 x, y = x0, y0
4
5 # initialize the step size vector b with infinity to enter the while
loop
6 b = np.array([np.inf, np.inf])
7
8 # iterating until b is smaller than the tolerance
9 while np.linalg.norm(b)&gt;=tol:
10
11 # solve the linear system J(x, y) * b = -F(x, y)
12 b = np.linalg.solve(J(x,y), -F(x,y))
13
14 # update the guesses for x and y
15 x, y = x + b[0], y + b[1]
16
17 return x, y
The above function can be applied to solve for the example system with the initial guess
of x ,y ) = (π,π):
0 0 2
1 # Initial guess
2 x0, y0 = np.pi/2, np.pi
3
4 # Apply Newton’s method
5 solution = newtons</em>method(F, J, x0, y0, 1e-6)
6
7 # Print the solution
8 print("Solution: x = {:}, y = {:}".format(solution[0], solution[1]))
ThereturnedsolutionisSolution: Solution: x=1.1259698864749177,y=3.141592653589793.
Figure 1: C.13 Example
Actually, the given example functions have multiple roots as shown in figure 1. and the</p>

<p>Multidimensional Newton’s Method Page 3
returned solution is highly depended on the initial guess. If we try to solve with the initial
guess of (x ,y ) = (1.0,1.0):
1 1
1 # Initial guess
2 x1, y1 = 1.0, 1.0
3
4 # Apply Newton’s method
5 solution1 = newtons<em>method(F, J, x1, y1, 1e-6)
6
7 # Print the solution
8 print("Solution: x = {:}, y = {:}".format(solution1[0], solution1[1]))
ThesolutionischangedtobeSolution: x=1.5707963267948966,y=-6.64410208813345e-25.
The Multidimensional Newton’s Method can converge to different solutions based on
our initial guess. We also need to ensure that the given functions are differentiable and
the Jacobian matrix is non-singular at the beginning and is invertible at each iteration,
otherwise, the method might fail to converge.
1.2 Example 2
(cid:18) (cid:19)
The new functions are given below:
−
(cid:18) 1+x2 y2 +excos(y) (cid:19)
F(x,y) =
2xy +exsin(y)
− −
2x+excos(y) 2y exsin(y)
J(x,y) =
2y +exsin(y) 2x+excos(y)
1 # Define the function F(x, y) = [f(x, y), g(x, y)]
2 def F(x, y):
3 return np.array([1 + x<strong>2 - y</strong>2 + np.exp(x)*np.cos(y), 2*x*y + np.exp
(x)*np.sin(y)])
4
5 # Define the Jacobian matrix of F
6 def J(x, y):
7 return np.array([[2*x + np.exp(x)*np.cos(y), -2*y - np.exp(x)*np.sin(y
)],
8 [2*y + np.exp(x)*np.sin(y), 2*x + np.exp(x)*np.cos(y)
]])
9
10 # Initial guess
11 x0, y0 = 1, 1
12
13 # Apply Newton’s method
14 solution = newtons</em>method(F, J, x0, y0, 1e-6)
15
16 # Print the solution
17 print("Solution: x = {:}, y = {:}".format(solution[0], solution[1]))
Then solution with initial guess of (x,y) = (1,1) is Solution: x = -0.2931626870672417, y =
1.1726598176735787.</p>

<p>Multidimensional Newton’s Method Page 4
 
Think about a case of more functions:
 
 
f (x)
 1 
f (x)
2
F(x) = .
.
.
f (x)
k
 
Then, the Jacobian matrix will be:
 
 ··· 
∂f1(x) ∂f1(x) ∂f1(x)
∂x1 ∂x2 ··· ∂xn 
∂f2(x) ∂f2(x) ∂f2(x)
J(x) = ∂x1... ∂x2... ... ∂xn...
···
∂fk(x) ∂fk(x) ∂fk(x)
∂x1 ∂x2 ∂xn
Thus, the Multidimentional Newton’s Method solves for
− −
x = x J(x ) 1F(x )
n+1 n n n
where x represents the approximations in a vector
In Python, the general function is shown below:
1 # General Multidimensional Newton’s Method
2 # Can implement with any number of given functions
3
4 def multidimensional<em>newton(funcs, jacobian, initial</em>guess, tol=1e-10):
5 # Initialize the guess
6 x<em>k = np.array(initial</em>guess)
7
8 while True:
9 # Evaluate the functions
10 F<em>k = np.array([func(*x</em>k) for func in funcs])
11
12 # Evaluate the Jacobian matrix
13 J<em>k = jacobian(*x</em>k)
14
15 # Check if the Jacobian is near singular
16 if np.linalg.cond(J<em>k) &gt; 1 / np.finfo(float).eps:
17 print("Jacobian is near singular at the initial guess. Newton’
s method may not converge.")
18 return None
19
20 # Solve the system J</em>k * b = -F to find delta
21 b, residuals, rank, s = np.linalg.lstsq(J<em>k, -F</em>k, rcond=None)
22
23 # If the system is underdetermined or overdetermined, no solution
was found
24 if residuals.size &gt; 0 and np.any(residuals &gt; tol):
25 print("The system does not have a solution.")
26 return None
27</p>

<p>Multidimensional Newton’s Method Page 5
28 if rank &lt; J<em>k.shape[0]:
29 print("Jacobian matrix is rank deficient at the initial guess,
and the Newton’s method may not converge.")
30
31 # Update the guess
32 x</em>k += b
33
34 # Check for convergence
35 if np.linalg.norm(b) &lt; tol:
36 break
37
38 return x<em>k
Apply the functions in C.15 with an initial guess of [1.0, 1.0]:
1 # C. 15 example, where the number of functions is 2
2 def f1(x, y):
3 return 1 + x<strong>2 - y</strong>2 + np.exp(x)*np.cos(y)
4
5 def g1(x, y):
6 return 2*x*y + np.exp(x)*np.sin(y)
7
8 F = [f1, g1]
9 initial = [1.0, 1.0]
10 sol = multidimensional</em>newton(F, J, initial)
11 print("Solution:", sol)
The solution is given as: Solution: [-0.29316269 1.17265982].
1.3 Example 3  
The given functions are:  
−
x2 +y2 +z2 100
−
F(x) = xyz 1
− −
x y sin(z)
 
Then, the Jacobian matrix is shown below:
 
2x 2y 2z
J(x) = yz xz xy
− −
1 1 cos(z)
With the initial guess of (x,y,z) = (1.0,1.0,π), we can implement the multidimentional
newton’s method:
1 def f(x, y, z):
2 return x<strong>2 + y</strong>2 + z<em>*2 -100
3
4 def g(x, y, z):
5 return x</em>y*z - 1
6
7 def h(x, y, z):
8 return x - y - np.sin(z)
9</p>

<p>Multidimensional Newton’s Method Page 6
10 def Jacobian(x, y, z):
11 return np.array([[2<em>x, 2</em>y, 2<em>z],
12 [y</em>z, x<em>z, x</em>y],
13 [1, -1, -np.cos(z)]])
14
15 F<em>new = [f, g, h]
16 initial = [1.0, 1.0, np.pi]
17
18 # Apply the method which allows any number of functions
19 sol = multidimensional</em>newton(F_new, Jacobian, initial)
20 print(f"Solution: {sol}")
The solution is given as [-7.06104719 -7.08104601 0.02000016].
1.4 Example 4
The system of differential equations is:
′ −
x = αx βxy
′
y = δy +γxy
where α = 1, β = 0.05, γ = 0.01 and δ =(cid:18)1 (cid:19)
The Jacobian matrix is defined:
− −
α βy βx
J(x,y) =
γy δ +γx
′ ′
To find the equilibrium points, w(cid:40)e set x and y to zero and solve for x and y. This gives
the following system of algebraic equations:
−
0 = x 0.05xy
0 = y +0.01xy
From this system of equations, the first equation indicates that either x = 0 or y = α =
− − β
20. The second equation indicates that either y = 0 or x = δ = 100.
γ

Therefore, our potential initial guesses for equilibrium points can be:



(x,y) = (0,0)



(x,y) = (0,20)
−
(x,y) = ( 100,0)
(x,y) = (nonzero,nonzero)
To solve this system, we can use the multidimensional Newton’s method with an initial
−
guesses of [0.0, 0.0], [0.0, 20.0], [-100.0, 0], [ δ , α].
γ+(γα) β
β
1 # Parameters for the system
2 alpha, beta, gamma, delta = 1, 0.05, 0.01, 1
3</p>

<p>Multidimensional Newton’s Method Page 7
4 # Defining the functions for the system
5 def f1(x, y):
6 return alpha * x - beta * x * y
7
8 def f2(x, y):
9 return delta * y + gamma * x * y
10
11 # Defining the Jacobian matrix for the system
12 def jacobian(x, y):
13 return np.array([[alpha - beta * y, -beta * x],
14 [gamma * y, delta + gamma * x]])
15
16 F = [f1, f2]
17 initial0 = [0.0, 0.0]
18 initial1 = [0.0, alpha/beta]
19 initial2 = [-delta/gamma, 0.0]
20
21 # substitute y = alpha / beta in the second equation
22 initial3 = [-delta / (gamma + (gamma * alpha / beta)), alpha/beta]
23 sol0 = multidimensional<em>newton(F, jacobian, initial0)
24 sol1 = multidimensional</em>newton(F, jacobian, initial1)
25 sol2 = multidimensional<em>newton(F, jacobian, initial2)
26 sol3 = multidimensional</em>newton(F, jacobian, initial3)
27
28 print("Solution:", sol0)
29 print("Solution:", sol1)
30 print("Solution:", sol2)
31 print("Solution:", sol3)
The output is:
Jacobian is singular at the initial guess.
Newton’s method may not converge with the initial guess of [0.0, 20.0].
Jacobian is singular at the initial guess.
Newton’s method may not converge with the initial guess of [-100.0, 0.0].
Solution: [0. 0.] with initial guess of [0.0, 0.0]
Solution: None with initial guess of [0.0, 20.0]
Solution: None with initial guess of [-100.0, 0.0]
Solution: [-100. 20.] with initial guess of [-4.761904761904762, 20.0]
Therefore, we have 2 equilibrium points as solutions: [0, 0] and [-100, 20].
1.5 Example 5
The system of differential equations is defined as:
′ − −
x = 0.1xy x
′ −
y = x+0.9y
′ −
z = cos(y) xz</p>

<p>Multidimensional Newton’s Method Page 8
 
The Jacobian matrix is defined as:
 
− − −
0.1y 1 0.1x 0
−
J(x,y,z) = 1 0.9 0
− − −
z sin(y) x

′ ′ ′
Set x,y ,z to zero and solve forx,y,z. The following shows the algebraic equations:
− −

0 = 0.1xy x
−
0 = x+0.9y
−
0 = cos(y) xz
− − −
From the firs equation, either x = 0 or y = 10 since x( 0.1y 1) = 0.
From the second equation, either both x,y are zero or nonzero, yielding y = x .
0.9 ̸
For the third equation, if x is zero, z can be any value and cos(y) needs to be zero. If x = 0,
we need to define z = cos(y)
x
After applying multiple initial guesses, most of them give a singular Jacobian matrix,
which cannot be solved throught the multidimensional newton’s method, unless applying
′ ′ ′ −
the initial guess of (x,y ,z ) = (1.0, 10.0,1.0).
1 def f20(x, y, z):
2 return -0.1<em>x</em>y - x
3
4 def g20(x, y, z):
5 return -x + 0.9 * y
6
7 def h20(x, y, z):
8 return np.cos(y) - x<em>z
9
10 def Jaco(x, y ,z):
11 return np.array([[-0.1</em>y - 1, -0.1*x, 0],
12 [-1, 0.9, 0],
13 [-z, -np.sin(y), -x]])
14
15
16 F = [f20, g20, h20]
17 initial0 = [1.0, -10.0, 1.0]
18 sol0 = multidimensional_newton(F, Jaco, initial0)
19 print(sol0)
The solution is approximated as [ -9. -10. 0.09323017].</p>

<p>Multidimensional Newton’s Method Page 9
2 General Function in Python
1 import numpy as np
2
3 # General Multidimensional Newton’s Method
4 def multidimensional<em>newton(funcs, jacobian, initial</em>guess, tol=1e-10):
5 """
6 funcs: list of functions, the system of nonlinear equations
7 jacobian: function that computes the Jacobian matrix
8 initial<em>guess: initial guess for the variables
9 tolerance: tolerance for the convergence criterion
10 """
11 # Initialize the guess
12 x</em>k = np.array(initial<em>guess)
13
14 while True:
15 # Evaluate the functions
16 F</em>k = np.array([func(<em>x_k) for func in funcs])
17
18 # Evaluate the Jacobian matrix
19 J_k = jacobian(</em>x<em>k)
20
21 # Check if the Jacobian is near singular
22 if np.linalg.cond(J</em>k) &gt; 1 / np.finfo(float).eps:
23 # If the Jacobian is near singular, Newton’s method may not
converge
24 print(f"Jacobian is singular at the initial guess. Newton’s
method may not converge with the initial guess of {initial<em>guess}.")
25 return None
26
27 # Solve the system J</em>k * b = -F to find delta
28 b = np.linalg.solve(J<em>k, -F</em>k)
29
30 # Update the guess
31 x<em>k += b
32
33 # Check for convergence
34 if np.linalg.norm(b) &lt; tol:
35 break
36
37 return x</em>k
3 Example solution in Summary
1 # C. 13 example
2 def f(x, y):
3 return x * np.sin(y)
4 def g(x, y):
5 return np.cos(x) + np.sin(y**2)
6 def jacobian(x, y):
7 return np.array([[np.sin(y), x * np.cos(y)],</p>

<p>Multidimensional Newton’s Method Page 10
8 [-np.sin(x), 2 * y * np.cos(y<strong>2)]])
9 funcs = [f, g]
10 initial = [np.pi/2, np.pi]
11 sol = multidimensional<em>newton(funcs, jacobian, initial)
12 print(f"C.13 example: {sol} with initial guess of {initial}")
13 ######################################################################
14
15 # C. 15 example
16 def f1(x, y):
17 return 1 + x</strong>2 - y<strong>2 + np.exp(x)*np.cos(y)
18 def g1(x, y):
19 return 2*x*y + np.exp(x)*np.sin(y)
20 # Define the Jacobian matrix of F
21 def jacobian1(x, y):
22 return np.array([[2*x + np.exp(x)*np.cos(y), -2*y - np.exp(x)*np.sin(y
)],
23 [2*y + np.exp(x)*np.sin(y), 2*x + np.exp(x)*np.cos(y)
]])
24 funcs1 = [f1, g1]
25 initial1 = [1.0, 1.0]
26 sol1 = multidimensional</em>newton(funcs1, jacobian1, initial1)
27 print(f"C.15 example: {sol1} with initial guess of {initial1}")
28 ####################################################################
29
30 # C.17 example
31 def f(x, y, z):
32 return x</strong>2 + y<strong>2 + z</strong>2 -100
33 def g(x, y, z):
34 return x<em>y</em>z - 1
35 def h(x, y, z):
36 return x - y - np.sin(z)
37 def Jacobian(x, y, z):
38 return np.array([[2<em>x, 2</em>y, 2<em>z],
39 [y</em>z, x<em>z, x</em>y],
40 [1, -1, -np.cos(z)]])
41 F<em>new = [f, g, h]
42 initial = [1.0, 1.0, np.pi]
43 sol = multidimensional</em>newton(F_new, Jacobian, initial)
44 print(f"C.17 example: {sol} with initial guess of {initial}")
45 ######################################################################
46
47 #C.19 example
48 alpha, beta, gamma, delta = 1, 0.05, 0.01, 1
49 def f1(x, y):
50 return alpha * x - beta * x * y
51 def f2(x, y):
52 return delta * y + gamma * x * y
53 def jacobian(x, y):
54 return np.array([[alpha - beta * y, -beta * x],
55 [gamma * y, delta + gamma * x]])
56
57 F = [f1, f2]
58 initial0 = [0.0, 0.0]
59 initial1 = [0.0, alpha/beta]</p>

<p>Multidimensional Newton’s Method Page 11
60 initial2 = [-delta/gamma, 0.0]
61
62 # substitute y = alpha / beta in the second equation
63 initial3 = [-delta / (gamma + (gamma * alpha / beta)), alpha/beta]
64
65 print("\nC.19 example:")
66 sol0 = multidimensional<em>newton(F, jacobian, initial0)
67 sol1 = multidimensional</em>newton(F, jacobian, initial1)
68 sol2 = multidimensional<em>newton(F, jacobian, initial2)
69 sol3 = multidimensional</em>newton(F, jacobian, initial3)
70
71 print("Solution:", sol0, "with initial guess of", initial0)
72 print("Solution:", sol1, "with initial guess of", initial1)
73 print("Solution:", sol2, "with initial guess of", initial2)
74 print("Solution:", sol3, "with initial guess of", initial3)
75 #######################################################################
76
77 # C.20 example
78 def f20(x, y, z):
79 return -0.1<em>x</em>y - x
80 def g20(x, y, z):
81 return -x + 0.9 * y
82 def h20(x, y, z):
83 return np.cos(y) - x<em>z
84
85 def Jaco(x, y ,z):
86 return np.array([[-0.1</em>y - 1, -0.1*x, 0],
87 [-1, 0.9, 0],
88 [-z, -np.sin(y), -x]])
89 F = [f20, g20, h20]
90 initial0 = [1.0, -10.0, 1.0]
91 sol0 = multidimensional_newton(F, Jaco, initial0)
92 print(f"\nC.20 example: {sol0} with initial guess of {initial0}")
93
94 ######################################################################
95 The outputs are:
96 C.13 example: [1.12596989 3.14159265] with initial guess of
[1.5707963267948966, 3.141592653589793]
97 C.15 example: [-0.29316269 1.17265982] with initial guess of [1.0, 1.0]
98 C.17 example: [-7.06104719 -7.08104601 0.02000016] with initial guess of
[1.0, 1.0, 3.141592653589793]
99
100 C.19 example:
101 Jacobian is singular at the initial guess. Newton’s method may not
converge with the initial guess of [0.0, 20.0].
102 Jacobian is singular at the initial guess. Newton’s method may not
converge with the initial guess of [-100.0, 0.0].
103 Solution: [0. 0.] with initial guess of [0.0, 0.0]
104 Solution: None with initial guess of [0.0, 20.0]
105 Solution: None with initial guess of [-100.0, 0.0]
106 Solution: [-100. 20.] with initial guess of [-4.761904761904762, 20.0]
107
108 C.20 example: [ -9. -10. 0.09323017] with initial guess
of [1.0, -10.0, 1.0]</p>
