#import "../index.typ": template, tufted
#show: template.with(title: "波")
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
#show heading.where(level: 2): set block(below: 1em, above: 2em)
#show heading.where(level: 3): set block(below: 1em, above: 2em)
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
#let definition = definition.with(fill: blue.darken(10%))
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

= 波方程，双曲守恒律

== 利用 Fourier 变换求解波方程

在 $RR_x^d times RR_t$ 上，初始值为 $f,g in S(RR^d)$. 波方程为
$ (partial^2 u)/(partial x_1^2)+ ...+ (partial^2 u)/(partial x_d^2) = 1/c^2 (partial^2 u)/(partial t^2) $
其中 $c$ 是波速，对 $t$ 缩放后，方程变为
$ laplace u=(partial^2 u)/(partial x_1^2)+ ...+ (partial^2 u)/(partial x_d^2) = (partial^2 u)/(partial t^2) $

Cauchy 问题附加两个初始条件
$ u(x,0) = f(x), (partial u)/(partial t)(x,0) = g(x) $

对 $x$ 进行 Fourier 变换，得到
$ hat((partial^2 u)/(partial x_j^2))(xi,t)=(2 pi i xi_j)^2 u(x,t) $
