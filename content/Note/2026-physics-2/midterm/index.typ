#import "../index.typ": template, tufted
#show: template.with(title: "物理 期中复习")
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

= 期中复习

== N1

最小电荷单位：$1"e" approx 1.60 times 10^(-19) "C"$

库伦定律
$ bold(F)=k (q_1 q_2) / r^2 bold(hat(r)), k=1/(4 pi eps_0)approx 9 times 10^9 "N" dot "m"^2\/"C"^2 $

$bold(E)=bold(F)\/q$. 点电荷的电场 $ bold(E)=k q / r^2 bold(hat(r)) $

电场线是电场的积分曲线，切线方向=电场方向，越密越强.

电场线是电势下降最快的方向.

无限长直导线电场：$display(E=(lambda)/(2 pi eps_0 r))$，无限大平面电场：$display(E=(sigma)/(2 eps_0))$，正负两板叠加中间两倍外面抵消. 球壳/球体电场：内部部分看做点电荷.

== N2

电通量 $Phi_E=int_S bold(E) dot "d"bold(A)$

Gauss 定律
$ int_S bold(E) dot "d"bold(A)=int_(V) nabla dot bold(E) "d"V=Q_("enc")/eps_0 $

== N3
导体：
- 内部电场为零，等势
- 电荷只分布在表面
- 外部电场垂直于表面
表面电场 $E=sigma\/eps_0$（相比平面电场多一倍）

正（负）电荷顺（逆）电场线，电场力做正功，电势能减少，$ W_(A->B)=-Delta U=U(A)-U(B) $
电势差 $ Delta V=(Delta U)/q=-int_(A)^B bold(E) dot "d"bold(s) $
电势 $ V(p)=-int_(p_0)^p bold(E) dot "d"bold(s), nabla V = -bold(E) $

Stokes 定理
$ int_C bold(V) dot "d"bold(s)=int_S (nabla times bold(V)) dot "d"bold(A) $
保守力等价于 $nabla times bold(F)=0$.
Poisson 方程
$ nabla^2 V = -rho/eps_0 $
静电能（如果充满电介质 $kappa$，则 $eps_0$ 替换为 $kappa eps_0$）
$ U=int 1/2 rho V "d"V = eps_0/2 int bold(E)^2 "d"V $

静电屏蔽：球壳内部穿外部，外部电场进不来；接地球壳内外完全分离. 注意不接地有电荷守恒，以及内表面用gauss定律得到电荷量.

== N4
唯一性定理：电荷分布已知，混合两种边界条件：
- 导体边界上的电势一定
- 导体gauss定律给出的包含的电荷量一定
还有最外侧边界为0.
满足 poisson 方程和以上边界条件的解唯一.

例子：平面+点电荷镜像法，球面反演法.
矩形管道问题：解 poisson 方程-分离变量-解微分方程-组合解-fourier求满足条件的系数

电容：$C=Q\/Delta V$. 单体电容视为和无穷远作用.

球体的电容 $C=4 pi eps_0 R$. 平行板电容器 $C=epsilon_0 A\/d$.

== N5

电容储能 $U=1/2 C (Delta V)^2=int 1/2 epsilon_0 E^2 "d"V$.

电容并联 $C=C_1+C_2$，串联 $C=1\/(1\/C_1+1\/C_2)$.

电介质常数 $Delta V=Delta V_0\/kappa,C=kappa C_0, kappa>=1$

电流 $bold(I)_S=int_S bold(J) dot "d"bold(A), bold(J)=n q bold(v)$. $I=n q v S$，其中 $n$ 是粒子数，$q$ 是每个粒子的电荷量，$v$ 是粒子漂浮速度，$S$ 是横截面积.

电流连续性方程
$ nabla dot bold(J) = - (partial rho)/(partial t), I=("d"Q)/("d"t) $

电流漂浮速度的欧姆定律（电导率 siemens$\/"m"$，电阻率 $Omega dot "m"$）
$ bold(J)=sigma bold(E), bold(E)=rho bold(J) $

柱形电阻 $R=rho l\/A, Delta V=I R$.

电功率 $P=U I = I^2 R$ $->$ 焦耳热

== N6
电动势 $cal(E)$ 和内阻 $r$：$Delta V=cal(E)-I r$.

电阻并联串联：$R=1\/(1\/R_1+1\/R_2)$，$R=R_1+R_2$.

电路分析：设电流看交点找电流规律；找环路，负极到正极加电动势，顺电流经过电阻减去电压.

RC电路：充电，最终$=cal(E)$ $ V(t)=cal(E)(1-e^(-t/(R C))) $
放电
$ q(t)=q_0 e^(-t/(R C)) $

无限长直导线电流磁场 $B=(mu_0 I)/(2 pi r), mu_0=1/(eps_0 c^2)$

洛伦兹力 $bold(F)= q bold(v) times bold(B)$ 不做功

安培力 $bold(F)=int I "d"bold(s) times bold(B)$ 对闭合线圈为 0.

#align(center, table(
  columns: (auto, auto, auto),
  inset: 10pt,
  align: horizon,
  table.header([], [*磁偶极矩*], [*电偶极矩*]),
  [对象], [线圈], [电偶极子],
  [定义], [$bold(mu)=I bold(A)$], [$bold(p)=q bold(d)$],
  [力矩], [$bold(tau)=bold(mu) times bold(B)$], [$bold(tau)=bold(p) times bold(E)$],
  [势能], [$U=-bold(mu) dot bold(B)$], [$U=-bold(p) dot bold(E)$],
))

== N7
Hall 效应：上下电压平衡磁场（测量载流子 $1/(n q)$ 称为 Hall 系数）
$ E=v B, Delta V=(I B)/(n q t) $

Biot-Savart 定律
$ B=(mu_0 I)/(4 pi)int ("d"bold(s) times bold(hat(r)))/bold(r)^2 $
注意 $r$ 是从*电流元*到*测量点*的向量.

平行电流，同向吸引，反向排斥.

Ampere 定律
$ int bold(B) dot "d"bold(s)=mu_0 I_("enc") $
螺线圈磁场只在内部，且
$ B=mu_0 n I $
$n$ 是单位长度线圈数.

== extra

Maxwell 微分形式方程组：
$ nabla times bold(E) = - (partial bold(B))/(partial t) $
$ nabla times bold(B) = mu_0 bold(J) + mu_0 epsilon_0 (partial bold(E))/(partial t) $
$ nabla dot bold(E) = rho/epsilon_0 $
$ nabla dot bold(B) = 0 $

== 明日の神話へ祝う

頑張ってください！
