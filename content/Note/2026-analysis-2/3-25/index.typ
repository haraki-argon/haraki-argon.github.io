#import "../index.typ": template, tufted
#show: template.with(title: "Lebsuege 测度（1）")
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
#let lemma = lemma.with(fill: rgb("#f83f8c").darken(10%))
#set text(
  size: 12pt,
)
#let leq = $lt.eq.slant$
#let eps = $epsilon$
#let int = $integral$
#let supp = $"supp"$
#set enum(numbering: "(a)")

= Lebsuege 积分 (2)

#lemma(title: "Fatou 引理")[
  $f_n$ 是一列非负可测函数，则
  $ int_Omega liminf_(n->oo) f_n <= liminf_(n->oo) int_Omega f_n $
]
#proof[
  回忆下极限的定义：
  $liminf_(n->oo) f_n = sup_(n>=1) inf_(k>=n) f_k$
  由单调收敛定理，
  $
    int_Omega liminf_(n->oo) f_n = liminf_(n->oo) int_Omega sup_(n>=1) inf_(k>=n) f_k=sup_(n>=1) int_Omega inf_(k>=n) f_k
  $
  由单调性
  $ int_Omega inf_(k>=n) f_k<= int_Omega f_j, forall j>=n $
  对 $j>=n$ 取下确界，得到
  $ int_Omega inf_(k>=n) f_k<= inf_(j>=n) int_Omega f_j $
  因此，
  $
    int_Omega liminf_(n->oo) f_n = sup_(n>=1) int_Omega inf_(k>=n) f_k<= sup_(n>=1) inf_(j>=n) int_Omega f_j = liminf_(n->oo) int_Omega f_n
  $
]

#definition(title: "绝对可积")[
  可测函数 $f$ 叫做绝对可积的，如果 $int_Omega |f| < oo$.
]
对 $f$ 可以取正部和负部 $f=f^+-f^-$，其中 $f^+=max(f, 0)$, $f^-=-min(-f, 0)$.

#definition(title: "Lebsuege 可积")[
  可测函数 $f$ 叫做 Lebsuege 可积的，如果 $f$ 是绝对可积的，并且 $int_Omega f=int_Omega f^+-int_Omega f^-$.
]

#theorem(title: "Lebsuege 控制收敛定理")[
  $Omega subset.eq RR^n$ 可测，${f_n}$ 是一列可测函数，逐点收敛于 $f$，如果存在一个绝对可积函数 $F$ 使得 $|f_n|<= F$ 对所有 $n$ 都成立，那么 $f$ 也可积且
  $ int_Omega f = lim_(n->oo) int_Omega f_n $
]

#proof[
  由引理， $f_n$ 可测，$f$ 也可测.
  $|f_n|<= F$，从而 $f_n$ 绝对可积. $|f|<= F$，从而 $f$ 也绝对可积.

  由于 $F+f_n$ 是非负且收敛至 $F+f$，由 Fatou 引理，
  $ int_Omega (F+f) <= liminf_(n->oo) int_Omega (F+f_n) $
  得到
  $ int_Omega f <= liminf_(n->oo) int_Omega f_n $
  同理
  $ int_Omega (F-f) <= liminf_(n->oo) int_Omega (F-f_n) $
  得到
  $ -int_Omega f <= liminf_(n->oo) -int_Omega f_n<=-limsup_(n->oo) int_Omega f_n $
  这就得到了
  $ limsup_(n->oo) int_Omega f_n <= int_Omega f <= liminf_(n->oo) int_Omega f_n $
  因此，
  $ int_Omega f = lim_(n->oo) int_Omega f_n $
]

== DCT 的应用
=== Ex.1
$ f_n (x)=(n sin(x/n))/(x(1+x^2)),x>0 $
求 $ lim_(n->oo) int_0^oo f_n (x) "d"x $
注意 $f_n->1/(1+x^2)$ 且可以证明 $|f_n|<=1/(1+x^2)$，从而由 DCT
$ lim_(n->oo) int_0^oo f_n (x) "d"x = int_0^oo 1/(1+x^2) "d"x = pi/2 $

