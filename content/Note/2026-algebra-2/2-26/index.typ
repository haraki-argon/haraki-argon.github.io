#import "../index.typ": template, tufted
#show: template.with(title: "域扩张")
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
#let proposition = proposition.with(fill: red.darken(10%))
#set-inherited-levels(1)
#let leq = $lt.eq.slant$
#let eps = $epsilon$
#let int = $integral$
#let supp = $"supp"$
#let pd(f, x) = $frac(partial #f, partial #x)$
#let dd(f, x) = $frac(d #f, d #x)$

= 域扩张

#definition(title: "域扩张, field extension")[
  设 $E$ 是域，其子集 $F subset E$ 关于 $E$ 的运算构成域，称 $F$ 为 $E$ 的*子域*，称 $E$ 是 $F$ 的*域扩张*，记作 $E\/F$.

  一般地，若两个域 $E, F$ 之间存在嵌入映射 $F arrow.r.hook E$，则视 $E$ 为 $F$ 的域扩张.
]

#example[$QQ[x] \/ (x^2 + 1) arrow.r.hook CC$.]

#example[对于域 $F$，存在自然同态 $f: ZZ -> F,1|->1$.
  + 若 $ker f = (0)$，则 $F$ 包含一个同构于 $QQ$ 的子域.
  + 若 $ker f = (p)$（$p$ 为素数），则 $F$ 包含一个同构于 $ZZ\/p ZZ$ 的子域.
]


称 $QQ$ 或 $ZZ_p$ 为 $F$ 的*素域* (primitive subfield).

设域扩张 $E\/F$，$S subset E$. 记 $F(S)$ 为由 $S$ 生成的包含 $F$ 和 $S$ 的最小子域.

#definition(
  title: "单扩张, simple extension",
)[若 $S = {u}$，则 $F(u)\/F$ 称为*单扩张*，$u$ 称为*本原元* (primitive element).]
此时 $F(u) = { f(u) / g(u) | f, g in F[x], g(u) eq.not 0 }$.

*求值同态*：定义 $ phi: F[x] & -> F(u) \
     f(x) & |-> f(u) $
其像 $"Im" phi = F[u]$，是 $E$ 中由 $F$ 和 $u$ 生成的子环.

== 代数元与超越元
根据 $ker phi$ 的情况，可以将 $u$ 分为两类：

+ *超越元* (transcendental element)：若 $ker phi = (0)$，则 $phi$ 是单射，此时 $F(x) tilde.eq F(u)$.

+ *代数元* (algebraic element)：若 $ker phi = (g(x)) eq.not (0)$，其中 $g(x)$ 为不可约多项式.
  此时 $F[x] \/ (g(x)) tilde.eq F[u] = F(u)$.
  取首一不可约多项式 $g(x)$，称其为 $u$ 在 $F$ 上的*极小多项式* (minimal polynomial).

#definition(title: "代数扩张与超越扩张")[
  对于扩张 $E\/F$，若 $E$ 中每个元素都是 $F$ 上的代数元，则称 $E\/F$ 为*代数扩张*；反之则称为*超越扩张*.
]

== 扩张次数
对域扩张 $E\/F$，可以将 $E$ 看作 $F$ 上的线性空间.
#definition(title: "扩张次数")[
  记 $[E:F] := dim_F E$ 为该域扩张的*次数* (degree).

  若 $[E:F] < infinity$，称其为*有限扩张* (finite extension)，反之为*无限扩张* (infinite extension).
]

*例*：$[CC : RR] = 2$，$[QQ(sqrt(-1)) : QQ] = 2$.

事实上，若 $[E:F] = 2$ 且 char $F eq.not 2$，则存在 $alpha in E$ 使得 $E = F(alpha)$ 且 $alpha^2 in F$.

== 范数与迹 (Norm & Trace)
对于有限扩张 $E\/F$，任取 $alpha in E$，映射 $L_alpha: E -> E$（$x |-> alpha x$）是 $F$ 上的线性变换.
#definition(title: "范数与迹")[
  *Norm*：$N_(E\/F) (alpha) := det(L_alpha)$.

  *Trace*：$"Tr"_(E\/F) (alpha) := tr(L_alpha)$.
]
#proposition[
  $a,b in F, alpha,beta in E$.

  - $N_(E\/F)(alpha beta) = N_(E\/F)(alpha) N_(E\/F)(beta)$

  - $N_(E\/F)(a beta) = a^[E:F] N_(E\/F)(beta)==> N_(E\/F)(a)=a^[E:F]$

  - $"Tr"_(E\/F)(a alpha + b beta) = a "Tr"_(E\/F) (alpha) + b "Tr"_(E\/F)(beta)==> "Tr"_(E\/F)(a)=[E:F]dot a$
]
#proposition[
  $E\/K\/F$ 均为有限扩张，
  $"Tr"_(E\/F) = "Tr"_(K\/F) compose "Tr"_(E\/K), N_(E\/F) = N_(K\/F) compose N_(E\/K).$
]
== 有限扩张相关

#proposition[
  $E\/F$ 是域扩张，$u in E$ 是 $F$ 上的代数元，$g(x)$ 是 $u$ 的极小多项式，则 $[F(u):F] = deg g(x)$.

  反之，若 $[F(u):F] < +infinity$，则 $u$ 是 $F$ 上的代数元.
]

#corollary[
  有限扩张都是代数扩张.
]

#theorem[$E\/K\/F$ 均为域扩张，则 $E\/F$ 是有限扩张当且仅当 $E\/K$ 和 $K\/F$ 都是有限扩张.

  此时 $[E:F] = [E:K][K:F]$.]


#corollary[$E\/K\/F$ 均为域扩张，$[E:F]<+oo$，则$[E:K] | [E:F]$ 且 $[K:F] | [E:F]$.

  特别地，若 $[E:F]$ 是素数，不存在 $K$ 使得 $F subset.neq K subset.neq E.$（无中间域）
]
#definition(title: "中间域, intermediate field")[
  对于域扩张 $E\/F$，若存在域 $K$ 满足 $F subset K subset E$，则称 $K$ 是 $E\/F$ 的*中间域*.]

#corollary[$E\/F$ 是有限扩张等价于存在有限多个 $F$ 上的代数元 $u_1, u_2, ..., u_n$ 使得 $E = F(u_1, u_2, ..., u_n)$.
]

#theorem(title: "Steinitz")[
  $E\/F$ 是有限扩张，则 $E\/F$ 是单扩张等价于 $E\/F$ 有有限多个中间域.]
