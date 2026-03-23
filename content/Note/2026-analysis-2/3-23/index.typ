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

= Lebsuege 积分

== 简单函数的 Lebsuege 积分

#definition(title: "简单函数, simple function")[
  象集有限的可测函数. 等价地，$sum_(i=1)^N c_i chi_(E_i)$，对于某些可测集 $E_i$.
]
#lemma[
  $f,g : Omega->RR$ 是简单函数，则 $f+g, c f$ 都是简单函数.
]
#lemma[
  $f : Omega->RR$ 可测, $f>=0$，则存在一列单调递增的简单函数 $f_n$ 使得 $f_n->f$.
]



#definition(title: "简单函数的 Lebsuege 积分")[
  对非负简单函数 $f : Omega -> RR$，定义其 Lebsuege 积分为
  $ int_Omega f =sum_(lambda in f(Omega),lambda>0) lambda dot m(Omega inter f^(-1)(lambda)) $
]
#lemma[
  $Omega subset.eq RR^n$ 可测，$E_1,...,E_N$ 是 $Omega$ 中不交的可测集，$c_1,...,c_N$ 是非负实数，则
  $ int_Omega sum_(i=1)^N c_i chi_(E_i) = sum_(i=1)^N c_i m(E_i) $
]
#proposition[
  $f,g : Omega->RR$ 是非负简单函数，则
  + $0<= int_Omega f <= oo$. 进一步，$int_Omega f=0$ 当且仅当 $m({x in Omega, f(x)!=0})=0$.

  + $int_Omega (f+g) = int_Omega f + int_Omega g$.

  + $int_Omega c f = c int_Omega f$ 对任意 $c>=0$.

  + 如果 $f<=g$，则 $int_Omega f <= int_Omega g$.
]
#definition(title: "控制, Majorization")[
  设 $f,g : Omega->RR$ 是非负函数，如果 $f<=g$，则称 $g$ 控制 $f$，或 $f$ 被 $g$ 控制.
]

== 非负函数的 Lebsuege 积分

#definition(title: "非负函数的 Lebsuege 积分")[
  $ int_Omega f := sup{ int_Omega s | 0<=s<=f, s "is a simple function"} $
]

#proposition[
  $f,g : Omega->RR$ 是非负可测函数，则

  + $0<= int_Omega f <= oo$. 进一步，$int_Omega f =0$ 当且仅当 $m({x in Omega, f(x)!=0})=0$，即 $f(x)=0$ a.e.

  + $int_Omega (f+g) = int_Omega f + int_Omega g$.

  + $c>0$, $int_Omega c f = c int_Omega f$.

  + $f<=g$ 则 $int_Omega f <= int_Omega g$.

  + $f=g$ a.e. 则 $int_Omega f = int_Omega g$.
]

#theorem(title: "单调收敛定理, Monotone Convergence Theorem")[
  设 $f_n$ 是一列非负可测函数，且 $f_n$ 单调递增地收敛于 $f$，则
  $ int_Omega f = lim_(n->oo) int_Omega f_n $
]
#proof[
  由单调性
  $ int_Omega f_1 <= int_Omega f_2 <= ... <= int_Omega f $
  得到
  $ lim_(n->oo) int_Omega f_n <= int_Omega f $
  另一方面，由定义
  $ int_Omega f = sup{ int_Omega s | 0<=s<=f, s "is a simple function"} $
  断言
  $forall 0 < eps < 1$,
  $ (1-eps)int_Omega s <= sup_(n in NN*) int_Omega f_n $
  如果成立，令 $eps->0$ 就得到结果.
  下面来证明断言. 固定 $eps$，对 $s<=f$，$forall x in Omega$ 存在 $N(x) in NN^*$ 使得对任意 $n>N$ 都有
  $ f_n (x)>=f_N (x) >= (1-eps)s(x) $
  令 $ E_n={x in Omega :f_n (x)>=(1-eps)s (x)} $
  则 $E_1 subset.eq E_2 subset.eq ...$，且由 $forall x in Omega, exists N ,x in E_N$，有
  $ Omega subset.eq union.big_(n=1)^oo E_n $

  我们想要证明 $Omega=union.big_(n=1)^oo E_n$. 注意
  $ (1-eps)int_(E_n) s = int_(E_n) (1-eps)s <= int_(E_n) f_n <=int_(Omega) f_n $
  只需证
  $ sup_(n in NN*) int_E_n s= int_Omega s $
]

对一般的函数列，不一定可以交换极限和积分.

#example[
  设 $f_n (x)=chi_((n,n+1])$，则 $f_n->0$ 但 $int_R f_n =1$.
]

但是我们可以得到一个不等式：
#lemma(title: "Fatou 引理")[
  $ int_Omega liminf_(n->oo) f_n <= liminf_(n->oo) int_Omega f_n $
]

#remark[
  对一般的函数，可以分为正负两部分来处理.
]
#theorem(title: "控制收敛定理, Dominated Convergence Theorem")[
  设 $f_n$ 是一列可测函数，且 $f_n$ 逐点收敛于 $f$，如果存在一个可积函数 $g$ 使得 $|f_n| <= g$，则
  $ int_Omega f = lim_(n->oo) int_Omega f_n $
]
#theorem(title: "Fubini 定理")[
  设 $f$ 是一个定义在 $RR^2$ 上的可测函数，则
  $ int_(RR^2) f = int_RR int_RR f(x,y) "d"x"d"y $
]
