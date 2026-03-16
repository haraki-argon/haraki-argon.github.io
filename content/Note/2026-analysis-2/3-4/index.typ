#import "../index.typ": template, tufted
#show: template.with(title: "Banach 空间中的反函数定理")
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

#let leq = $lt.eq.slant$
#let eps = $epsilon$
#let int = $integral$
#let supp = $"supp"$
#let pd(f, x) = $frac(partial #f, partial #x)$
#let dd(f, x) = $frac(d #f, d #x)$

= Banach 空间中的反映射定理

== $RR^n$ 和 Banach 空间的差别


#align(
  table(
    columns: 3,
    inset: 8pt,
    table.header([], [*$RR^n$*], [*Banach 空间（无限维）*]),
    [微分], [$"d"f, J f(x)$], [有界线性算子#footnote[Bounded Linear Operator] $f' in cal(L)(B_1,B_2)$],
    [可逆性], [$"det" J f(x)!=0$], [$f'(x)$ 是同构#footnote[双射+逆映射有界]],
    [关键工具], [行列式、余子式], [Neumann 级数#footnote[$(I-E)=I+E+...$]],
    [正则性], [$A^(-1)$ 的有理连续性], [$T->T^(-1)$ 的范数连续性],
  ),
  center,
)

#theorem(title: "Banach 空间中的局部反映射定理")[
  $B_1,B_2$ 是两个 Banach 空间. 取开集 $U subset.eq B_1$，$f:U->B_2$ 是 $C^1$ 映射. 对于 $x_0 in U, y_0=f(x_0)$.

  如果 $f'(x_0):B_1->B_2$ 是一个同构，那么存在 $x_0$ 的一个邻域 $V$ 和 $y_0$ 的一个邻域 $W$，使得 $f:V->W$ 是一个 $C^1$-微分同胚，即 $f^(-1) in C^1(W,V)$，且 $ (f^(-1))'(y)=[f'(f^(-1)(y))]^(-1) $
]

为了证明这个定理，我们先补充一个引理.

#lemma(title: "开性引理：GL(B₁,B₂) 是开集")[
  $"GL"(B_1,B_2)$ 是 $B_1,B_2$ 之间所有可逆线性算子且逆算子有界（同构）的集合. 那么 $"GL"(B_1,B_2)$ 是 $cal(L)(B_1,B_2)$ 中的一个开集，即若 $T_0 in "GL"(B_1,B_2)$ 且 $T in cal(L)(B_1,B_2)$ 且 $ ||T-T_0||<1/(||T_0^(-1)||), $ 则 $T in "GL"(B_1,B_2)$ 且逆像映射 $T->T^(-1)$ 是连续的.
]
#proof[注意到
  $ T=T_0(I-#box(fill: rgb("#ffe4e4"))[$T_0^(-1)(T_0-T)$]) $
  令 $S=T_0^(-1)(T_0-T)$，则
  $ ||S||<= ||T_0^(-1)|| ||T_0-T|| <1. $
  由 Neumann 级数，
  $ I+S+S^2+ ...=(I-S)^(-1) $
  收敛，从而
  $ T^(-1)=(I-S)^(-1)T_0^(-1) $#footnote[?]
  且（连续性估计）
  $ ||T^(-1)-T_0^(-1)||<=||T^(-1)|| ||T_0^(-1)|| ||T-T_0|| $
  于是 $||T-T_0||->0$ 时 $||T^(-1)-T_0^(-1)||->0$.
]

#line(length: 150pt, stroke: 0.5pt)

#proof(title: "定理的证明")[]
