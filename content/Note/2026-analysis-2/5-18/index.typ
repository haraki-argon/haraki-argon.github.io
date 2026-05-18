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

= Heat Equation 热方程

Sketch:

+ Heat Kernel:
  $
    K_delta (x)=1/sqrt(delta) e^(-pi 1/delta x^2),delta=4pi t\
    H_t:=K_delta
  $

+ Heat Equation:
  $ cases(u_t=u_(x x), u|_(t_0)=f(x))==> u=f*E_t $

+ $norm(u)_oo<=norm(f)_oo,norm(u)_(L^2)<=norm(f)_(L^2)$

+ $u_t=laplace u - f -> laplace u = f space (t->+oo)$.

  $norm(u)_oo<=c norm(f)_oo$

== Heat Kernel 热核

#definition(title: "Gaussian kernel")[
  $ K_delta (x)=1/sqrt(delta) e^(-1/delta pi x^2),delta>0 $
]

#theorem[
  $f(x)=e^(-pi x^2)$. 则 $hat(f)(xi)=f(xi)$.
  #remark[
    Fourier 变换的一些性质：
    + $-2 pi i x f(x) -> hat(f)'(xi)$

    + $f'(x)->2 pi i xi hat(f)(xi)$

    + $f(delta x)->delta^(-1) hat(f)(delta^(-1) xi)$
  ]
]
#proof[
  定义 $ F(xi)=hat(f)(xi)=int_(-oo)^oo e^(-pi x^2) e^(2 pi i x xi) "d"x $
  由 Gauss 积分可知 $F(0)=1$. 对上式求导得
  $
    F'(xi) & =int_(-oo)^oo e^(-pi x^2) (2 pi i x) e^(2 pi i x xi) "d"x \
           & = i int_(-oo)^oo f'(x) e^(-2 pi i x xi) "d"x \
           & = 2 pi i^2 xi hat(f)(xi) \
           & = -2 pi xi F(xi)
  $
  问题变为求解常微分方程
  $ cases(F'(xi)+2pi xi F(xi)=0, F(0)=1) $
  解得
  $ F(xi)=e^(-pi xi^2) $
]

#corollary[
  若 $delta>0$，则 $hat(K_delta)(xi)=e^(-pi delta xi^2),$
  且
  + $int_(-oo)^oo K_delta (x) "d"x=1;$

  + $int_(oo)^oo |K_delta (x)| "d"x=1;$

  + $forall eta>0, int_(|x|>eta) |K_delta (x)| "d"x->0 space(delta->0)$.
]
#proof[
  只需证明第三点.
  $ int_(|x|>eta) |K_delta (x)| "d"x & =int_(|y|>eta delta^(-1/2)) e^(-pi y^2) "d"y ->0 space (delta->0) $
  因为其是速降的.
]

#theorem[
  ${K_delta}_(delta>0)$ 是 good kernels.
]
#corollary[
  $f in S(RR)$，则
  $ (f * K_delta)(x)->f(x) $
  在 $delta->0$ 过程中一致收敛.
]
#proposition[
  $f,g in S(RR)$，则
  $ int_(-oo)^oo f(x) hat(g)(x) "d"x= int_(-oo)^oo hat(f)(y) g(y) "d"y $
]
#proof[
  对一般的 $F(x,y)$，记
  $ F_1(x)=int_(-oo)^oo F(x,y) "d"y, F_2(y)=int_(-oo)^oo F(x,y) "d"x $
  那么
  $ int_(-oo)^oo F_1(x) "d"x= int_(-oo)^oo F_2(y) "d"y $
  这里取 $F(x,y)=f(x)g(y)e^(-2 pi i x y)$，那么
  $ F_1(x)=f(x) hat(g)(y),F_2(y)=hat(f)(y) g(y) $
  从而得证.
]

#theorem(title: "Fourier inversion")[
  若 $f in S(RR)$，则
  $ f(x)=int_(-oo)^oo hat(f)(xi) e^(2 pi i x xi) "d"xi $
]
#proposition[
  若 $f,g in S(RR)$，则
  + $f * g in S(RR)$;
  + $f * g = g * f$;
  + $hat(f * g)=hat(f) dot hat(g)$
]
#proof[
  (3) 同上，考虑 $F(x,y)=f(y)g(x-y)e^(-2 pi i x xi)$
]

