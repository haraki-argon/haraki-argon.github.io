#import "../index.typ": template, tufted
#show: template.with(title: "Fourier 分析")
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

= Fourier 分析

== Fourier 级数
$RR$ 上的 $2 pi$-周期的函数，其可以被考虑为
$ TT=R\/(2pi) $
圆环上的函数.
对两个函数 $f,g$，定义它们的内积为
$ chevron.l f,g chevron.r_TT =1/(2pi)int_(-pi)^(pi) f(theta) overline(g(theta)) "d"theta $
实值函数时退化为
$ chevron.l f,g chevron.r_TT =1/(2pi)int_(-pi)^(pi) f(theta) g(theta) "d"theta $
在 $TT$ 上的一组完备实正交基为
$ cal(T)={1, cos(theta), sin(theta), cos(2theta), sin(2theta), ...} $
我们关心的对象：$TT$ 上函数，可积且绝对可积，记作 $cal(F)(TT)$.
定义 Fourier 系数
$
  a_0 & =1/pi int_(-pi)^(pi) f(theta) "d"theta \
  a_n & =1/pi int_(-pi)^(pi) f(theta) cos(n theta) "d"theta \
  b_n & =1/pi int_(-pi)^(pi) f(theta) sin(n theta) "d"theta
$
则 Fourier 级数为（$~$ 是形式的）
$ f(theta) ~ a_0/2 + sum_(n=1)^oo (a_n cos(n theta) + b_n sin(n theta)) $

#lemma(title: "Riemann-Lebesgue 引理")[
  $f in cal(F)(TT)$，则 $a_n, b_n -> 0$ $(n -> oo)$.
]
#proof(title: "Sketch")[使用分片常数逼近.]

一组复的完备正交基为
$ cal(E)={e^("i"n theta)}_(n in ZZ) $
定义复 Fourier 系数
$ hat(f)(n)=1/(2pi)int_(-pi)^(pi) f(theta) e^(-"i"n theta) "d"theta $
则 Fourier 级数为（$~$ 是形式的）
$ f(theta) ~ sum_(n=-oo)^(oo) hat(f)(n) e^("i"n theta) $

利用 Euler 公式 $e^("i"theta)=cos(theta)+"i"sin(theta)$，可以将实 Fourier 系数与复 Fourier 系数联系起来.

共轭对称性：如果 $f$ 是实值的，那么
$ hat(f)(-n) = overline(hat(f)(n)) $

接下来我们通常假设
- $f$ 是 $2pi$-周期的；
- 其在一个周期上是 Riemann 可积的，且绝对可积

速查
$ norm(cos n x)^2=norm(sin n x)^2=pi, norm(e^("i"n pi))=2pi $

在 $[a,b]$ 上的 $f$ 同样可以展开：记 $L=b-a$，则
$ hat(f)(n)=1/L int_a^b f(x) e^(-2 pi "i"n x\/L) "d"x $
其 Fourier 级数为
$ f(x) ~ sum_(n=-oo)^(oo) hat(f)(n) e^(2 pi"i"n x\/L) $
=== 三角级数
$ sum_(n=-oo)^(+oo) c_n e^("i"n theta), c_n in CC $
=== 三角多项式
$ P(theta)=sum_(|n|<=N) c_n e^("i"n theta) $
记 Fourier 级数的部分和为
$ S_N (f)(theta)=sum_(n=-N)^(N) hat(f)(n) e^("i"n theta) $
那么
$ S_N (f)(theta) -> f(theta) (N->+oo) ? $
== Fourier 级数的收敛性
代入定义，我们看到
$
  S_N (f)(x) & =sum_(n=-N)^N (1/(2pi) int_(-pi)^(pi) f(y) e^(-"i"n y) "d"y)e^("i"n x) \
             & =1/(2pi) int_(-pi)^(pi) f(y) (sum_(n=-N)^(N) e^("i"n(x-y))) "d"y \
$

