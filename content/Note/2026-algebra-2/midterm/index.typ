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
  lang: "en",
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
#set enum(numbering: "(1)(a)")

= 期中复习

== 域论

$|"Hom"_F (E,overline(F))|<=[E:F]$，取等当且仅当 $E\/F$ 是可分扩张.

$E$ 是 $F$ 的分裂域，则 $|"Aut"(E\/F)|=[E:F]$ 当且仅当 $E\/F$ 是可分扩张.

重根判别法：$(f,f')=1$ 等价于 $f$ 没有重根.

特征 $0$ 的域是完美的. 特征 $p$ 域上多项式不可分当且仅当 $f'=0$.

可分次数 $[E:F]_s=[F_"sep":F]$，不可分次数 $[E:F]_i=[E:F_"sep"]$. 不可分次数形如 $p^k$.

$|"Hom"_F (E,overline(F))|=[E:F]_s$. 可分次数和不可分次数在域扩张上保持乘性.

$
  N_(E\/F)(a)=product_(sigma in "Hom"_F (E,overline(F))) sigma(a)^([E:F]_i), "Tr"_(E\/F)(a)=([E:F]_i) sum_(sigma in "Hom"_F (E,overline(F))) sigma(a)
$
其中 $x|->a x$ 的特征多项式是
$ product_(sigma in "Hom"_F (E,overline(F))) (x-sigma(a))^([E:F]_i) $
极小多项式是
$ product_(sigma in "Hom"_F (F(a),overline(F))) (x-sigma(a))^([F(a):F]_i) $
之间差一个次幂 $[E:F(a)]$.

$E\/F$ 可分当且仅当 $"Tr"_(E\/F)$ 不为 0.

正规扩张等价于 $forall sigma in "Hom"_F (E,overline(F))$ 有 $sigma(E) subset(=) E$.

Galois 对应: $K->"Gal"(E\/K), E^H<-H$. $E^("Gal"(E\/K))=K, "Gal"(E\/E^H)=H$.

$E^H$ 是 $F$ 的正规扩张当且仅当 $H$ 是 $"Gal"(E\/F)$ 的正规子群. 此时有商关系 $"Gal"(E^H \/F) tilde.equiv "Gal"(E\/F)\/H$.

有限域阶数 $p^n$，且每个都存在，且在同构下唯一. 有限域 $p^m$ 到 $p^n$ 的扩张当且仅当 $m|n$，其 Galois 群是循环群，生成元为 $x|->x^q^m$.

分圆多项式是不可约整系数多项式. $n$ 次分圆域的 Galois 群是 $n$ 阶循环群的自同构群，阶数 $phi(n)$.

Kummer 理论：假定 $F$ 有 $n$ 个 $n$ 次单位根；根扩张是循环扩张，且次数等于根最低落入 $F$ 的幂次. 反之，如果 galois 群是 $n$ 阶循环群，那么 $E=F(d)$，其中 $d^n in F$. 总而言之，$F^times\/ (F^times)^n$的 $n$ 阶循环群和 $E\/F$ 的循环扩张是一一对应的.

方程可解当且仅当其 Galois 群是可解群. 一般方程的 Galois 群是 $S_n$，当 $n>=5$ 时不可解.

== 交换代数

小根是素理想之交，也是全部幂零元的集合.

大根是极大理想之交. 也是 ${a in R | 1- a r "可逆", forall r in R}$

理想的根是包含理想的全部素理想之交.

