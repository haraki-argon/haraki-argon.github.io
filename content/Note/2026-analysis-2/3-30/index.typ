#import "../index.typ": template, tufted
#show: template.with(title: "Lebsuege 测度（1）")
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

= 椭圆型偏微分方程的 Galerkin 方法

Recall.
于是(other C)
$ ||u_m||_(H^1) <= C $<2>
这就证明了 $u_m$ 的范数是有界的.
由 (2)，我们取子列 ${u_m}$(notation 注意)
使得 $u_m$ 在 $H_0^1(Omega)$ 中弱收敛于 $u$.

#definition(title: "弱解, weak solution")[
  $ int_Omega nabla u dot nabla phi + g(u) phi = int_Omega f phi, forall phi in H_0^1(Omega) $
]

由 Sobolev 紧嵌入定理，$H_0^1$ 中的任意有界序列都存在在 $L^2$ 中强收敛的子序列. 因此存在子列 ${u_m}$(notation 注意) 在 $L^2(Omega)$ 中强收敛于 $u$，也即 ${u_m}->u$ a.e.

=== *Step 3.* 取极限

$forall phi in H_0^1(Omega),$
$ int_Omega nabla phi dot nabla u + g(u) phi = int_Omega f phi $
对 test function $phi$，取 $phi_m in V_m$ 满足 ${phi_m}->phi$ 在 $H_0^1(Omega)$ 中. 对 $phi_m$ 用 Galerkin 方程
$ int_Omega nabla phi_m dot nabla u_m + int_Omega g(u_m) phi_m = int_Omega f phi_m $

*Step 3.1. 中间项 $int_Omega g(u_m) phi_m$ 的极限*

Goal: $display(int_Omega g(u) phi_m -> int_Omega g(u) phi (m->oo))$

我们已知 $u_m->u$ a.e. 以及 $g(u_m)->g(u)$ a.e.

固定 $phi in H_0^1(Omega)$，定义 $h_m=g(u_m) phi$，则 $|h_m| <= C |phi|$. 于是 $h_m(x)->g(u)phi$ a.e. 注意 $phi in H_0^1(Omega) subset L^2(Omega)$，从而 $|phi|in L^1(Omega)$，$c|phi|$ 绝对可积. 由控制收敛定理，
$ int_Omega h_m -> int_Omega g(u) phi (m->oo) $
于是
$ int_Omega g(u_m) phi_m - int_Omega g(u) phi & = int_Omega (g(u_m)-g(u))phi + int_Omega g(u_m)( phi_m-phi ) $
其中
$ int_Omega g(u_m)( phi_m-phi )<= C ||phi_m-phi||_(L^1)->0 $
第二项由于 $g(u_m)->g(u)$ a.e，
$ |phi (g(u_m)-g(u)) |<=2 C|phi| $
因此
$ int_Omega g(u_m)phi_m-> int_Omega g(u)phi"   " (m->oo) $

*Step 3.2. 等号右侧*

由于 $f in L^2(Omega)$， $phi_m->phi$ 在 $L^2(Omega)$ 中，因此
$ int_Omega f phi_m -> int_Omega f phi"   " (m->oo) $

* Step 3.3. 第一项*

由于 $u_m$ 弱收敛到 $u$（弱收敛的定义：对任意的有界线性泛函 $L$，$L(u_m)->L(u)$）因此
$ int_Omega nabla u_m dot nabla phi -> int_Omega nabla u dot nabla phi "   "(m->oo) $

由于 $||nabla u_m||_(L^2)<=C$，且 $phi_m->phi$ 在 $H_0^1(Omega)$ 中，因此
$ lr(|int_Omega nabla u_m nabla(phi-phi_m)|)<=||nabla u_m||_(L^2) ||nabla (phi-phi_m)||_(L^2) ->0 $

然后利用加项减项得到

$ int_Omega nabla phi_m nabla u_m-> int_Omega nabla phi nabla u "   "(m->oo) $

综上三步，取 $m->oo$ 得到
$ int_Omega nabla phi dot nabla u + int g(u)phi = int_Omega f phi $

即 $u$ 是弱解.

= Fubini 定理

