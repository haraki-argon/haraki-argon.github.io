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
#let proposition = proposition.with(fill: red.darken(10%))
#let lemma = lemma.with(fill: rgb("#f83f8c").darken(10%))
#set text(
  size: 12pt,
)
#let leq = $lt.eq.slant$
#let eps = $epsilon$
#let int = $integral$
#let supp = $"supp"$
#set enum(numbering: "(a)")

= Maxwell Equation 和微分形式

== 微分形式（differential form）

- 在 $RR^3$ 中，记在 $p$ 点处的切空间（tangent space）为 $RR_p^3$. 取基 $e_1=(1,0,0),$ $e_2=(0,1,0),$ $e_3=(0,0,1)$.

- $RR_p^3$ 的对偶空间 $(RR_p^3)^*$ 称为在 $p$ 点处的余切空间（cotangent space），

- 向量场 $V(p)=a_1(p)e_1+a_2(p)e_2+a_3(p)e_3$.

- $(RR_p^3)^*$ 的基记作 ${"d"x_i}_(i=1,2,3)$，其中
  $"d"x_j (e_i):=delta_(i j).$

#definition(title: "1-form")[
  $omega(p)=a_1(p)("d"x_1)_p+a_2(p)("d"x_2)_p+a_3(p)("d"x_3)_p in (RR_p^3)^*$
]
#footnote[利用 Einstein 求和约定，可以简写为 $a_i "d"x_i$.]
#definition(title: "and^2(RR_p^3)^*")[
  $and^2(RR_p^3)^*$ 是如下映射的集合：
  $ phi: (RR_p^3)^* times (RR_p^3)^* & -> RR $
  满足 $phi(v_1, v_2) = -phi(v_2, v_1)$.

  对两个 $phi_1, phi_2 in Lambda^2(RR_p^3)^*$，定义 $phi_1 and phi_2(v_1, v_2)=det(phi_i (v_j)).$
]
#proposition[
  - $"d"x_i and "d"x_k=-"d"x_j and "d"x_i$
  - $"d"x_i and "d"x_i=0$
]

#definition(title: "2-form")[

  $omega(p)&=a_(12)(p) "d"x_1 and "d"x_2+a_(13)(p) "d"x_1 and "d"x_3+a_(23)(p) "d"x_2 and "d"x_3\
  &=sum_(i<j) a_(i j) "d"x_i and "d"x_j$
]
#proposition[
  ${("d"x_(i_1) and "d"x_(i_2) and ... and "d"x_(i_k))_p , i_1 < i_2 < ... < i_k}$ 是 $and^k (RR^n)_p^*$ 的一组基.
]

#definition(title: "k-form")[
  $omega(p)&=sum_(i_1 < i_2 < ... < i_k) a_(i_1 i_2 ... i_k)(p) "d"x_(i_1) and "d"x_(i_2) and ... and "d"x_(i_k)\
  &=sum a_I "d"x_I$

  其中 $I$ 是 $k$-upla $(i_1, i_2, ..., i_k)$ 满足 $i_1 < i_2 < ... < i_k$.
]
#proposition[
  $omega$ 是 $k$-form, $phi$ 是 $s$-form, $theta$ 是 $r$-form，那么
  + $(omega and phi) and theta = omega and (phi and theta).$

  + $omega and phi =(-1)^(k s) phi and omega.$

  + $omega and (phi + theta) = omega and phi + omega and theta.$
]
#definition(title: "拉回, pullback, induced map")[
  $f:RR^n->RR^m$, $omega in and.big^k (RR^m)^*$ . 定义 $ (f^* omega)_p(v_1,...,v_k)=omega(f(p))("d"f_p (v_1),"...","d"f_p (v_k)) $
  对 $0$-form $g$ 满足 $f^*(g)=g compose f$.
]
#definition(title: "外微分")[
  $omega=sum a_I "d"x_I$，定义其外微分为
  $ "d"omega:=sum_I "d"a_I and "d"x_I $
]
#proposition[
  + $"d"(omega_1+omega_2)= "d"(omega_1)+ "d"(omega_2)$

  + $"d"(omega and phi) = "d"(omega) and phi + (-1)^k omega and "d"(phi)$

  + $"d"("d"omega)=0, "d"^2=0$

  + $f^* ("d"omega) = "d"(f^* omega)$
]

