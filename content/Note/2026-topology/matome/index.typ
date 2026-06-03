//#import "../index.typ": template, tufted
//#show: template.with(title: "Topology")
#import "@preview/theorion:0.4.1": *
#import cosmos.rainbow: *
#show: show-theorion
#set text(
  font: (
    (name: "New Computer Modern", covers: "latin-in-cjk"), // 西文字体
    "Source Han Serif", // 中文字体
  ),
  lang: "en",
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
#show heading.where(level: 1): set block(below: 1em, above: 2em)
#show heading.where(level: 2): set block(below: 2em, above: 2em)
#show heading.where(level: 3): set block(below: 1em, above: 1em)
#set math.equation(numbering: "(1)")
/*#show math.equation.where(block: true): it => {
  if not it.has("label") {
    let fields = it.fields()
    let _ = fields.remove("body")
    fields.numbering = none
    [#counter(math.equation).update(v => v - 1)#math.equation(..fields, it.body)<math-equation-without-label>]
  } else {
    it
  }
}*/
#let definition = definition.with(fill: blue.darken(20%))
#let remark = remark.with(fill: green.darken(60%))
#let proposition = proposition.with(fill: red.darken(10%))
#let lemma = lemma.with(fill: rgb("#f83f8c").darken(10%))
#set text(
  size: 12pt,
)
#let leq = $lt.eq.slant$
#let eps = $epsilon$
#let int = $integral$
#let supp = $"supp"$
#set enum(numbering: "(1)(a)")
#let tensor = $times.o$
#let otimes = $times.o$
#show "…": aaa => "..."
#set heading(numbering: "1.1")
$""$
#align(center, text(size: 20pt, weight: "bold", "Topology Review"))
$""$
= Algebraic Topology
== Homotopy

#definition(title: "Homotopy")[
  $f,g : X->Y$ continuous maps, $h:I times X->Y$ with $h(0,x)=f(x), h(1,x)=g(x)$, denoted by $f tilde.eq g$.
  #remark(title: "null-homotopy")[
    $f tilde.eq C_y$ for some constant map $C_y$.
  ]
  #remark(title: "Homotopy relative to A")[

    $h(t,x)=f(x)=g(x) forall x in A$.
  ]
]
#definition(title: "Homotopy equivalence")[
  Two spaces $X,Y$ are homotopy equivalent if $f:X->Y, g:Y->X$ such that $g compose f tilde.eq "Id"_X$ and $f compose g tilde.eq "Id"_Y$, denoted by $X tilde.eq Y$.

  #remark(title: "contractible")[
    $X tilde.eq \{*\}$.
  ]

]
#remark[*Homotopy* and *homotopy equivalence* are *equivalence relations* over continuous maps and topological spaces, respectively.]


*Deformation retract* $==>$ *Homotopy equivalence*
#definition(title: "Deformation retract")[
  from $X$ to $A subset.eq X$: $H:I times X->X$ with $H(0,-)="Id"_X, H(1,-) in A, H(t,a)=a$

  Namely, $"Id"_X$ to a map images $A$ relative to $A$.
]

== Fundamental Group
#definition(title: "Fundamental group")[
  Fix $b in X$, the *loop* based at $b$($gamma: I->X$ with $gamma(0)=gamma(1)=b$) modulo homotopy relative to endpoints becomes a group $pi_1(X,b)$, under composition of loops and inverse given by reversing the loop.
]

#lemma[
  $pi_1(S^1) tilde.equiv ZZ.$
]
