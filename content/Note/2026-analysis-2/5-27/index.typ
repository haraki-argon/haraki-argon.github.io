#import "../index.typ": template, tufted
#show: template.with(title: "Sobolev Spaces in One Dimension")
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

= Sobolev Spaces in One Dimension
== 空间
$L^2$ 空间 $int_a^b |u(x)|^2 "d"x<oo$
内积
$int_a^b u(x) v(x) "d"x$

$C^oo_c (I)$ 紧支集光滑函数空间


$L_"Loc"^1 (I)$ 局部可积函数空间（内闭区间上可积）

== 导数
=== 弱导数
$u in L_"Loc"^1 (I)$ 的弱导数 $v in L_"Loc"^1 (I)$ 满足
$ int_a^b u(x) phi'(x) "d"x = -int_a^b v(x) phi(x) "d"x $
for all $phi in C^oo_c (I)$. 记作 $u'=v$ 或 $D u=v$.

=== 高阶弱导数
$u in L_"Loc"^1 (I)$ 的 $k$ 阶弱导数 $w in L_"Loc"^1 (I)$ 满足
$ int_a^b u(x) phi^((k))(x) "d"x = (-1)^k int_a^b w(x) phi(x) "d"x $
for all $phi in C^oo_c (I)$. 记作 $D^k u=w$.

#let inr(aa, bb) = $chevron.l aa,bb chevron.r$
== Sobolev 空间
$ H^1 (I)={u in L^2 (I): u' in L^2 (I)} $
上配备内积
$ inr(u, v)_(H^1)= inr(u, v)_(L^2) + inr(u', v')_(L^2) $
范数
$ norm(u)_(H^1)^2= norm(u)_(L^2)^2 + norm(u')_(L^2)^2 $
其是完备的内积空间（Hilbert 空间）.

=== 高阶 Sobolev 空间
$ H^m (I)={u in L^2 (I): D^k u in L^2 (I), 0 <= k <= m} $
上配备内积
$ inr(u, v)_(H^m)= sum_(k=0)^m inr(D^k u, D^k v)_(L^2) $
范数
$ norm(u)_(H^m)^2= sum_(k=0)^m norm(D^k u)_(L^2)^2 $
其是完备的内积空间（Hilbert 空间）.

特别地 $H^0 (I)=L^2 (I)$.

== 回忆：连续可微函数空间
$ C_c^oo (overline(I)) subset.eq C^oo (overline(I)) subset.eq C^1 (overline(I)) subset.eq C(overline(I)) $

== 嵌入、连续嵌入
$X,Y$ 为赋范线性空间，$X subset.eq Y$，$i:X->Y$ 为包含映射是连续的. 等价地
$ exists C>0, norm(u)_Y <= C norm(u)_X, forall u in X $
则称 $X$ 嵌入于 $Y$，记作 $X arrow.r.hook Y$.

#theorem(title: "Sobolev 一维嵌入定理")[
  $H^1 (I) arrow.r.hook C(overline(I))$. 换言之
  $ ||u||_(C^0(overline(I))) <= C_I||u||_(H^1(I)) $
]

== Poincaré 不等式
令 $H_0^1 (I)$ 是 $C^oo_c (I)$ 在 $H^1 (I)$ 中的闭包.
则存在 $C>0$ 使得 $forall u in H_0^1 (I)$，有
$ ||u||_(L^2(I)) <= C ||u'||_(L^2(I)) $

== Model Problem
考虑 $I=(a,b)$ 上的椭圆形带边界值问题
$ -u''(x)+a(x)u(x)=f(x), u(a)=u(b)=0 $
其中 $a(x)>=0 a.e.$，$f in L^2(I)$. 我们求一个*弱解*.

=== 弱解

对方程乘以 test function $v in C^oo_c (I)$ 并且积分
$ int_a^b u'v' "d"x+int_a^b a(x)u(x)v(x) "d"x = int_a^b f(x)v(x) "d"x $
定义双线性形式
$ B(u,v)= int u'v'+int a u v $
弱解定义为 $u in H_0^1 (I)$ 满足
$ B(u,v)= inr(f, v)_(L^2(I)), forall v in H_0^1 (I) $
