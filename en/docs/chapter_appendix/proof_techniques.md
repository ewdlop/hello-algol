# Mathematical Proof Techniques

In algorithm analysis and discrete mathematics, proofs are essential tools for verifying algorithm correctness and theoretical results. This section introduces several commonly used proof techniques.

## Common Proof Methods

### 1. Direct Proof

Direct proof starts from known conditions and derives the conclusion through logical reasoning.

**Example**: Prove that the sum of two even numbers is also even.

**Proof**: Let $a = 2m$ and $b = 2n$, where $m, n$ are integers. Then:

$$
a + b = 2m + 2n = 2(m + n)
$$

Since $m + n$ is an integer, $a + b$ is even.

### 2. Proof by Contradiction

Proof by contradiction assumes the conclusion is false, derives a contradiction, and thus proves the original conclusion is true.

**Example**: Prove that $\sqrt{2}$ is irrational.

**Proof**: Assume $\sqrt{2}$ is rational, so it can be expressed as $\frac{p}{q}$ where $p, q$ are coprime. Then:

$$
2 = \frac{p^2}{q^2} \Rightarrow p^2 = 2q^2
$$

This means $p^2$ is even, therefore $p$ is also even. Let $p = 2k$, substituting gives:

$$
4k^2 = 2q^2 \Rightarrow q^2 = 2k^2
$$

This means $q$ is also even, contradicting that $p, q$ are coprime. Therefore $\sqrt{2}$ is irrational.

### 3. Mathematical Induction

Mathematical induction is used to prove propositions that hold for all natural numbers $n$.

**Steps**:
1. **Base case**: Prove the proposition holds for $n = 1$
2. **Inductive step**: Assume the proposition holds for $n = k$, prove it holds for $n = k + 1$

**Example**: Prove that $1 + 2 + \cdots + n = \frac{n(n+1)}{2}$.

**Proof**:

- When $n = 1$: left side = 1, right side = $\frac{1 \times 2}{2} = 1$, holds.
- Assume it holds for $n = k$, i.e., $1 + 2 + \cdots + k = \frac{k(k+1)}{2}$.
- When $n = k + 1$:

$$
1 + 2 + \cdots + k + (k+1) = \frac{k(k+1)}{2} + (k+1) = \frac{k(k+1) + 2(k+1)}{2} = \frac{(k+1)(k+2)}{2}
$$

Therefore, the proposition holds for all positive integers.

### 4. Constructive Proof

Constructive proof proves existence propositions by constructing a specific example.

**Example**: Prove there exist two irrational numbers $a$ and $b$ such that $a^b$ is rational.

**Proof**: Consider $a = \sqrt{2}$ and $b = \sqrt{2}$.

- If $\sqrt{2}^{\sqrt{2}}$ is rational, the proposition is proved.
- If $\sqrt{2}^{\sqrt{2}}$ is irrational, let $a = \sqrt{2}^{\sqrt{2}}$ and $b = \sqrt{2}$, then:

$$
a^b = (\sqrt{2}^{\sqrt{2}})^{\sqrt{2}} = \sqrt{2}^{\sqrt{2} \cdot \sqrt{2}} = \sqrt{2}^2 = 2
$$

Therefore, such a pair of irrational numbers exists.

## Proofs in Discrete Mathematics

In algorithm analysis, we often need to prove:

1. **Algorithm correctness**: Prove the algorithm solves the given problem
2. **Time complexity**: Prove bounds on the algorithm's running time
3. **Optimality**: Prove the solution provided by the algorithm is optimal

### Proving Greedy Choice Property

The correctness of greedy algorithms typically requires proving the greedy choice property and optimal substructure.

**Proof techniques**:
- Use exchange argument
- Use induction to prove each greedy choice is optimal

### Proving Dynamic Programming Correctness

The correctness of dynamic programming requires proving:
- Optimal substructure exists
- State transition equations are correct

## Advanced Topic: Canonical Forms in Linear Algebra

In some algorithms (such as graph algorithms, network flow), linear algebra concepts also appear. For example, the **Jordan Normal Form** is an important concept in matrix theory.

### Introduction to Jordan Normal Form

For an $n \times n$ matrix $A$, if there exists an invertible matrix $P$ such that $P^{-1}AP = J$, where $J$ is in Jordan normal form, then $J$ is called the Jordan normal form of $A$.

The Jordan normal form is a block diagonal matrix, where each block is called a Jordan block:

$$
J = \begin{bmatrix}
J_1 & & \\
& J_2 & \\
& & \ddots \\
& & & J_k
\end{bmatrix}
$$

where each Jordan block $J_i$ has the form:

$$
J_i = \begin{bmatrix}
\lambda & 1 & & \\
& \lambda & 1 & \\
& & \ddots & 1 \\
& & & \lambda
\end{bmatrix}
$$

### Applications

Jordan normal form has applications in:
- Solving systems of linear differential equations
- Analyzing stability of dynamical systems
- Spectral analysis of graphs
- Long-term behavior analysis of Markov chains

!!! note "Discrete Option"

    In discrete mathematics, we focus more on proof techniques in graph theory, combinatorics, and related fields. Although Jordan normal form comes from continuous mathematics (linear algebra), it also has applications in some discrete problems (such as adjacency matrix analysis of graphs).

## Summary

- Proofs are an important component of algorithm analysis
- Different problems require different proof techniques
- In practice, we need to choose appropriate proof methods based on problem characteristics
- Rigorous mathematical proofs help ensure algorithm correctness and efficiency

## References

- Basic techniques of mathematical proof can be found in discrete mathematics textbooks
- Algorithm correctness proofs can be found in "Introduction to Algorithms" Chapter 2
- Detailed theory of Jordan normal form can be found in advanced linear algebra textbooks
