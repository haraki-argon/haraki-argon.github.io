#import "../index.typ": template, tufted
#show: template.with(title: "域扩张")
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
#let proposition = proposition.with(fill: red.darken(10%))
#set-inherited-levels(1)
#let leq = $lt.eq.slant$
#let eps = $epsilon$
#let int = $integral$
#let supp = $"supp"$
#let pd(f, x) = $frac(partial #f, partial #x)$
#let dd(f, x) = $frac(d #f, d #x)$

= 代数闭域

回忆：$E\/F$ 是代数扩张指 $E\\F$ 都是 $F$ 上代数元. 有限扩张都是代数扩张. 单扩张是有限扩张等价于代数元.

#theorem(title: "代数扩张的传递性")[
  $E\/K\/F$ 均为域扩张. $E\/F$ 是代数扩张当且仅当 $E\/K$ 和 $K\/F$ 都是代数扩张.
]

#proof[
  $(==>)$ $E\/F$ 是代数扩张，即 $E\\F$ 都是 $F$ 上的代数元，从而 $K\\F$ 和 $E\\K$ 都是 $F$ 上的代数元，进而 $E\\K$ 更是 $K$ 上的代数元.

  $(<==)$ 由于 $E\/K$ 是代数扩张，$forall u in E, exists f(x)=x^n+a_(n-1)x^(n-1)+...+a_1x+a_0 in K[x], f(u)=0$，从而 $u$ 在 $tilde(F):=F(a_0,a_1,...,a_(n-1))$ 上是代数元.

  注意#footnote[可以理解一下为何每一个乘积项均 $<+oo$.] $ [F(u):F] & <=[tilde(F)(u):F] \
           & =[tilde(F)(u):tilde(F)][tilde(F):F(a_0,...,a_(n-2))]...[F(a_0):F] \
           & <+oo $
  从而 $u$ 在 $F$ 上是代数元.#footnote[我们如何理解这个结论？可以料想 $E\\F$ 的元素作为 $K$-系数的多项式之根，间接地应该是 $F$-系数的多项式之根.]
]

#proposition[
  $E\/F$ 是域扩张，则 $E$ 中 $F$ 上的全体代数元组成的 $K$ 是域.
]
#proof[
  $forall alpha,beta in E$ 是 $F$ 上的代数元，$F(alpha)\/F$ 和 $F(alpha,beta)\/F(alpha)$ 都是代数扩张，由传递性 $F(alpha,beta)\/F$ 也是代数扩张，从而 $alpha plus.minus beta, alpha beta$ 都在 $K$ 中.
]

虽然有限扩张一定是代数扩张，但代数扩张不一定是有限扩张. 例如 $RR$ 中 $QQ$ 上的代数元全体是 $QQ$ 的代数扩张，但不是有限扩张.

#corollary[
  $K$ 上的代数元包含于 $K$.
]
#proof[
  这是因为 $K$ 上的代数元 $u$ 满足 $K(u)\/K$ 是代数扩张，$K\/F$ 也是代数扩张故由传递性 $K(u)\/F$ 是代数扩张，从而 $u$ 在 $F$ 上是代数元，进而 $u$ 在 $K$ 上是代数元.
]

#definition(title: "相对的代数闭, algebraically closed")[
  $E\/K$ 是域扩张，若不存在中间域 $E\/K'\/K$ 使得 $K subset.neq K'$ 且 $K'\/K$ 是代数扩张，则称 $K$ 在 $E$ 中是（相对的）代数闭的.
]

#definition(title: "相对的代数闭包, algebraic closure")[
  $E\/K\/F$ 均为域扩张，若 $K\/F$ 是代数扩张且 $K$ 在 $E$ 中代数闭，则称 $K$ 是 $F$ 在 $E$ 中的（相对的）代数闭包.
  #remark[
    容易看出代数闭包只有一个且就是前述 $F$ 上全部代数元组成的域.
  ]
]

#definition(title: "代数闭域, algebraically closed field")[
  $K$ 是一个域. 若 $K$ 只有平凡代数扩张，则称 $K$ 是代数闭域.
]

#example[
  $CC$ 是代数闭域. $RR$ 在 $CC$ 中的代数闭包是 $CC$.

  $QQ$ 在 $RR$ 中的代数闭包 $K$ 是 $RR$ 的一个真子域，也叫代数数域. #footnote[你可以考虑 $sqrt(2)$ 和 $pi$ 的差异.] $K$ 不是代数闭域，但在 $RR\/QQ$ 中是代数闭的.

  $F$ 在 $F(x)\/F$ 中是代数闭的.
]

#definition(title: "绝对的代数闭包")[
  $K\/F$ 是代数扩张，且 $K$ 是代数闭域，则称 $K$ 是 $F$ 的（绝对的）代数闭包.
]
#theorem(title: "在之后会证明")[
  任一域均有代数闭包且在同构下唯一.
]

