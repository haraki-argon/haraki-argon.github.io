#import "../index.typ": template, tufted
#show: template.with(title: "Fourier 分析 - Good kernel")
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

= Good kernel

#align(center, table(
  columns: (auto, auto, auto),
  stroke: none,
  align: center,
  table.header([*Kernel*], [*Convergency*], [*Note*]),
  [Dirichlet kernel], [bad], [$S_N (f) (x)=f * D_N (x)$],
  [Fejér kernel], [good], [Cesàro means],
  [Poisson kernel], [good], [Abel means],
))

#definition(title: "Good kernel")[
  $TT$ 上的 ${K_n (x)}_(n=1)^oo$ 被称为一族 good kernels，如果满足：

  + (正则性) $display(1/(2 pi) int_(-pi)^(pi) K_n (x) "d"x = 1)$;

  + (震荡弱) $display(int_(-pi)^(pi) |K_n (x)| "d"x <= M), forall n >=1$;

  + (向中间集中) $forall delta>0, display(int_(delta<=|x|<=pi) |K_n (x)| "d"x -> 0)space (n->oo)$
]

我们希望用 $K_n->chi_0$ 的过程来实现 $f*K_n->f$ 的逼近. 有如下的定理：

#theorem[
  令 ${K_n (x)}_(n=1)^oo$ 是 $TT$ 上的 good kernels，$f$ 是 $TT$ 上的可积函数，$f$ 在 $x in TT$ 处连续，则
  $ lim_(n->oo) f * K_n (x) = f (x) $
  如果 $f$ 在 $TT$ 上连续，则 $f * K_n -> f$ 在 $TT$ 上一致收敛.
]
#proof[我想这是上学期习题和试验的内容. 略.]

== Dirichlet kernel
$ D_N (x):=sum_(n=-N)^N e^("i"n x) $
满足
$ S_N (f) (x)=f * D_N (x) $
由于(left to homework)
$ int_(-pi)^(pi) abs(D_N (x)) "d"x >= C log N space(N->oo) $
其不是 good kernel.

== Fejér kernel
=== Cesàro means

对复级数 $sum_(k=0)^oo c_k (c_k in CC)$ 定义部分和 $S_n= sum_(k=0)^n c_k$.
#definition(title: "Cesàro 平均")[
  $ sigma_N = 1/N sum_(n=0)^(N-1) S_n $
]
#definition(title: "Cesàro 可求和")[
  若 $sigma_N->sigma space (N->oo)$ 则称级数 $sum_(k=0)^oo c_k$ Cesàro 可求和，且其 Cesàro 和为 $sigma$.
]
#example[$1-1+1-1+$... 的 Cesàro 和为 $1/2$.]

应用于 Fourier 级数，我们有
$
  S_n (f)= f * D_n (x) ==> sigma_N (x) & = 1/N sum_(n=0)^(N-1) f * D_n (x) \
                                       & = f * (1/N sum_(n=0)^(N-1) D_n (x))
$
我们定义后面的一项就为 Fejér kernel.
=== Fejér kernel
#definition(title: "Fejér kernel")[
  $ F_N (x) = 1/N sum_(n=0)^(N-1) D_n (x) $
]
#lemma[
  $ F_N (x)=1/N (sin^2 (N x\/2))/(sin^2 (x\/2)) $
  且 $F_N (x)$ 是 good kernel.
]
#theorem[
  $f$ 在 $TT$ 上可积，$f$ 在 $x in TT$ 处连续，则其 Fourier 级数在点 $x$ 处在 Cesàro 意义下收敛于 $f(x)$.

  如果 $f$ 在 $TT$ 上连续，则其 Fourier 级数在 Cesàro 意义下在 $TT$ 上一致收敛于 $f$.
]
#corollary[
  如果 $f$ 在 $TT$ 上可积，且 $hat(f)(n)=0, forall n in ZZ$，则 $f=0$ 在 $f$ 的连续点处.
]
#corollary[
  $f$ 是 $TT$ 上的连续函数，则其可以被一族三角多项式在 $TT$ 上一致逼近.
]

== Poisson kernel
=== Abel means
#definition(title: "Abel 平均")[
  $ A_r = sum_(n=0)^oo c_n r^n $
]
#definition(title: "Abel 可求和")[
  若每个 $A_r (0<=r<1)$ 都存在且 $lim_(r->1^-) A_r = S$ 收敛，则称级数 $sum_(k=0)^oo c_k$ Abel 可求和，且其 Abel 和为 $S$.
]
#example[$1-2+3-4+$... 的 Abel 和为 $A(r)=1\/(1+r^2)$.]

