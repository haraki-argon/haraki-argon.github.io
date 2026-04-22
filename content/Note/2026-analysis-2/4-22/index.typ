#import "../index.typ": template, tufted
#show: template.with(title: "Riemann 流形上的积分")
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
#show heading.where(level: 1): set block(below: 2em, above: 2em)
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

= 大作业
*特别鼓励有想法、有尝试、有创新、融会贯通、灵活运用*

$<15$ 页 中文 LaTeX

`However, I would like to use Typst!`

主题：

$ "d"*"d"u=f nu "在" S^2 "上的求解" $
相关内容：
分片常数逼近、微分形式、Hodge 算子、Stokes 公式、极大值原理及其推论

框架：
+ 摘要

  研究问题，方法，结果，创新点，参考材料

  明确创新点，标注

+ 引言

  介绍问题

+ 预备知识

  有机梳理相关概念，定理，工具

+ $RR^2$ 上的 Dirichlet 问题

  $"d"*"d"u=f "d"x and "d"y$

+ $S^2$ 上的 Poisson 方程问题

#pagebreak()

= 授業

== Riemann 度量的存在性问题

#theorem(title: "Riemann 度量的存在性")[
  任一光滑流形都存在一个 Riemann 度量。
]
#proof[
  Sketch：将每个局部欧氏空间度量用单位分解拼接起来.

  对流形 $M$ 取其光滑图册 ${(U_alpha,chi_alpha)}$. 在每个 $U_alpha$ 上定义一个局部欧式度量 $ g^((alpha))=sum_(i=1)^n "d"x_alpha^i tensor "d"x_alpha^i $
  那么 $g^((alpha))$ 是正定对称的 (0,2) 张量.

  令 ${phi_alpha}$ 是一个光滑的单位分解，从属于 ${U_alpha}$，使得
  + $sum phi_alpha = 1$

  + $0<=phi_alpha<=1$

  + $supp (phi_alpha) subset.eq U_alpha$

  定义
  $ g=sum phi_alpha g^((alpha)) $

  容易验证 $g$ 半正定，对称. 注意对 $v in T_p M \\{p}$，由于 $sum_alpha phi_alpha=1$，至少存在一个 $alpha$ 使得 $phi_alpha>0$，因此 $ g(v,v)>=g^((alpha))(v,v)>0, $从而是正定的. 因此 $g$ 是一个 Riemann 度量.
]

#remark[
  根据 Gauss–Bonnet 定理，$S^2$ 上不可能存在平坦度量.

  $ 0?=int_(Sigma) K "d"V_g=2 pi chi(S^2)=4pi $
]

== 拉回度量

我们先回顾切映射、拉回的内容.

#definition(title: "切映射, differential of a smooth map")[
  设 $F:M->N$ 是一个光滑映射，取 $p in M$，则 $F$ 在 $p$ 处的切映射是一个线性映射
  $ "d"F_p: T_p M -> T_(F(p)) N $
  由
  $ "d"F_p (v) (f)=v(f compose F), forall f in C^oo (N) $
  定义.
]
#proposition(title: [$"d"F$的局部坐标表示])[
  设 $f:M->N$ 是一个光滑映射，$"dim" M=m,"dim" N=n$. 设 $(x^1,...,x^m)$ 为 $M$ 的一个局部坐标卡，取 $(y^1,...,y^n)$ 为 $N$ 的一个局部坐标卡，记

  $ y^j compose f=f^j (x^1,...,x^m), j=1,...,n $

  于是 $forall i=1,...,m$，有
  $
    "d"f_p ( lr(partial/(partial x^i)|)_p )= sum_(j=1)^n (partial f^j)/(partial x^i) lr((partial)/(partial y^j)|)_(f(p))
  $

  更一般地，令 $X$ 是一个光滑向量场
  $ X=sum_(i=1)^m X^i (partial/(partial x^i)) $
  那么
  $ "d"f_p (X)= sum_(j=1)^n (sum_(i=1)^m X^i (p) (partial f^j)/(partial x^i) (p))lr(partial/(partial y^j)|)_(f(p)) $
]
#proof[
  由于
  $ "d"f_p ( lr(partial/(partial x^i)|)_p ) in T_(f(p)) N $
  我们设其在 $T_(f(p)) N$ 中的基表示
  $ "d"f_p ( lr(partial/(partial x^i)|)_p )= sum_(j=1)^n A_i^j lr((partial)/(partial y^j)|)_(f(p)) $

  回忆定义 (7)

  $ "d"F_p (v) (f)=v(f compose F), forall f in C^oo (N) $

  我们来解出 $A_i^j$: 固定 $k in {1,...,n}$，在 (13)  式子两侧同时作用 $y^k$，
  $ "RHS"=sum_(j=1)^n A_i^j lr((partial)/(partial y^j)|)_(f(p)) y^k=A_i^k $
  $
    "LHS" & ="d"f_p ( lr(partial/(partial x^i)|)_p )y^k \
          & =lr(partial/(partial x^i)|)_p (y^k compose f) \
      (8) & =(partial f^k)/(partial x^i) (p)
  $
  故
  $ A_i^k= (partial f^k)/(partial x^i) (p) $
  代入即得到 (9) 式，
  $
    "d"f_p ( lr(partial/(partial x^i)|)_p )= sum_(j=1)^n (partial f^j)/(partial x^i) lr((partial)/(partial y^j)|)_(f(p))
  $

  得到基上的作用之后，由线性性，一般的结论是显然的，略.
]

#example[
  令 $ F: RR & ->RR^2 \
      t & |-> (cos t, sin t) $
  计算 $"d"F("d"/("d"t))$.

  #solution[
    假设 $ "d"F("d"/("d"t))=a (partial)/(partial x)+b (partial)/(partial y) $
    两边作用 $x$
    $ "d"/("d"t) (cos t)=a==>a=-sin t $
    两边作用 $y$
    $ "d"/("d"t) (sin t)=b==>b=cos t $
    故
    $ "d"F("d"/("d"t))=-sin t (partial)/(partial x)+cos t (partial)/(partial y). $
  ]
]