#proposition[
  $K$ 是一个域，以下四个命题等价：

  + $K$ 是代数闭域；

  + 任意 $K[x]$ 中不可约多项式次数均为 1；

  + $K[x]$ 中的任意多项式是若干 1 次多项式之积；

  + $K[x]$ 中的任意多项式在 $K$ 上有根.
]
#proof[
  $(1)=>(2)$：注意 $K[x]\/(g(x))$ 是 $K$ 的一个代数扩张，若 $g(x)$ 的次数大于 1 则 $K[x]\/(g(x))\/K$ 是非平凡的代数扩张，与 $K$ 是代数闭域矛盾.

  $(2)=>(1)$：设 $E\/K$ 是代数扩张，则 $forall u in E,$ 取 $g(x)$ 为其极小多项式，则 $K(u) tilde.eq K(x)\/((g(x))) tilde.eq K$, $u in K$ 从而 $E=K$.
]
#theorem[
  $K$ 是一个代数闭域，$F subset K$，$overline(F)$ 是 $F$ 在 $K$ 中的代数闭包，则 $overline(F)$ 是 $F$ 的代数闭包.
]
#proof[
  即证 $overline(F)$ 是代数闭域. 对 $overline(F)[x]$ 中的任一多项式 $f(x)$，其在 $K$ 上有根 $u$，$u$ 是 $overline(F)$ 上的代数元，从而 $u in overline(F)$，即 $f(x)$ 在 $overline(F)$ 上有根. 由前述命题 $overline(F)$ 是代数闭域.
]

#definition[
  对 域扩张 $E\/F$，定义 $"End"(E\/F)$ 和 $"Aut"(E\/F)="Gal"(E\/F)$ 是 $E$ 的自同态/自同构群，保持 $F$ 中元素不变.
]

#proposition[
  $E\/F$ 是代数扩张，则 $"End"(E\/F) = "Aut"(E\/F)$.
]
#proof[
  即证任一同态 $phi in "End"(E\/F)$ 都是双射. 域同态一定是单射（考虑 $ker$ 只能是 $0$），下证 $phi$ 是满射.

  $forall u in E$, $g(x) in F[x]$ 是 $u$ 的极小多项式，设 $S={g(x)" 在 "E" 中全部根"}$，注意 $phi$ 保持 $F$ 元素不变从而 $phi(g(x))=g(phi(x))$，于是 $phi(S)subset.eq S$. 又由于 $phi$ 是单射，$phi(S)=S$，从而 $u in phi(S)$，即 $phi$ 是满射.
]

= 尺规作图问题(Ruler-Compass Construction)

给定一系列点 $z_1,z_2,...,z_n$，做一系列操作（R-C construction）来构造新点. R-C 操作指从已有的点集 $S_0$ 中构造如下两类图形的交点：
- 过 $S_0$ 中两点的直线；
- 以 $S_0$ 中一点为圆心，过另一点的圆.

#proposition[
  记 $S subset CC$ 是可从 $S_0$ 用有限步操作得到的点集. 则
  + $S$ 是 $CC$ 的子域；

  + $S$ 对取平方根和取共轭封闭.

  + $S$ 是 $CC$ 中最小的包含 $S_0$ 且满足上述两个性质的子集.
]

#definition[
  称 $S$ 中的点是由 $S_0$ 可构造（constructable）的点.
]

#definition(title: "根塔, square root tower")[
  $F subset.eq CC$. $F$ 的一个扩张称为 $F$ 上的根塔，若其形如 $F(u_1,...,u_n)$，其中每个 $u_i$ 满足 $u_i^2 in F(u_1,...,u_(i-1))$.
]
可以说明根塔的扩张次数一定是 $2^n$ 的形式.

#theorem[
  $z_1,...,z_n in CC$，$z_1=0,z_2=1$，$F=QQ(z_1, overline(z_1), ..., z_n, overline(z_n))$，则 $z in CC$ 是可构造的等价于 $z$ 在 $F$ 上的一个根塔中.
]

== 三等分角

考虑取 $S_0={0,1}$，则 $F=QQ$. 三等分 $60 degree$，即要构造 $cos 20 degree$. 其在 $F$ 上极小多项式 $8x^3-6x-1$ 与根塔的 $2^n$ 形式的扩张次数矛盾，因此不可能尺规三等分角.

== 可尺规作的正素数多边形(?)

同上，注意 $e^((2pi"i")/p)$ 的一个零化多项式是 $x^(p-1)+x^(p-2)+...+x+1$，其扩张次数为 $p-1$，因此 $p-1$ 必须是 $2^n$ 的形式. 进一步如果 $p-1$ 不是 $2^(2^n)$ 的形式，则极小多项式可以进一步分解，扩张次数不是 $2^n$ 的形式. 因此 $p$ 必须是 $2^(2^n)+1$ 的形式.

