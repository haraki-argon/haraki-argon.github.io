//#import "../index.typ": template, tufted
//#show: template.with(title: "热方程")
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

== Schwarz Alternating Method

考虑两个区域 $Omega_1, Omega_2$. $partial Omega_i$ 在 $Omega_1 inter Omega_2$ 中的部分记作 $Gamma_i$，不在交集中的部分记作 $Sigma_i$.

在上面求解 Poisson 方程
$ cases(laplace u=0 u|_(partial Omega)=phi) $

首先在 $Omega_1$ 上求解
$ cases(laplace u_1^((n))=0 "on" Omega_1, u_1^((n))= phi "in" Sigma_1, u_1^((n))=u_2^((n-1)) "in" Gamma_1) $

然后在 $Omega_2$ 上求解
$ cases(laplace u_2^((n))=0 "on" Omega_2, u_2^((n))= phi "in" Sigma_2, u_2^((n))=u_1^((n)) "in" Gamma_2) $

#lemma(title: "Damping Lemma")[
  令 $D$ 是一个圆盘， $Sigma subset.eq partial D$ 是一段具有正长度的圆弧. 令 $K subset.eq D$ 是一个紧集.

  则存在 $0<q<1$ 使得若 $laplace h =0 "on" D, h=0 "in" Sigma$，那么
  $ max_k |h| <=q max_(partial D) |h| $
]

#theorem(title: "Schwarz Alternating Method 的收敛性")[
  在 $overline(Sigma_1)$ 上 $u_1^((n))-> u^*$ 一致收敛，在 $overline(Sigma_2)$ 上 $u_2^((n))-> u^*$ 一致收敛，其中 $u^*$ 是 Poisson 方程的精确解.
]

#proof[
  定义 $e_1^((n))=u_1^((n))-u^*$ 和 $e_2^((n))=u_2^((n))-u^*$，则 $ cases(laplace e_i^((n))|_(Omega_i)=0, e_i|_(Sigma_i)=0, e_1^((n))=e_2^((n-1))" on" Gamma_1, e_2^((n))=e_1^((n)) "on" Gamma_2) $.

  令 $A_n=max_(Gamma_1) abs(e_2^((n))), B_n=max_(Gamma_2) abs(e_1^((n)))$.

  $e_1^((n))$ 在 $Omega_1$ 上调和，在 $Sigma_1$ 上消失，且在 $Gamma_1$ 上有非平凡的边界值 $e_2^((n-1))$. 因此
  $ max_(partial Omega_1) abs(e_1^((n)))=max_(Gamma_1) abs(e_2^((n-1)))=A_(n-1) $
  由 Damping Lemma 可知
  $ B_n=max_(Gamma_2) abs(e_1^((n)))<=q_1 A_(n-1) $
  同理
  $ A_n<=q_2 B_n $
  其中 $0<q_1, q_2<1$.

  因此
  $ A_n <= q_2 B_n <= q_1 q_2 A_(n-1) <= ... <= q^n A_0 $
  其中 $q=q_1 q_2<1$.
  现在 $ max_(overline(Omega_1)) abs(e_1)^((n)) <= A_n <= q^n A_0, max_(overline(Omega_2)) abs(e_2)^((n)) <= B_n <= q_1 q^(n-1) A_0 $
  从而
  $ u_1^((n))->u^*, u_2^((n))->u^* $
  一致.
]

#proof(title: "Proof of Damping Lemma")[
  由 Poisson formula，$forall z=(x,y) in D$，令 $A=max_(partial D) |h|$，
  $ h(z)=1/(2pi) int_(partial D) P_D (z,xi) h(xi) "d"xi $
  由于 $h$ 在 $Sigma$ 上为零，所以
  $ |h(z)|<=A/(2 pi) int_(partial D) P_D (z,xi) "d"xi $
  其中 $1/(2 pi) int_(partial D) P_D "d"xi=1$，因此
  $ |h(z)|<=A(1-1/(2 pi) int_(Sigma) P_D (z,xi) "d"xi) $
  其中
  $ 1/(2 pi) int_(Sigma) P_D "d"xi>=c_0>0 $
  故
  $ |h(z)|<=A(1-c) $
  只要取 $q=1-c_0$ 即可.
]

== Poisson 求和公式

#definition(title: "周期化, periodization")[
  对任意 $f in S(R)$，定义
  $ F_1 (x) = sum_(n=-oo)^oo f(x+n) $
  那么 $ F_1 (x)=F_1 (x+1) $

  定义 $ F_2 (x) = sum_(n=-oo)^oo hat(f)(n) e^(2 pi i n x) $
  则 $ F_2 (x)=F_2 (x+1) $
]

#theorem(title: "Poisson 求和公式")[
  若 $f in S(R)$，则 $F_1 = F_2$. 特别地 $F_1(0)=F_2(0)$ 给出
  $ sum_(n=-oo)^oo f(n) = sum_(n=-oo)^oo hat(f)(n) $
]

#definition(title: "theta function")[
  $ theta(s):= sum_(n=-oo)^oo e^(-pi n^2 s),s>0 $
]
#theorem[
  $ s^(-1/2) theta(s^(-1)) = theta(s) $
]

#definition(title: "zeta function")[
  $ zeta(s) = sum_(n=1)^oo n^(-s), "Re"(s)>1 $
]

=== Heat kernel on the circle
考虑单位圆 $TT$ 上的热方程
$ cases(u_t=u_(x x) "on" T, u(x,0)=f(x)) $
其中 $f$ 是 $TT$ 上的一个函数，或者说 $RR$ 上的一个周期为 $1$ 的函数.

那么
$ u(x,t)=(f*H_t) (x), H_t (x)=sum_(n=-oo)^oo e^(-4pi^2 n^2 t) e^(2pi i n x) $
#theorem[
  $TT$ 上的 heat kernel 是 $RR$ 上 heat kernel 的周期化，即
  $ H_t=sum_(n=-oo)^oo cal(H)_t (x+n), cal(H)_t (x)=1/sqrt(4 pi t) e^(-x^2/(4 t)) $
]
#corollary[
  $H_t (x)$ 是 good kernel.
]


== Heisenberg uncertainty principle
#theorem(title: "Heisenberg 不确定性原理")[
  对 $phi in S(RR)$ 满足 $int_(-oo)^oo |phi(x)|^2 "d"x=1$，则
  $ (int_(-oo)^oo x^2 |phi(x)|^2 "d"x) (int_(-oo)^oo xi^2 |hat(phi)(xi)|^2 "d"xi) >= 1/(16 pi^2) $

  等号成立当且仅当 $phi(x)=A e^(-B x^2), B>0,|A|^2=sqrt((2 B)/pi)$
]


