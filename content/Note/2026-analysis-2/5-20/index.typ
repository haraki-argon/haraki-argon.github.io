#import "../index.typ": template, tufted
#show: template.with(title: "热方程")
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

= 热方程 Cauchy 问题的极大值原理
#theorem[
  若 $u(x,t)$ 是上半平面上 Cauchy 问题的解，在其内部连续，对于区域
  #import "@preview/cetz:0.5.0"
  #block(above: 1em)
  #align(center, cetz.canvas({
    import cetz.draw: *
    line((-1, 0), (3, 0))
    line((0, 3), (0, -1))
    line((0.5, 0), (0.5, 2), stroke: red)
    line((2.5, 0), (2.5, 2), stroke: red)
    line((0.5, 0), (2.5, 0), stroke: red)
    content((1.5, 1), [$R$])
    content((3, 1.6), [$partial R$])
    line((0, 2), (3, 2))
    content((-0.5, 2), [$c$])
    content((3.2, 0.1), [$x$])
    content((0, 3.3), [$t$])
  }))
  有
  $
    min_((x,t) in partial R) u(x,t) = min_((x,t) in R) u(x,t)\
    max_((x,t) in partial R) u(x,t) = max_((x,t) in R) u(x,t)\
  $
]
令 $T>0, Q_T=(0,T) times RR, overline(Q_T)=[0,T] times RR$.
#theorem(title: "极大值原理")[
  令 $u in C(overline(Q_T)) inter C^(1,2) (Q_T)$，并假设
  $ abs(u(x,t))<=M e^(a x^2) ,forall (x,t) in overline(Q_T) $
  如果 $u_t-u_( x x)<=0 , forall (x,t) in Q_T$，那么
  $ sup_(x in RR)u(x,t)<=sup_(x in RR) u (x,0) ,0<=t<=T $
  如果 $u_t-u_( x x)>=0 , forall (x,t) in Q_T$，那么
  $ inf_(x in RR)u(x,t)>=inf_(x in RR) u(x,0) ,0<=t<=T $
]
#theorem(title: "比较原理")[
  令 $u, v in C(overline(Q_T)) inter C^(1,2) (Q_T)$，并假设
  $ abs(u(x,t)),abs(v(x,t))<=M e^(a x^2) ,forall (x,t) in overline(Q_T) $
  如果 $u_t-u_(x x)<=v_t-v_(x x), forall (x,t) in Q_T$，且 $u(x,0)<=v(x,0)$，那么
  $ u(x,t)<=v(x,t) ,(x,t)in overline(Q_T) $
]

$u_t=u_(x x)$ 在 $t->0$ 时行为趋近于 Poisson 方程
$0=u_(x x)$:

== Poisson 方程
在 $RR^2_+={(x,y):y>0}$ 上考虑方程
$ cases(laplace u = 0, u(x,0)=f) $
#definition(title: "Poisson kernel")[
  $ P_y:=(y)/(x^2+y^2) dot 1/pi (x in R,y>0) $
]
对 $0=u_(x x)+u_(y y)$ 做 Fourier 变换，得到
$ cases(0=-4pi^2 xi^2 hat(u)(xi,y)+(partial^2)/(partial y^2) hat(u)(xi,y), hat(u)(xi,0)=hat(f)(xi)) $
解得
$ hat(u)(xi,y)=A(xi) e^(-2pi|xi|y) + B(xi) e^(2pi|xi|y) $
However，我们希望其在无穷远处趋于 0，因此做一个 gauge(?) 使得 $B(xi)=0$.
于是
$ hat(u)(xi,y)=A(xi) e^(-2pi|xi|y) $
为了符合边界条件，只需要
$ hat(u)(xi,y)=hat(f)(xi) e^(-2pi|xi|y) $<aaa>
再做一次 Fourier 反变换，得到
$ u(x,y)=(f*P_y)(x) $
#lemma[
  $
    int_(-oo)^(+oo) e^(-2 pi|xi|y) e^(i 2 pi x xi) "d" xi= P_y (x)\
    int_(-oo)^(+oo) P_y (x) e^(-2 pi i x xi) "d"x= e^(-2 pi|xi|y)
  $
  (In a word, Poisson kernel 就是 @aaa 处反变换之后的封闭形式，对吗？)
]
#lemma[
  Poisson kernel 是 good kernel.
]

#theorem[
  对 $f in S(RR)$，令 $u(x,y)=(f * P_y) (x)$，则：
  + $laplace u =0$.

  + 当 $y->0$ 时，$u(x,y)->f(x)$ 一致收敛.

  + 当 $y->0$ 时，$u(x,y)->f(x)$ 在 $L^2$ 范数下收敛.

  + 若 $u(x,0)=f(x)$，则 $u$ 在 $overline(RR^2_+)$ 上连续，且 $u(x,y)->0$ 当 $|x|+y->+oo$.
]

#lemma(title: "平均值性质")[
  假设 $Omega$ 是 $RR^n$ 中的开集，且在 $Omega$ 上 $laplace u = 0$，那么
  $ u(x,y)=1/(2 pi) int_0^(2 pi) u(x+r cos theta, y+r sin theta) "d"theta $
]

下面介绍一种方法，称为 Schwarz Alternating 方法.

在两个相交区域 $Sigma_1$ 和 $Sigma_2$ 上，记在对方内部的一段边界为 $Gamma_i$，在外部的边界为 $Sigma_i$.

选择一个在 $Sigma_2$ 上的初始 $u_2^((0))$，定义 ..


#lemma(title: "更强的极大值原理")[
  $D$ 是一个圆盘，$Sigma subset.eq partial D$ 是盘边界善过一段正长度的区域，$K subset.eq D$ 为一紧集. 则存在 $0<q<1$ 使得若 $h in C^1(overline(D)) inter C^2(D)$，且
  $ cases(laplace h =0 "in" D, h=0 "in" Sigma) $
  则
  $ max_k |h| <=q max_(|partial D|) |h| $
]
#theorem(title: "Schwarz Alternating 方法的收敛性")[
  假设 $u^*$ 是精确解，则
  $ u_1^((n))->u^* $ 在 $Sigma_1$ 上一致收敛，$ u_2^((n))->u^* $ 在 $Sigma_2$ 上一致收敛.
]
#proof[
  令 $e_1^((n))=u_1^((n))-u^*$，$e_2^((n))=u_2^((n))-u^*$ 为误差. 则
  $
    cases(
      laplace e_i^((n))=0 "in" Sigma_i, e_i^((n))=0 "on" Sigma_i,
      e_1^((n))=e_2^((n-1)) "on" Gamma_1,
      e_2^((n))=e_1^((n)) "on" Gamma_2
    )
  $
]

调和提升
