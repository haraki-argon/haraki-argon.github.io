#import "../index.typ": template, tufted
#show: template.with(title: "Fourier 分析 - Pointwise convergence of Fourier series")
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

= Pointwise Convergence of Fourier series
#theorem[
  $f$ 是 $TT$ 上的可积函数，在 $theta_0$ 处可微，则 $S_N (f)(theta_0) -> f(theta_0)$ 当 $N -> oo$.
]
#proof[
  定义
  $
    F(t)=cases(
      display((f(theta_0 -t)-f(theta_0))/t)", "t!=0", "|t|<pi,
      -f'(theta_0)", "t=0
    )
  $
  则 $F$ 在 $0$ 附近有界，在 $[-pi,-delta] union [delta,pi]$ 上可积，因此 $F$ 在 $TT$ 上可积.

  $
    S_N (f)(theta_0) - f(theta_0) & =1/(2pi) int_(-pi)^(pi) f(theta_0-t) D_N (t) "d"t - f(theta_0) \
                                  & = 1/(2pi) int_(-pi)^(pi) (f(theta_0-t)-f(theta_0)) D_N (t) "d"t \
                                  & = 1/(2pi) int_(-pi)^(pi) F(t) t D_N (t) "d"t \
  $
  注意
  $
    t D_N (t) & = (sin((N+1/2)t))/(sin(t/2)) t \
              & =(sin(N t)cos(t/2)+cos(N t)sin(t/2))/(sin(t/2)) t \
              & = t/(sin t/2) sin(N t) cos(t/2) + t cos(N t) \
  $
  故
  $ F(t) t D_N (t) & = [F(t) t/(sin t/2)] cos(t/2) bold(sin(N t)) + [F(t) t] bold(cos(N t)) $
  由 Riemann-Lebesgue 引理，$int_(-pi)^(pi) F(t) t D_N (t) "d"t -> 0$，因此 $S_N (f)(theta_0) -> f(theta_0)$.
]
== Localization principle of Riemann
#theorem[
  $f,g$ 是两个 $TT$ 上的可积函数，在 $theta_0$ 的某个邻域 $I$ 内满足 $f=g$，则 $ S_N (f)(theta_0) - S_N (g)(theta_0) -> 0 $ 当 $N -> oo$.
]

= Fourier Transform
从离散步入连续：
$
                                       TT & ->RR \
                                  n in ZZ & -> xi in RR \
     a_n=int_0^1 f(x) e^(-2pi i n x) "d"x & ->hat(f)(xi)=int_RR f(x) e^(-2pi i xi x) "d"x \
  f(x)=sum_(n=-oo)^(oo) a_n e^(2pi i n x) & -> f(x)=int_RR hat(f)(xi) e^(2pi i xi x) "d"xi
$
#definition(title: "Moderate decrease，缓降")[
  如果 $f$ 是 $RR$ 上的连续函数且 $exists A>0$ 使得
  $ |f(x)|<=A/(1+x^2), forall x in RR $
  则称 $f$ 是一个缓降函数. 记缓降函数空间为 $M(RR)$.
]
#proposition[
  $f,g in M(RR), a,b in CC$
  - $int_(RR) a f + b g "d"x= a int_(RR) f "d"x + b int_(RR) g "d"x$

  - $int_(RR) f(x-h) "d"x= int_(RR) f "d"x$

  - $delta int_(RR) f(delta x)"d"x= int_(RR) f "d"x$

  - $int_(RR) |f(x-h)-f(x)|"d"x->0$ 当 $h->0$.
]

定理表明对于 $M(RR)$ 中的函数，Fourier 变换是良定的.

#definition(title: "rapidly decreasing，速降")[
  $ sup_(x in RR) |x|^k |f^((l))(x)| < oo, forall k,l>=0 $
]
#definition(title: "Schwartz space")[
  速降函数的集合，记为 $S(RR)$.
]
#proposition[
  - $f in S(RR)==> x f in S(RR)$;
  - $f in S(RR)==> f' in S(RR).$
  #example[
    Guassian 函数 $G(x)=e^(-pi x^2)$ 是一个速降函数.
  ]
]

#proposition[
  $f in S(RR)$ 则
  - $f(x+h)$ 的 Fourier 变换为 $hat(f)(xi) e^(2pi i xi h)$;

  - $f(x) e^(-2 pi i x h)$ 的 Fourier 变换为 $hat(f)(xi+h)$;

  - $f(delta x)$ 的 Fourier 变换为 $1/delta hat(f)(xi/delta)$;

  - $f'(x)$ 的 Fourier 变换为 $2pi i xi hat(f)(xi)$;

  - $-2 pi i x f(x)$ 的 Fourier 变换为 $hat(f)'(xi)$.
]
