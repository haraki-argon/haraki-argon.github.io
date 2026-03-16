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

= Lebsuege 积分

*目标：证明 Lebsuege 测度的存在性.*

Step 1. 外测度（Outer Measure）$m^*(Omega)$ 的定义
$ arrow.b.double ("无可数可加性") $
Step 2. Lebsuege 可测集

Step 3. $m(Omega):=m^*(Omega)$

== 可测集

可测集由以下4条性质定义：

+ （Borel 性质）$RR^n$ 中的开集，闭集均可测.

+ （补集）若 $Omega$ 可测，则 $RR^n\\Omega$ 也可测.

+ （Boolean 代数性质）可测集在有限交、有限并下封闭. 若 $(Omega_j)_(j in J)$ 是一族有限多的可测集，那么 $union.big(j in J) Omega_j$ 和 $inter.big_(j in J) Omega_j$ 也是可测集.

+ （$sigma$-代数性质）可测集在可数交、可数并下封闭. 若 $(Omega_j)_(j in J)$ 是一族可数多的可测集，那么 $union.big(j in J) Omega_j$ 和 $inter.big_(j in J) Omega_j$ 也是可测集.

$""$

我们希望 Lebsuege 测度 $m(Omega)$ 还能满足以下9条性质：
5. (空集) 空集 $emptyset$ 的测度为 $m(emptyset)=0$.

+ (非负性) 对于每一个可测集 $Omega$，都有 $0 <= m(Omega) <= +infinity$.

+ (单调性) 如果 $A subset.eq B$，且 $A$ 与 $B$ 均为可测集，则 $m(A) <= m(B)$.

+ (有限*次可加*性) 如果 $(A_j)_(j in J)$ 是有限个可测集的集合，则 $ m(union.big_(j in J) A_j) <= sum_(j in J) m(A_j) $

+ (有限可加性) 如果 $(A_j)_(j in J)$ 是有限个互不相交的可测集的集合，则 $ m(union.big_(j in J) A_j) = sum_(j in J) m(A_j) $

+ (可列*次可加*性) 如果 $(A_j)_(j in J)$ 是可列个可测集的集合，则 $ m(union.big_(j in J) A_j) <= sum_(j in J) m(A_j) $

+ (可列可加性) 如果 $(A_j)_(j in J)$ 是可列个互不相交的可测集的集合，则 $ m(union.big_(j in J) A_j) = sum_(j in J) m(A_j) $

+ (归一性) 单位立方体 $ [0,1]^n = {(x_1, ..., x_n) in RR^n : 0 <= x_j <= 1 ,forall 1 <= j <= n} $ 的测度为 $m([0,1]^n)=1$.

+ (平移不变性) 如果 $Omega$ 是一个可测集，且 $x in RR^n$，那么 $x + Omega := {x + y : y in Omega}$ 也是可测的，且 $m(x + Omega) = m(Omega)$.

#theorem(title: "Lebsuege 测度的存在性")[
  存在一种可测集的定义和一种测度的定义，使得上述 13 条性质都成立.
]

#definition(title: "开矩形, open box")[
  一个开矩形 $B subset.eq RR^n$ 形如
  $ B=product_(i=1)^n (a_i, b_i) $
  其体积定义为 $"Vol"(B) = product_(i=1)^n (b_i - a_i)$.
]

#definition(title: "覆盖, cover")[
  设 $Omega$ 是 $RR^n$ 的一个子集，如果 $B_j$ 是 $RR^n$ 中的一族开矩形，且 $Omega subset.eq union.big(j in J) B_j$，则称 $(B_j)_(j in J)$ 是 $Omega$ 的一个覆盖.
]

#definition(title: "外测度, outer measure")[
  $Omega$ 是一个集合，我们定义其上的外测度为
  $ m^*(Omega) = inf {sum_(j in J) "Vol"(B_j), (B_j){j in J} "覆盖" Omega, J "至多可数"} $
]

#lemma[
  如是定义的外测度满足前述 5,6,7,8,10,13 条性质.
]

#proposition(title: "开矩形的外测度")[
  如果 $B$ 是一个开矩形，则 $m^*(B) = "Vol"(B)$. 具体地，外测度还满足归一性 12.
]

#proposition(title: "外测度折戟于可数可加性, 1905, Vitali")[
  存在一列不交可测集 $Omega_1, Omega_2, ... subset.eq RR$ 使得
  $ m^*(union.big_(n=1)^(oo) Omega_n) = sum_(n=1)^(oo) m^*(Omega_n) $
]

#proof[
  定义 $[0,1]$ 上的等价关系 $x tilde y <==> x-y in QQ$. 由选择公理，存在集合 $E subset.eq [0,1]$ 为所有等价类的代表元. 取全部 $[-1,1]$ 上的有理数 $q_1, q_2, ...$， 定义
  $ Omega_n= E + q_n $
  由定义易知 $Omega_i$ 两两不交. 易证全部并起来有
  $ [0,1] subset.eq union.big_(n=1)^(oo) Omega_n subset.eq [-1,2] $
  由单调性知
  $ 1<=m^*(union.big_(n=1)^(oo) Omega_n)<=3 $
  由平移不变性
  $ m^*(Omega_n) = m^*(E), forall n $
  无论 $m^*(E)$ 的值如何，都不可能有
  $ m^*(union.big_(n=1)^(oo) Omega_n) = sum_(n=1)^(oo) m^*(Omega_n) $
]