#theorem(title: "Plancherel")[
  若 $f in S(RR)$，则
  $ norm(hat(f))=norm(f) $
]
#proof[
  定义 $f^flat:=overline(f(-x))$，则
  $ hat(f^flat)(xi)=overline(hat(f)(xi)) $
  取 $h=f*f^flat$，则
  $ hat(h)(xi)=hat(f)(xi) overline(hat(f)(xi))=|hat(f)(xi)|^2 $
  $ h(0)=int_(-oo)^oo |f(x)|^2 "d"x $
  于是由
  $ int_(-oo)^oo hat(h)(xi) "d"xi = h(0) $
  得证.
]

== 热方程的 Cauchy 问题
$ cases(u_t=u_x x space (x in RR), u|_(t=0)=f(x)) $
可以想象一根无限长的圆钢丝上的初始温度分布为 $f(x)$，在没有热源的情况下，随着时间的推移，温度分布会如何演化.

虽然我们知道 $u=H_t * f$，但其不适合用于具体的计算. 我们将通过对解的先验估计来铺垫.（？）

=== Heat kernel
#definition(title: "Heat kernel")[
  $ H_t (x)=K_delta (x), delta=4 pi t $
]
计算得
$ hat(H_t)(xi)=e^(-4 pi^2 t xi^2) $

因此我们得到
$
  cases(hat(u_t)(xi)=-4 pi^2 xi^2 hat(u)(xi,t), hat(u)(xi)=hat(f)(xi))
$
故
$
  hat(u)(xi,t) & =hat(f)(xi)e^(-4 pi^2 xi^2 t) \
        u(x,t) & =int_(-oo)^(oo) hat(u)(xi,t) e^(2 pi i xi x)"d"xi \
               & =int_(-oo)^(oo) hat(f)(xi) e^(-4 pi^2 xi^2 t) e^(2 pi i xi x)"d"xi \
               & = f*H_t
$
#theorem[
  $f in S(RR)$，取
  $ u(x,t)=H_t * f, t>0 $
  则
  + $u in C^2$ 是热方程的解；
  + $u(x,t)->f(t)$ 当 $t->0$ 时一致收敛.

  + $int_-oo^oo |u(x,t)-f(x)|^2 "d"x->0$ 当 $t->0$ 时.
]
#proof[
  + .
  + 推论 1.7
  + plancherel 定理
]

#corollary[
  $u(-,t) in S(RR)$ uniformly in $t$ for any $T>0$:
  $ sup_(x in RR,0<t<T) |x|^k abs(partial^l/(partial x^l) u(x,t))<oo, "for each" k,l>0 $
]

== Energy Estimate

#theorem[
  如果满足方程
  $ cases(u_t=u_x x space (x in RR), u|_(t=0)=f(x)) $
  那么
  $ norm(u(x,t))_(L^2)<=norm(f)_(L^2) $
]
#proof[
  $
    u_t=u_(x x) & ==> int_(-oo)^(+oo) u_t u "d" x = int_(-oo)^(+oo) u_(x x) u "d" x \
                & ==>"d"/("d"t) int_(-oo)^(+oo)1/2 u^2 "d"x=lr(u_x u|)_(-oo)^(+oo)-int_(-oo)^(+oo) u_x^2 "d"x \
                & ==> "d"/("d"t) int_(-oo)^(+oo)1/2 u^2 "d"x+int_(-oo)^(+oo) u_x^2 "d"x=0 \
                & ==> "d"/("d"t) int_(-oo)^(+oo)1/2 u^2<=0 \
                & ==> norm(u(x,t))_(L^2)<=norm(f)_(L^2)
  $
]
#theorem(title: "解的唯一性")[
  假设 $u(x,t)$ 满足
  + $u$ 在上半平面连续；
  + $u$ 满足 $t>0$ 时的热方程；
  + $u$ 满足初始条件 $u(x,0)=0$；
  + $u(-,t) in S(RR)$ uniformly in $t$.

  则 $u=0$.
]

#proof[
  $||u||_(L^2)<=0==>u=0$.
]
#theorem(title: "极大值原理")[
  假设 $u(x,t)$ 是在上半平面满足热方程的解，令 $R$ 为如下的矩形区域
]
