#import "../index.typ": template, tufted
#show: template.with(title: "Nash-Moser 迭代（2）")
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
#show smartquote: set text(font: "New Computer Modern")
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
  size: 11pt,
)
#let leq = $lt.eq.slant$
#let eps = $epsilon$
#let int = $integral$
#let supp = $"supp"$
#let pd(f, x) = $frac(partial #f, partial #x)$
#let dd(f, x) = $frac(d #f, d #x)$

= Nash-Moser 迭代

...

建立了 Newton 格式
$ u_(n+1)=u_n+[Phi'(u_n)]'(f-Phi(u_n)) $
磨光之后的 Nash-Moser 迭代格式是否收敛呢？

...

#proof[残差：
  $
    e_(n+1)=underbrace((I-S_(theta_n))e_n, "磨光误差") - underbrace([Phi'(u_n)-Phi'(v_n)]h_n, "替换误差")-underbrace(Q(u_n,h_n), "Newton误差")
  $
  对两侧取范数 $|| dot ||_s$，得到：
  $ ||e_(n+1)||_s <= ||(I-S_(theta_n))e_n||_s+||(Phi'(u_n)-Phi'(v_n))h_n+Q||_s $

  回忆磨光 Lemma ：
  $ ||(I-S_(theta_n))e_n||<=c theta_n^(-k) $
  替换误差和 Newton 误差的控制：
  由于在逆算子中的导数 $d$ 阶损失，利用柔性估计有
  $
       & ||(Phi'(u_n)-Phi'(v_n))h_n||_s+||Q||_s \
    <= & c ||h_n||^2_s \
    <= & c(theta_n^d ||e_n||_s)^2 \
     = & c theta_n^(2d) ||e_n||_s^2
  $
  于是残差有估计
  $ #box(fill: rgb(230, 250, 250), inset: 10pt)[$||e_(n+1)||_s <= c theta_n^(-k)+c dot theta_n^(2d) ||e_n||_s^2$] $

  令 $D=2d$. 我们想要说明 $||e_n||_s<=theta_n^(-p)$.
  #let rho = text(rgb("#e00"))[$rho$]
  我们拟设（ansatz, 猜测并证明）
  $ ||e_n||_s<= theta_n^(-p) (p>0) $
  希望证明
  $ ||e_(n+1)||_s <= theta_(n+1)^(-p) $
  用归纳假设代入前述误差估计：
  $ ||e_(n+1)||_s <= c theta_n^D theta_n^(-2p)+c theta_n^(-k) $
  目标变为
  $ c theta_n^(D-2p)+c theta_n^(-k)<=theta_(n+1)^(-p)<=theta_n^(p rho) $令 $theta_(n+1)=theta_n^rho (1<rho<=2, rho=1.5)$，从而 $ theta^(-p)_(n+1)=(theta_n^rho)^(-p)=theta_n^(-p rho) $
  如果以下两个条件成立，目标就成立.
  $ C theta_n^(D-2p)<=1/2(theta_n^(-p rho)) $<1>
  $ C theta_n^k<=1/2theta_n^(-p rho) $<2>
  条件 $(1)$ 意味着 $ D-2p< -p rho ==> 2D<p $
  条件 $(2)$ 意味着 $ -k< -p rho ==> k>3D $
  选取合适的 $u_0$ 使得 $k>3D$，还要令 $p>2D$，我们就有：
  $ ||e_(n+1)||_s <= theta_(n+1)^(-p). $

  回到数学归纳的奠基：$u_0$ 应当满足
  $ ||e_0||_s<=theta_0^(-p) $

  于是由数学归纳法结论成立，
  $ ||e_n||_s<=theta_(n+1)^(-p) -?->0 $
  由于 $theta_n=theta_0^(rho^n)=e^(ln(theta_0)rho^n)$,
  $ ||e_n||_s<=theta_n^(-p)=(e^(ln(theta_0)rho^n))^(-p)=e^(-p ln(theta_0)rho^n) $
  令 $c=p ln(theta_0)>0$，则
  $ ||e_n||_s<= e^(-c rho^n)->0 $
]

= 　黒い洞の貼ろう、この世かその世か、扉の暗闇へハロー
