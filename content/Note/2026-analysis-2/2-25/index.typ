#import "../index.typ": template, tufted
#show: template.with(title: "反函数定理")
#import "@preview/theorion:0.4.1": *
#import cosmos.rainbow: *
#show: show-theorion
#set text(
  font: (
    (name: "New Computer Modern", covers: "latin-in-cjk"), // 西文字体
    "Source Han Serif", // 中文字体
  ),
  lang: "zh",
)
#show math.equation: set text(font: (
  (name: "New Computer Modern Math", covers: "latin-in-cjk"), // 数学
  (name: "Source Han Serif", covers: regex(".")), // 中文
))
#show raw: set text(
  font: (
    (name: "New Computer Modern", covers: "latin-in-cjk"), // 西文字体
    "Source Han Serif", // 中文字体
  ),
  lang: "zh",
)
#show math.equation: set text(features: ("cv01",))
#set par(leading: 0.9em)
#show heading.where(level: 1): set block(below: 2em, above: 2em)
#show heading.where(level: 2): set block(below: 1em, above: 2em)
#show heading.where(level: 3): set block(below: 1em, above: 2em)
#set math.equation(numbering: "(1)")
#show math.equation.where(block: true): it => {
  if not it.has("label") {
    let fields = it.fields()
    let _ = fields.remove("body")
    fields.numbering = none
    [#counter(math.equation).update(v => v - 1)#math.equation(..fields, it.body)<math-equation-without-label>]
  } else {
    it
  }
}
#let definition = definition.with(fill: blue.darken(10%))

#let leq = $lt.eq.slant$
#let eps = $epsilon$
#let int = $integral$
#let supp = $"supp"$
#let pd(f, x) = $frac(partial #f, partial #x)$
#let dd(f, x) = $frac(d #f, d #x)$

= 反函数定理

== $RR^2$ 上的极坐标
设映射 $Phi: (r, theta) |-> (x, y)$，定义域为 $Omega = (0, infinity) times (0, 2pi)$.
其值域为 $ Omega' = Phi(Omega) = RR^2 \\ {((x, 0) | x >= 0) }. $
具体坐标变换关系为：
$ x = r cos theta, quad y = r sin theta $

$Phi: Omega -> Omega'$ 是双射，其微分 $d Phi: RR^2 -> RR^2$ 的 Jacobi 矩阵为：
$ J Phi (r, theta) = pd((x, y), (r, theta)) = mat(cos theta, -r sin theta; sin theta, r cos theta) $
计算行列式得 $det J Phi = r > 0$.

== 链式法则与算子变换
根据逆矩阵公式，可得其逆映射的 Jacobi 矩阵：
$
  (J Phi)^(-1) = mat(cos theta, sin theta; -1/r sin theta, 1/r cos theta) = mat(pd(r, x), pd(r, y); pd(theta, x), pd(theta, y))
$

利用链式法则，可将直角坐标下的偏导算子转化为极坐标形式：
$ pd(, x) = pd(, r) pd(r, x) + pd(, theta) pd(theta, x) = cos theta pd(, r) - 1/r sin theta pd(, theta) $
$ pd(, y) = pd(, r) pd(r, y) + pd(, theta) pd(theta, y) = sin theta pd(, r) + 1/r cos theta pd(, theta) $

== Laplace 算子
在极坐标系下，Laplace 算子 $Delta f$ 表示为：
$ Delta f = pd(f^2, x^2) + pd(f^2, y^2) = pd(f^2, r^2) + 1/r pd(f, r) + 1/r^2 pd(f^2, theta^2) $


= 微分同胚与拉回 (Diffeomorphism & Pull-back)

#definition(title: "微分同胚")[
  设 $Omega, Omega' subset RR^n$，映射 $Phi: Omega -> Omega'$ 称为 $C^m$ *微分同胚* ($m >= 1$)，若满足：
  1. $Phi$ 是双射；
  2. $Phi, Phi^(-1) in C^m (Omega, Omega')$.
  *注*：当 $m=0$ 时，仅称为同胚 (Homeomorphism).
]