将其应用于 Fourier 级数，我们有
$ f(theta)~sum_(n=-oo)^(oo) a_n e^("i"n theta) ==> A_r (f)=sum_(n=-oo)^(oo) a_n e^("i"n theta) r^abs(n) $

=== Poisson kernel
#definition(title: "Poisson kernel")[
  $ P_r (theta) = sum_(n=-oo)^(oo) r^abs(n) e^("i"n theta) $
]
我们可以看到 $A_r (f)=f * P_r$, 因为
$
  A_r (f) & = sum_(n=-oo)^(oo) a_n e^("i"n theta) r^abs(n) \
  & = sum_(n=-oo)^(oo) r^abs(n)(1/(2pi) int_(-pi)^pi f(phi) e^(-"i"n phi) "d"phi) e^("i"n theta) \
  & = 1/(2pi) int_(-pi)^pi f(phi)underbrace((sum_(n=-oo)^(oo) r^abs(n) e^("i"n (theta-phi))), "Poisson kernel") "d"phi \
$

#lemma[
  $0<=r<1$ 时
  $ P_r (theta)=(1-r^2)/(1-2r cos theta + r^2) $
  是 good kernel.
]
#theorem[
  $f$ 的 Fourier 级数在 $f$ 连续点处在 Abel 意义下收敛于 $f$. 若 $f$ 在 $TT$ 上连续，则其 Fourier 级数在 Abel 意义下在 $TT$ 上一致收敛于 $f$.
]

== Laplace Equation

单位圆盘 $D$ 上的 Dirichlet 问题：
$ cases(laplace u =0, u|_(partial D) = f(theta)) $

#theorem[
  $f$ 是 $partial D$ 上的可积函数，则
  $ u(r,theta)=(f*P_r)(theta) $
  具有以下性质：
  + $laplace u = 0$.
  + $lim_(r->1^-) u(r,theta) = f(theta)$. 若 $f$ 在 $TT$ 上连续，则该极限一致收敛.
  + 若 $f in C^0 (TT)$，则 $U(r,theta)$ 是该方程的唯一解.
]
#proof[
  + $display(laplace u = (partial^2 u)/(partial r^2)+ 1/r (partial u)/(partial r) + 1/r^2 (partial^2 u)/(partial theta^2))$ 直接计算验证即可.

  + $lim_(r->1^-) u(r,theta)=lim_(r->1^-) (f*P_r)(theta)=f(theta)$，因为 $P_r$ 是 good kernel.

  + 对两个解作差得到 $v$ 满足 $laplace v=0, v|_(partial D) = 0$，由极大值原理 $|v|=v=0$.
]

= $L^2$ 意义下的收敛

记号 $a_n=hat(f) (n),e_n=e^("i"n theta)$.

垂直性质：
$ f- sum_(|n|<=N) a_n e_n perp sum_(|n|<= N b_n e_n) $

勾股定理：
$
              f & = f- sum_(|n|<=N) a_n e_n + sum_(|n|<=N) a_n e_n \
  ==> norm(f)^2 & = norm(f- sum_(|n|<=N) a_n e_n)^2 + norm(sum_(|n|<=N) a_n e_n)^2 \
                & =norm(f- sum_(|n|<=N) a_n e_n)^2 + sum_(|n|<=N) |a_n|^2 \
                & = norm(f- S_N (f))^2+ sum_(|n|<=N) |a_n|^2
$

#lemma(title: "最佳逼近")[
  $f$ 在 $TT$ 上可积，其 Fourier 系数为 $a_n$，则
  $ norm(f-S_N (f)) <= norm(f-sum_(|n|<=N) c_n e_n), c_n in CC $
  等式成立当且仅当 $c_n=a_n$.
]

#theorem[
  $f$ 在 $TT$ 上可积，则 $S_N (f)->f space (N->oo)$ 在 $L^2$ 意义下 (即 $norm(f-S_N (f))->0$) .
]

#remark(title: "Bessel不等式")[
  ${e_n}$ 是任意正交函数系，$a_n=(f,e_n)$，那么
  $ sum_(|n|<=N) |a_n|^2 <= norm(f)^2 $
  取等当且仅当
  $ norm(sum_(|n|<=N) a_n e_n-f) ->0 space (N->oo) $
]
#corollary(title: "Riemann-Lebesgue引理")[
  若 $f$ 在 $TT$ 上可积，则 $hat(f) (n)->0 space (n->oo)$.
]
#lemma(title: "广义 Parseval 等式")[
  $F，G$ 是可积函数，$F ~ sum a_n e^("i"n theta), G ~ sum b_n e^("i"n theta)$，则
  $ 1/(2pi) int_0^(2 pi) F overline(G) "d"theta = sum_(n=-oo)^(oo) a_n overline(b_n) $
]