== Maxwell 方程 ($RR^(1+3)$)

=== 外微分 $"d"$ 和楔积 $and$

令 $f$ 是一个 $0$-form，$omega,eta$ 是微分形式. 有以下*关键*性质：
+ $"d"(a omega+ b eta)=a"d"omega+ b"d"eta$

+ $"d"f=partial_t f "d"t+partial_x f "d"x+partial_y f "d"y+partial_z f "d"z$

+ $"d"("d"x_i)=0,i=t,x,y,z$

  $"d"(f "d"x_i)="d" f and "d"x_i$

+ $"d"x_i and "d"x_j=-"d"x_j and "d"x_i (i!=j)$

  $"d"x_i and "d"x_i=0$

=== Hodge star $ast$ in Minkowski spacetime

+ Minkowski spacetime 上的内积：

  $("d"t,"d"t)=-1, ("d"x,"d"x)=1, ("d"y,"d"y)=1, ("d"z,"d"z)=1$, 其余两两内积为 $0$.

+ 2-form 的内积：

  $
    (alpha_1 and alpha_2, beta_1 and beta_2):=det mat((alpha_1, beta_1), (alpha_1, beta_2); (alpha_2,beta_1), (alpha_2,beta_2))
  $
+ Volum form $Omega:="d"t and "d"x and "d"y and "d"z$

#definition(title: "Hodge star")[
  Hodge star $ast$ 定义为算子 $ast: and.big^k (V^*)->and.big^(n-k)(V^*)$，将 $beta$ 映射为 $* beta$，其中 $* beta$ 满足
  $ alpha and *beta=(alpha,beta)Omega $
]

计算的实例.
+ $*("d"t and "d"x)=-"d"y and "d"z$.

  这里 $beta="d"t and "d"x$，取 $alpha="d"t and "d"x$，则
  $
    alpha and * beta & =(alpha, beta)Omega \
                     & =det mat(("d"t,"d"t), ("d"t,"d"x); ("d"x,"d"t), ("d"x,"d"x)) Omega \
                     & = - "d"t and "d"x and "d"y and "d"z \
  $<0>
  因而 $* beta=-"d"y and "d"z$


+ $*("d"t and "d"y)=-"d"z and "d"x$.

+ $*("d"t and "d"z)=-"d"x and "d"y$.

+ $*("d"y and "d"z)="d"t and "d"x$.

+ $*("d"z and "d"x)="d"t and "d"y$.

+ $*("d"x and "d"y)="d"t and "d"z$.

=== Faraday 2-form，电磁2-形式

#definition(title: "Faraday 2-form")[
  Faraday 2-form $F$ 定义为
  $
    F = & -E_x "d"t and "d"x - E_y "d"t and "d"y - E_z "d"t and "d"z \
        & + B_x "d"y and "d"z + B_y "d"z and "d"x + B_z "d"x and "d"y
  $
  其中 $E_i$ 是电场分量，$B_i$ 是磁场分量，都是 $(t,x,y,z)$ 的函数.
]

= Maxwell 方程的微分形式表达

#theorem[
  在 Minkowski spacetime 上，齐次 Maxwell 方程 $ cases(nabla dot B=0, nabla times E +B_t=0) $ 等价于
  $ "d"F=0 $
]

#theorem[
  在 Minkowski spacetime 上，非齐次 Maxwell 方程 $ cases(nabla dot E= rho, nabla times B - E_t= j) $ 等价于
  $ "d"*F=J $
]

#proof(title: "定理1的证明")[
  由定义
  $
    F = & -E_x "d"t and "d"x - E_y "d"t and "d"y - E_z "d"t and "d"z \
        & + B_x "d"y and "d"z + B_y "d"z and "d"x + B_z "d"x and "d"y
  $
  做外微分：（注意只能对 $y$ 和 $z$ 做外微分，否则会产生 0）
  $ "d"(E_x "d"t and "d"x)=- partial_y E_x "d"y and "d"t and "d"x-partial_z E_x "d"z and "d"t and "d"x $
]