== Ex.2 椭圆型偏微分方程的 Galerkin 方法
考虑非线性 Possion 方程
$ - Delta u + g(u)=f(x), x in Omega $
以及边界条件 $ u=0, x in partial Omega $

其中 Laplace 算子
$ Delta u= sum_(i=1)^n (partial^2 u)/(partial x_i^2) $
满足条件
$g(s)$ 是连续的，且 $|g(s)|<=c$，$g(s)dot s>=0$.

目标是找到 $u in H_o^1 (Omega)$ 使得 $forall phi in H_o^1 (Omega)$ 有
$ int_Omega nabla u dot nabla phi + int_Omega g(u) phi = int_Omega f phi $
其中
$ H^1(Omega)={u in L^2(Omega): gradient u in L^2(Omega)} $
赋予范数
$ ||u||_(H^1)= (int_Omega ||u||^2_(L^2) + int_Omega |nabla u|^2_(L^2))^(1/2) $
以及 $H_o^1(Omega)$ 是其中的紧支子空间.

Galerkin 方法：

- *Step 1.* Galerkin 近似.

  定义 $V_m="span"{w_1, w_2, ..., w_m}$，其中 $w_k$ 满足
  $ - nabla w_k = lambda_k w_k, w_k|_(partial Omega) = 0 $
  且用 Schmidt 正交化使得 $int_Omega w_k w_j = delta_(k,j)$.
  取 $phi=w_j$ 得到
  $ int_Omega nabla w_k dot nabla w_j = int_Omega lambda_k w_k w_j = int_Omega lambda_k delta_(k,j) $
  令 $u_m= sum_(k=1)^m c_k w_k$
  带回方程得到
  $ sum_(k=1)^m c_k int_Omega nabla w_k dot nabla w_j + int_Omega g(u_m) w_j = int_Omega f w_j $
  即
  $ sum_(k=1)^m c_k int_Omega lambda_k delta_(k,j) + int_Omega g(u_m) w_j = int_Omega f w_j，forall j=1,2,...,m $
  这是一个关于 $c_k$ 的线性方程组，写成矩阵：
  $
    mat(lambda_1, ; , lambda_2, ; , , dots.down; , , , lambda_m)vec(c_1, c_2, dots.v, c_m)+vec(int g w_1, int g w_2, dots.v, int g w_m)=vec(int f w_1, int f w_2, dots.v, int f w_m)
  $<1>
  我们解出 (1) 后，就得到了 $u_m$ 的表达式.

- *Step 2.* 控制函数：做先验估计. 这里的道理是：如果 $u_m$ 的范数是有界的，那么就可以找到一个函数 $u$ 使得 $u_m$ 收敛于 $u$，并且 $u$ 就是我们要求的解.

  取 $phi=u_m$，由
  $ int_Omega nabla u_m dot nabla u_m + int_Omega g(u_m) u_m = int_Omega f u_m $
  由假设 $g(s)s>=0$，得到
  $ int_Omega nabla u_m dot nabla u_m <= int_Omega f u_m $
  由 Cauchy-Schwarz 不等式，
  $ int_Omega |nabla u_m|^2 <= (int_Omega f^2)^(1/2) (int_Omega u_m^2)^(1/2) $
  由 Poincare 不等式，
  $ ||u_m||_(L^2) <= C ||nabla u_m||_(L^2) $
  从而
  $ ||nabla u_m||_(L^2) <= C ||f||_(L^2)<=C' $
  再由 Poincare 不等式，
  $ ||u_m||_(L^2) <= C' $
  于是(other C)
  $ ||u_m||_(H^1) <= C $<2>
  这就证明了 $u_m$ 的范数是有界的.
  由 (2)，我们取子列 ${u_m}$(notation 注意)
  使得 $u_m$ 在 $H_0^1(Omega)$ 中弱收敛于 $u$. 由 Sobolev 嵌入定理，$u_m$ 在 $L^2(Omega)$ 中强收敛于 $u$.

  （to be continued$"..."$)