这驱动我们定义 *Dirichlet 核*
$ D_N (theta)=sum_(n=-N)^(N) e^("i"n theta),N>=0 $
具体地
$ D_N (theta) = sin((N+1/2)theta)/sin(theta/2), D_N (0) = 2N+1 $
部分和满足
$ S_N (f) = f * D_N $
但并不收敛（？）.

加权后我们得到 *Poisson 核*
$ P_r (theta)=sum_(n=-oo)^(oo) r^(|n|) e^("i"n theta), 0<=r<1 $
对应高频部分的 smooth damping.
其绝对收敛且一致收敛. 其封闭形式
$ P_r (theta) = (1-r^2)/(1-2r cos theta + r^2) $
== 唯一性定理
#theorem(title: "唯一性定理")[
  如果 $hat(f)(n) = 0$ 对所有 $n$ 成立，且 $f$ 在 $theta_0$ 处连续，则 $f(theta_0) = 0$.
]

#proof[
  先假设设 $f in RR$, 不妨设 $theta_0=0, f(0)>0$.

  由于 $f$ 在 $0$ 处连续，存在 $delta>0$ 使得 $ f(theta)>f(0)/2>0, forall theta in (-delta, delta). $

  我们希望构造一个三角多项式 $p(theta)$ 使得在 $0$ 处的值较大$(>1)$，在 $(-delta, delta)$ 以外的地方较小$(|dot|<1)$. 这样 $p^k$ 的行为可以提取出 $f$ 在 $0$ 附近的信息.

  取 $eps>0$ 为一个小的正数，构造 $ p(theta)=eps+cos theta $
  经过计算，$0<eps<1-cos delta$ 使得在外部 $|dot |>delta$ 的地方 $|p(theta)|<1$，在 $0$ 处 $p(0)=eps+1>1$，可以取 $0<eta<delta$ 使得 $p(theta)>1+eps/2, forall theta in (-eta, eta)$.

  定义 $p_k (theta)=p^k (theta)$ 依然是三角多项式，由题设和 $f$ 的内积为 $0$，因为
  $ hat(f)(n)=int_(-pi)^(pi) f(theta) e^("i"n theta) "d"theta = 0 ==> int_(-pi)^(pi) f(theta) p_k (theta) "d"theta = 0 $

  经过放缩
  $ 0>=eta f(0) (1+eps/2)^k - rho^k int_(-pi)^(pi) |f(theta)| "d"theta->+oo $
  矛盾.
]
#corollary[
  如果 $f,g$ 在 $TT$ 上连续，且 $hat(f)(n)=hat(g)(n)$ 对所有 $n$ 成立，则 $f=g$.
]
这表明在连续的情况下 Fourier 级数的系数保留了函数的全部信息.

#theorem(title: "绝对收敛定理")[
  如果 $f in cal(F)(TT)$，且 $ sum_(n=-oo)^(oo) |hat(f)(n)|<+oo, $则 Fourier 级数绝对收敛且一致收敛于 $f$.
]

=== 大 O 记号
$A(n) = O(B(n))$ 表示 $A(n)<=C B(n), forall n>=N$ for some constants $C>0$ and $N>=0$.

=== $C^k (TT)$
定义略. 在 $C^2 (TT)$ 中 $hat(f)(n) = O(1/n^2)$，

=== 导数的 Fourier 级数
$ hat(f')(n)="i"n hat(f)(n) $

观察： $f$ 更光滑，$hat(f)(n)$ 越快趋于 $0$.

更有效的一个条件 Holder 正则性：
$ sup_(theta in TT) (|f(theta + h) - f(theta)|)/(|h|^alpha) < +oo $

=== 卷积, convolution
$ (f*g)(x) = int_(-pi)^(pi) f(x - y) g(y) "d"y $
交换、线性、分配、结合.

Recall: $S_N (f) = f * D_N.$ 证明略.

任意函数卷积上连续函数是连续的.

$ hat(f*g)(n)=hat(f)(n)hat(g)(n) $
