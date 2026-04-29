#import "../index.typ": template, tufted
#show: template.with(title: "Riemann 流形上的积分")
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

= Riemann 流形上的积分计算

#proposition(title: "参数化上的积分")[
  令 $Sigma^k$ 是一个可定向光滑流形，$omega in Omega^k(Sigma)$ 是一个 $k$-形式. 设 $D_1,...,D_m$ 是一些 $RR^k$ 中的开集，且对于每个 $i=1,...,m$，有光滑映射
  $ F_i : overline(D_i)->Sigma $
  使得
  + $F_i|_(D_i)$ 是保定向的微分同胚，将 $D_i$ 映射到 $W_i subset Sigma.$
  + $W_i inter W_j = emptyset$ 当 $i != j$ 时.
  + $supp omega subset overline(W_1) union dots.h.c union overline(W_m)$
  则
  $ int_Sigma omega= sum_(i=1)^m int_(D_i) F_i^*(omega) $
]
#example[
  在球面 $S^2$ 上的 2-形式 $omega=x"d"y and "d"z + y "d"z and "d"x+ z "d"x and "d"y$，计算 $int_(S^2) omega$.
  #solution[
    取 $D=(0,pi) times (0,2pi)$，利用球极投影定义
    $
             F: D & -> S^2 \
      (phi,theta) & |-> (sin phi cos theta, sin phi sin theta, cos phi)
    $
    计算得
    $
      F^*(x)=x compose F=sin phi cos theta, F^*(y) & =sin phi sin theta, F^*(z)=cos phi
    $
    $
      F^* ("d"x) & =cos phi sin theta "d"phi - sin phi sin theta "d"theta \
      F^* ("d"y) & =cos phi cos theta "d"phi + sin phi cos theta "d"theta \
      F^* ("d"z) & =-sin phi "d"phi
    $
    那么
    $ F^*omega = sin phi "d"phi and "d"theta $
    故
    $ int_(S^2) omega = int_D sin phi "d"phi and "d"theta = 4pi $

  ]
]
*第二类曲面积分*
$ int_S chevron.l X,N chevron.r_(g_EE) "d"A $
其中 $"d"A=sqrt(det h) "d"u and "d"v$，$h=i^* g_EE$ 是拉回度量.

*第二类曲线积分*
$ int_gamma chevron.l X,T chevron.r_(g_EE) "d"s $
其中 $"d"s=|gamma'(t)| "d"t$，$T$ 是切向量.

#example[（电动力绕环积分）

  $x-y$ 平面上放置一个线圈，$z$ 方向上通有匀强磁场 $B$，$B$ 随时间变化使得线圈感应出电流. 求总电动势.

  由法拉第电磁感应定律，电动势等于磁通量的负时间导数，即
  $
    E_t (x,y,z)=((dot(B)(t))/2 y, -(dot(B)(t))/2 x, 0)\
    C_R:={(x,y,0) | x^2+y^2=R^2}\
    cal(E)(t)=int_(C_R) chevron.l E_t,T chevron.r_(g_EE) "d"s
  $
  参数化：$gamma(theta)=(R cos theta, R sin theta, 0), theta in [0, 2pi]$.

  $gamma'(theta)=(-R sin theta, R cos theta, 0)$ 得到单位切向量 $T=(-sin theta, cos theta, 0)$

  体元 $"d"s=|gamma'(theta)| "d"theta= R "d"theta$
  $ chevron.l E_t,T chevron.r_(g_EE) = -(dot(B)(t))/2 R $

  因此
  $ int_(C_R) chevron.l E_t,T chevron.r_(g_EE) "d"s =int_0^(2pi) -(dot(B)(t))/2 R^2 "d"theta=- pi R^2 dot(B)(t) $
]
#proposition(title: "经典的第二类曲面积分")[
  设 $Phi:W subset RR^2 -> S subset RR^3$ 是参数化，$X=P partial_x + Q partial_y + R partial_z$，那么
  $
    int_S chevron.l X,N chevron.r_(g_EE) "d"A & = int_W X(Phi(u, v)) (Phi_u times Phi_v) "d"u "d"v \
                                              & =int_S P "d"y and "d"z+ Q "d"z and "d"x+ R "d"x and "d"y
  $
]
#proof[
  诱导度量
  $
    h_(a b)=mat(chevron.l Phi_u"," Phi_u chevron.r, chevron.l Phi_u"," Phi_u chevron.r; chevron.l Phi_v"," Phi_v chevron.r, chevron.l Phi_v"," Phi_v chevron.r)\
    "det" h=|Phi_u times Phi_v|^2
  $
  故
  $ "d"A=|Phi_u times Phi_v| "d"u "d"v $
  法向量
  $ N=(Phi_u times Phi_v)/(|Phi_u times Phi_v|) $
  故
  $
    chevron.l X,N chevron.r_(g_EE) &= X dot (Phi_u times Phi_v)/(|Phi_u times Phi_v|) dot |Phi_u times Phi_v| "d"u and "d"v\
    &= X dot (Phi_u times Phi_v) "d"u and "d"v\
  $

  又，
  $ Phi=(X(u, v), Y(u, v), Z(u, v)) $
  计算得
  $
    Phi^* ("d"y and "d"z)= (Y_u Z_v - Y_v Z_u) "d"u and "d"v\
    Phi^* ("d"z and "d"x)= (Z_u X_v - Z_v X_u) "d"u and "d"v\
    Phi^* ("d"x and "d"y)= (X_u Y_v - X_v Y_u) "d"u and "d"v
  $
  故
  $ Phi^*(P "d"y and "d"z+ Q "d"z and "d"x+ R "d"x and "d"y)=X(Phi(u, v)) dot (Phi_u times Phi_v) "d"u and "d"v $
]

#example[
  上半球面 $S_+={(x,y,z) | x^2+y^2+z^2=1, z>=0}, X=(partial)/(partial z)= (0,0,1)$. 计算通量 $ int_(S_+) X dot N "d"A $.

  考虑参数化 $ Phi:[0,pi/2] times [0,2pi] & -> S_+ \
                 (phi,theta) & |-> (sin phi cos theta, sin phi sin theta, cos phi) $
  那么
  $
    Phi_theta=(-sin phi sin theta, sin phi cos theta, 0)\
    Phi_phi=(cos phi cos theta, cos phi sin theta, -sin phi)
  $
  其度量为
  $ h_(a b)=mat(1, 0; 0, sin^2 phi) $
  于是
  $ "d"A=sin phi "d"phi "d"theta , N=(sin phi cos theta, sin phi sin theta, cos phi) $
  从而
  $ int_(S_+) X dot N "d"A = int_0^(pi/2) int_0^(2pi) cos phi sin phi "d"phi "d"theta = pi $
]
以上我们介绍了 0-形式的积分.
