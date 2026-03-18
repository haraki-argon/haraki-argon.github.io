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
#set enum(numbering: "(1)(a)")

= Lebsuege 测度 (2)

== Carathéodory 准则

#definition(title: "Lebsuege 可测，Carathéodory 准则")[
  $E$ 是 $RR^n$ 的一个子集，$E$ 是*Lebsuege 可测*的当且仅当
  $ forall A subset.eq RR^n, m^*(A)=m^*(A inter E)+m^*(A \\ E) $
]
#example(title: "例1")[
  $E=[1,3]$. 取 $A=[0,2]$，带入等式成立.
]

#example(title: "例2（\"Bad Set\"）")[
  $E subset.eq [0,1]$ 是 Vitali 集合#footnote[$x~y <==> x-y in Q$ 的等价类代表元集], $A=[0,1]$, $m^*(A)=1$. 我们想说明 $ m^*(A)<m^*(A inter E)+m^*(A \\ E). $

  + 证明 $m^*(E)>0$. 令 $QQ inter [-1,1]={q_1, q_2, ...}, Omega_n= E+q_n$，则

    于是
    $ 1 <= m^*([0,1])= m^*(union.big_(n=1)^oo Omega_n)<=sum_(n=1)^oo m^*(Omega_n) <= sum_(n=1)^oo m^*(E) $
    若 $m^*(E)=0$ 则矛盾.

  + 断言若 $F subset.eq E$, $F$ 可测，$m(F)=0$.
    令 $F_n=F+q_n$, 则 $F_n$ 之间两两不交.
    $ union.big_(n=1)^oo F_n subset.eq [-1,2] $
    由单调性
    $ sum_(n=1)^oo m(F)=sum_(n=1)^oo m(F_n)<=3 $
    故只能是 $m(F)=0$.

  + 断言 $m^*([0,1]\\E)=1$. 令 $U$ 为任一包含 $[0,1]\\E$ 的可测集，则
    $ [0,1]\\U subset.eq E $
    取 $F=[0,1]\\U$ 是可测集，由上一步 $m(F)=0$，所以 $m(U)=1$. 由单调性 $ m^*([0,1]\\E)=1. $

  + $m^*(E)>0, m^*([0,1]\\E)=1$，代入 Carathéodory 准则的等式右端，得到 $ m^*(A inter E)+m^*(A \\ E) > 1 = m^*(A). $
]
#remark[如果 $E$ 满足 Carathéodory 准则，则 $E$ 是 Lebsuege 可测的，其 Lebsuege 测度 $m(E):=m^*(E)$.
]

#lemma(title: "Lebsuege 测度的可数可加性")[
  若 $(E_j)_(j in J)$ 是一族可数的不交 Lebsuege 可测集，那么 $union.big_(j in J) E_j$ 也是可测的，并且 $ m(union.big_(j in J) E_j)=sum_(j in J) m(E_j). $
]
#proof[
  令 $E=union.big_(j in J) E_j$，对任意的 $A subset RR^n$，要证明 $ m^*(A)=m^*(A inter E)+m^*(A \\ E). $
  设 $J={j_1, j_2, ...}$，则
  $ A inter E & = A inter union.big_(j in J) E_j= union.big_(j in J) (A inter E_j) $
  由次可数可加性，
  $
    m^*(A inter E) & <= sum_(j in J) m^*(A inter E_j)
                     <= sup_(N>=1) sum_(k=1)^N m^*(A inter E_j_k)
  $
  令 $F_N=union.big_(k=1)^N (A inter E_j_k)$. 由于 $A inter E_j_k$ 之间两两不交，$F_N$ 是可测的，由有限可加性
  $ sum_(k=1)^N m^*(A inter E_j_k) =("Lemma 7.4.5")= m^*(A inter F_N)<= sup_(N>=1) m^*(A inter F_N) $
  由于 $F_N subset.eq E$，我们有 $A\\E subset.eq A\\ F_n$，由单调性
  $ m^*(A\\E) <= m^*(A\\ F_N) $
  于是
  $ m^*(A inter E)+m^*(A \\ E) <= sup_(N>=1) m^*(A inter F_N)+m^*(A\\ F_N) $
  由 Lemma 7.4.5
  $ m^*(A inter F_N)+m^*(A\\ F_N) = m^*(A) $
  于是
  $ m^*(A inter E)+m^*(A \\ E) <= m^*(A) $
  由有限次可加性
  $ m^*(A inter E)+m^*(A \\ E)>= m^*(A) $
  从而
  $ m^*(A inter E)+m^*(A \\ E) = m^*(A) $
  由 Carathéodory 准则，$E$ 是可测的，并且 $m(E)=m^*(E)$.
  最后来证
  $ m^*(E)=sum_(j in J) m^*(E_j) $
  (homework.)
]

#definition(title: "可测函数, Measurable function")[
  $Omega$ 为一个 $RR^n$ 中的可测集，$f: Omega -> RR^m$ 是一个函数，称 $f$ 是*可测函数*如果 对于任意的开集 $V subset.eq RR^m$，$f^(-1)(V)$ 是 $Omega$ 中的一个可测集.
]
#lemma(title: "连续函数可测")[
  如果 $Omega$ 是 $RR^n$ 中的一个可测集，$f: Omega -> RR^m$ 是一个连续函数，则 $f$ 是一个可测函数.
]
#proof[
  连续函数对开集的逆像是开集，开集是可测的.
]

#lemma[
  令 $Omega$ 是 $RR^n$ 中的一个可测集，$f: Omega -> RR^m$ 是一个可测函数等价于对任意的开矩形 $B subset.eq RR^m$，$f^(-1)(B)$ 是 $Omega$ 中的一个可测集.
]