#theorem[
  $f:RR^2->RR$ 绝对可积. 则存在两个绝对可积函数 $F,G:RR->RR$ 使得 $forall (a.e.) x in RR, y|->f(x,y)$  绝对可积，且
  $ F(x)=int_RR f(x,y) "d"y. $ 同样对 $y$ 有 $forall (a.e.) y in RR, x|->f(x,y)$  绝对可积，且
  $ G(y)=int_RR f(x,y) "d"x. $
  最后还有
  $ int_RR F(x) "d"x=int_(RR^2) f =int_RR G(y) "d"y $

  #remark[
    可以理解为$ int_RR (int_RR f(x,y) "d"y) "d"x = int_(RR^2) f = int_RR (int_RR f(x,y) "d"x) "d"y $
    然而 Fubini 定理并不要求对单变元的积分是绝对可积的.
  ]
]
#proof[
  先证明 $f$ 是 紧支集 $E subset.eq[-N,N]times[-N,N]$ 上的特征函数的情况，即
  $ int_[-N,N](int_[-N,N] chi_E (x,y) "d"y)"d"x=m(E) $

  #definition(title: "Lebsuege 上下积分")[
    $Omega subset.eq RR^n$ 是可测集，$f:Omega->RR$，定义
    $ overline(int)_Omega f := int{ int_Omega g ; g>=f, g:Omega->RR "absolutely integrable"} $
    $ underline(int)_Omega f := int{ int_Omega g ; g<=f, g:Omega->RR "absolutely integrable"} $
  ]

  #lemma[
    $Omega subset.eq RR^n$ 是可测集，$f:Omega->RR$，假设
    $ overline(int)_Omega f = underline(int)_Omega f = A $
    那么 $f$ 绝对可积且
    $ int_Omega f = A $
  ]

  要证
  $ int_[-N,N](int_[-N,N] chi_E "d"y)"d"x=m(E) $
  我们先证明
  $ overline(int)_[-N,N](overline(int)_[-N,N] chi_E "d"y)"d"x<=m(E) $<2>
  一旦 (2) 成立，对区域 $E<-[-N,N] times [-N,N] \\ E$ 使用
  $ overline(int)_[-N,N](overline(int)_[-N,N] (1-chi_E) "d"y)"d"x<=4N^2-m(E) $
  化简得
  $ underline(int) underline(E) chi_E "d"y "d"x>=m(E) $
  进而
  $ underline(int) overline(E) chi_E "d"y "d"x>=m(E) $
  由引理
  $ overline(int)_[-N,N] chi_E "d"y $
  绝对可积且
  $ int_[-N,N] overline(int)_[-N,N] chi_E "d"y "d"x=m(E). $
  同理
  $ int_[-N,N] underline(int)_[-N,N] chi_E "d"y "d"x=m(E) $
  因而
  $ int_[-N,N] (overline(int)_[-N,N] chi_E "d"y-underline(int)_[-N,N] chi_E "d"y) "d"x=0 $
  于是
  $ overline(int)_[-N,N] chi_E "d"y=underline(int)_[-N,N] chi_E "d"y "   "a.e. $
  故 $chi_E(x,y)$ 是 $y$ 的绝对可积函数，对于 a.e. $x$，且
  $ int_[-N,N] chi_E (x,y) "d"y=:F(x) $
  使得
  $ int_[-N,N] F(x) "d"x=m(E). $

  于是只要证明 (2).
  这是一个 box game. 我不想写了
]

#definition(title: "测度空间")[
  $(X,F,mu)$，其中 $X$ 是集合， $F$ 是 $X$ 上的 $sigma$-代数，$mu:F->[0,+oo]$ 是测度.

  $sigma$-代数是指，$P(X)$ 的子集满足
  - $X in F$
  - $A in F => X\\A in F$
  - $A_1,A_2,...A_not in F => union.big_(n=1)^oo A_n in F$

]

#definition(title: "可测空间")[
  $(Y,G)$ 是一个可测空间，其中 $Y$ 是集合，$G$ 是 $Y$ 上的 $sigma$-代数.
]

#definition(title: "可测映射")[
  $phi:(X,F)->(Y,G)$ 满足 $forall A in G, phi^(-1)(A) in F$.
]

#definition(title: "前推测度, pushforward measure")[
  $phi:(X,F)->(Y,G)$ 是可测映射，$mu$ 是 $F$ 上的测度，则 $phi_* mu(A):=mu(phi^(-1)(A))$ 定义了 $G$ 上的测度 $phi_* mu$，称为 $mu$ 的前推测度.
]

#property[
  + $phi_* mu (emptyset)=mu(phi^(-1)(emptyset))=mu(emptyset)=0$.
  + (可数可加性) $A_1,A_2,...A_not in G$ 互不相交，则
  $ phi_* mu (union.big_(n=1)^oo A_n) = sum_(n=1)^oo phi_* mu (A_n) $
]

#theorem[
  $(X,F,mu)$ 是测度空间，$(Y,G)$ 是可测空间，$phi:(X,F)->(Y,G)$ 是可测映射，一个 $(Y,G)$ 上的可测函数是关于测度 $phi_* mu$ 可积的，当且仅当 $f compose phi$ 是 $(X,F)$ 上的可测函数且关于测度 $mu$ 可积.
  具体地，
  $ int_Y f "d"(phi_* mu) = int_X (f compose phi) "d"mu $
]

#theorem(title: $star$)[
  $Omega_1,Omega_2 subset.eq RR^n$, $phi:Omega_1->Omega_2$ 是 $C^1$ 微分同胚，则对于 $Omega_2$ 上的絶対可测函数 $f$，有
  $ int_Omega_2 f "d"mu = int_Omega_1 (f compose phi) |det J phi| "d"mu $
]

= かことみらい、まとめとよてい、ちみからざったに
