#import "../index.typ": template, tufted
#show: template.with(title: "Stokes 公式和 Possion 方程")
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

== Stokes 定理

见书 DIFFERENTIAL FORMS AND APPLICATIONS (MANFREDO P.DO CARMO etc.)  63 页.

== Possion equation

$"d" * "d" u=f nu=f sqrt("det"g) "d"x_1 and "d"x_2 and ... and "d"x_n$.

=== Riemann 度量
局部的欧式度量+单位分解
$ g=sum_(i=1)^(m) phi_i g_i $

$g_p:T_p M times T_p M -> RR$

#example[
  考虑 $g=sum_(i,j)g_(i,j) (x) "d"x_i times.o "d"x_j$

  那么 $g(v,v)=(v_1,v_2)mat(g_11, g_12; g_21, g_22)vec(v_1, v_2)$
  其中 $(g_(i j))$ 是正定对称的.
]

定义 Volume form $Omega=sqrt("det"g) "d"x_1 and "d"x_2 and ... and "d"x_n$.

=== $S^2$ 上的度量和possion 方程

以极坐标 $theta,phi$ 作为坐标卡，则 $S^2$ 上的度量为

$ g_(S^2)="d"theta^2+sin^2 theta "d"phi^2, theta in [0,pi],phi in [0,2pi) $

$ (g_(i j))_(2 times 2)=mat(g_(theta theta), g_(theta phi); g_(phi theta), g_(phi phi))=mat(1, 0; 0, sin^2 theta) $
用来测量向量的长度

其逆
$ (g^(i j))_(2 times 2)=mat(g^(theta theta), g^(theta phi); g^(phi theta), g^(phi phi))=mat(1, 0; 0, sin^(-2) theta) $
用来测量1-form的长度（$chevron.l "d"theta,"d"theta chevron.r = 1, chevron.l "d"phi,"d"phi chevron.r = sin^(-2)theta$）

下面定义 hodge star. 对 1-form $beta$ 定义 $* beta$ 使得
$ a and * beta = (alpha,beta)Omega $
其中 $Omega$ 是 volume form. 在 $S^2$ 中 $Omega=sin theta "d"theta and "d"phi$.

计算 $*"d"theta$，由定义
$ "d"theta and * "d"theta = ("d"theta,"d"theta)Omega=sin theta "d"theta and "d"phi ==> * "d"theta = sin theta "d"phi $
同样地计算。我们总结：

$ *"d"theta= sin theta "d"phi , * "d"phi=-1/(sin theta) "d"theta $

那么，对 Possion 方程左侧 $"d"*"d"u$，其是什么呢？


设 $ "d"u=partial_theta u "d"theta + partial_phi u "d"phi $

那么 $ *"d"u=partial_theta sin theta "d"phi - 1/(sin theta) partial_phi u "d"theta $


进而 $ "d"*"d"u&=partial_theta (partial_theta u sin theta)"d"theta and "d"phi + partial_phi (1/(sin theta) partial_phi u) "d"theta and "d"phi\
&= [partial_theta (partial_theta u sin theta) + partial_phi (1/(sin theta) partial_phi u)] "d"theta and "d"phi $

（試験内容以上っていわれた）

我们现在来考虑上半球面上的 possion 方程：

$
  cases(
    "d"*"d"u=f sin theta "d"theta and "d"phi,
    u|_(partial Omega)=0
  )
$
我们在 $theta in [0 , pi], phi in [0, 2 pi]$ 的矩形坐标卡区域剖分.

设剖分点 $U_(i,j)=U(theta_i, phi_j)$.

#image("59d305cf1eb0e4be324c9adfbe5af707.jpg", width: 70%)

$ int_M "d"*"d"u=int_M f sin theta "d"theta and "d"phi $
用*流形上的Stokes公式*，
$ int_M "d"*"d"u=int_(partial M) * "d"u $
计算 $A B$ 边，其平行于 $theta$，故
$ int_(A B) * "d"u=int_(theta_i-(Delta theta)/2)^(theta_i+(Delta theta)/2) partial_phi u "d"theta $
其中 $Delta theta$ 是一个常值，$partial_phi U=1/(Delta phi)(U_(i,j)-U_(i,j-1))$. 故
$
  int_(A B) * "d"u & =int_(theta_i-(Delta theta)/2)^(theta_i+(Delta theta)/2) partial_phi u "d"theta \
                   & =Delta theta dot (U_(i,j)-U_(i,j-1))/(Delta phi) dot (-1)/(sin theta) \
                   & =-(Delta theta)/(Delta phi) dot 1/(sin theta) (U_(i,j)-U_(i,j-1))
$
同样地，计算 $B C$ 边得到
$ int_(B C) * "d"u= $