#definition(title: "拉回 Pull-back")[
  对于标量函数 $f: Omega_2 -> RR$ 及映射 $Phi: Omega_1 -> Omega_2$，定义拉回 $Phi^* f$ 为：
  $ Phi^* f := f compose Phi $

  其微分关系满足链式法则：
  $ pd((Phi^* f), x) = pd(f, y) dot pd(Phi, x) $
]

== 微分的不变性 (Invariance of the Differential)
设 $"d"f = sum_(k=1)^n pd(f, y_k) "d"y_k$.
若 $y_k$ 本身是关于 $x_j$ 的函数，即 $"d"y_k = sum_(j=1)^n pd(y_k, x_j) "d"x_j$，则：
$ "d"f = sum_(k=1)^n pd(f, y_k) (sum_(j=1)^n pd(y_k, x_j) "d"x_j) = sum_(j=1)^n pd(f, x_j) "d"x_j $



= 反函数定理 (Inverse Function Theorem)

#theorem[
  设 $Omega subset RR^n$ 是开集，$f: Omega -> RR^n$ 是 $C^1$ 映射.

  若在点 $p$ 处，$d f(p): RR^n -> RR^n$ 是可逆线性映射(即 $det J f(p) eq.not 0$)，则 $f$ 在 $p$ 附近是一个*局部微分同胚*.

  具体而言，存在 $p$ 的开邻域 $U$ 和 $f(p)$ 的开邻域 $V = f(U)$，使得 $f|_U: U -> V$ 是一个 $C^1$ 微分同胚.
]

== 证明的想法

1. Newton Iteration Scheme (牛顿迭代).

  $p = x_0, f(x_0) = y_0$.

  $f(x) approx f(x_0) + "d"f(x_0) (x - x_0) ==> x - x_0 approx "d"f^(-1) (x_0) (f(x) - f(x_0))$.

2. 压缩映射原理.

== 证明步骤

*Step 1.定义简化 Newton 迭代 (Modified Newton$'$s iteration).*

给定 $y$，定义序列：
$ cases(x_(n+1) = x_n + "d"f^(-1) (x_0) (y - f(x_n)), x_0 = p) $

*Step 2. 定义映射 $T_y (x) = x + "d"f^(-1) (x_0) (y - f(x))$（只需找不动点）.*

$ "d"T_y (x) = I - "d"f^(-1) (x_0) "d"f(x)= "d"f^(-1) (x_0) ("d"f(x_0) - "d"f(x)). $

由 $f in C^1$，$"d"f$ 在 $x_0$ 连续，那么对于 $epsilon = 1/2 dot ||"d"f^(-1) (x_0)||^(-1)$，存在 $r > 0$，使得 $forall x in B(x_0, r)$ 有：

$ ||"d"f(x_0) - "d"f(x)|| < epsilon = 1/2 ||"d"f^(-1) (x_0)||^(-1) $

于是：

$
  ||"d"T_y|| & leq ||"d"f^(-1) (x_0)|| dot ||"d"f(x_0) - "d"f(x)|| leq 1/2
$

条件 ①：因此 ($x in B(x_0, r)$ 同前)  $ ||T_y (x) - T_y (x_0)|| leq ||"d"T_y|| dot ||x - x_0|| leq 1/2 ||x - x_0|| $


条件 ②：$T_y$ 将 $overline(B)(x_0, r/2)$ 打进自身. $forall x in overline(B)(x_0, r/2)$ 有：

$
  ||T_y (x) - x_0|| & leq ||T_y (x) - T_y (x_0)|| + ||T_y (x_0) - x_0|| \
                    & leq 1/2 ||x - x_0|| + ||"d"f^(-1) (x_0)|| ||y - y_0||
$

令 $||y - y_0|| leq delta = r / (4 ||"d"f^(-1) (x_0)||)$，则有

$ ||T_y (x) - x_0|| leq 1/2 dot r/2 + r/4 = r/2. $

由条件 ①，② 及压缩映像原理，序列 $x_n$ 收敛到 $x_*$ 且 $T_y (x_*) = x_*$，即 $f(x_*) = y$.

== 误差估计
序列按线性收敛 (Linear convergence)：
$ ||x_n - x_*|| leq (1/2)^n ||x_0 - x_*|| $
这是因为 $||x_(n+1) - x_*|| = ||T_y (x_n) - T_y (x_*)|| leq 1/2 ||x_n - x_*||$.
