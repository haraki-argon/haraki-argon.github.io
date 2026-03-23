//#import "../index.typ": template, tufted
//#show: template.with(title: "Lebsuege 测度（1）")
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
  lang: "en",
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

= Problem session

#problem[
  Prove that $E=QQ({sqrt(p_i)})$ is not a finite extension of $QQ$, where $p_i$ are the $i$-th prime numbers.
]

#proof[
  We claim that $sqrt(p_1),...,sqrt(p_n)$ are linearly independent over $QQ$ for any $n$. Let $E_n=QQ(sqrt(p_1), ..., sqrt(p_n))$.

  If does, then $[E:QQ]>=[E_n:QQ]>=n$ gives a contradiction. To prove the claim, assume there exists $c_1,...,c_n in CC$ such that $c_1 sqrt(p_1)+...+c_n sqrt(p_n)=0$. $forall 1<=i<=n,$
  $ "Tr"_(E_n\/QQ)(sum_(j=1)^n c_j sqrt(p_i p_j))=sum_(j=1)^n c_j "Tr"_(E_n\/QQ)(sqrt(p_i p_j))=0 $
  We have
  $
    "Tr"_(E_n\/QQ)(sqrt(p_i p_j)) & ="Tr"_(QQ(sqrt(p_i p_j)\/QQ))compose "Tr"_(E_n\/QQ(sqrt(p_i p_j)))(sqrt(p_i p_j)) \
                                  & =[E_n\/QQ(sqrt(p_i p_j))]"Tr"_(QQ(sqrt(p_i p_j)\/QQ))(sqrt(p_i p_j)) \
  $
  which equals $0$ if $i != j$.
  Hence $ sum_(j=1)^n c_j "Tr"_(E_n\/QQ)(sqrt(p_i p_j))=[E_n\/QQ]c_i p_i=0 ==>c_i=0,forall 1<=i<=n $

]

= Homological algebra

=== Constructions on Homological Algebra

=== Projective & Injective Resolution

=== Derived Functors & Derived Categories

=== Spectral Sequences

$""$

Chain complexes
$$
$ ...->C_(n+1)attach(-->, t: d_(n+1)) C_n attach(-->, t: d_(n)) C_(n-1)... $
such that $d_n compose d_(n+1)=0$ for all $n$.

