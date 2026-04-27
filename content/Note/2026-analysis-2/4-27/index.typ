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

== 微分形式和协变张量的拉回

#definition(title: "微分形式的拉回")[
  $F:M->N$ 是一个光滑映射，$omega in Omega^k (N)$ 是 $k$-form，定义拉回 $F^*: Omega^k (N)-> Omega^k (M)$

  $ F^*omega_p (v_1,...,v_k)=omega_(F(p)) ("d"F(v_1),...,"d"F(v_k)) $
]

#definition(title: "协变张量的拉回")[
  $F:M->N$ 是一个光滑映射，$A$ 是一个 $(0,k)$ 型的协变张量场. 定义拉回

  $ F^* A(v_1,...,v_k)=A("d"F(v_1),...,"d"F(v_k)) $
]

#proposition[
  + 若 $g:RR^m->RR$ 是一个 0-form，$omega$ 是一个 $RR^m$ 上的 $k$-form，那么
    $
      f^* (g dot omega) & = (f^* g) dot (f^* omega) \
                        & = (g compose f) dot (f^* omega)
    $
  + $ f^*(omega and phi)= f^* omega and f^* phi $
    $ f^*(omega tensor phi)= f^* omega tensor f^* phi $

  + $ (f compose g)^* = g^* compose f^* $
]
根据以上性质，我们只要研究如何把一个 $"d"x_i$ 拉回就可以了.

#proposition(title: "局部坐标卡下的拉回")[
  $f:M->N$，$M$ 的维数是 $m$，$N$ 的维数是 $n$.

  取 $(x^1, ..., x^m)$ 和 $(y^1, ..., y^n)$ 分别是 $M$ 在 $p in M$ 附近和 $N$ 在 $f(p)$ 附近处的局部坐标卡.

  设 $ y^j compose f = f^j (x^1, ..., x^m), j=1, ..., n $

  那么

  + $ f^*("d"y^j)=sum_(i=1)^m (partial f^j)/(partial x^i) "d"x^i $

  + 对于一般的 1-form $omega=sum_(j=1)^n a_j (y) "d"y^j$，
    $ f^* (omega)=sum_(i=1)^m sum_(j=1)^n (a_j compose f) (partial f^j)/(partial x^i) "d"x^i $
]
#proof[
  设
  $ f^* ("d"y^j)=sum_(i=1)^m b_i "d"x_i $
  使用 $(partial)/(partial x^i)$ 作为 test vector，计算得
  $ "LHS"= f^* ("d"y^j)(partial/(partial x^i))="d"y^j ("d"f (partial/(partial x^i))) $
  其中
  $ "d"f (partial/(partial x^i))=sum_(l=1)^n (partial f^l)/(partial x^i) (partial)/(partial y^l) $
  于是
  $ f^* ("d"y^j) (partial/(partial x^i)) =(partial f^j)/(partial x^i) $
  右侧
  $ "RHS"=(sum_(r=1)^m b_r "d"x^r)(partial/(partial x^i))=b_i $
  因此
  $ (partial f^j)/(partial x^i) = b_i $
]

#proof(title: "Second proof")[
  $ f^* ("d"y^j)="d"y^j ("d"f(-))="d"(y^j compose f)=sum_(i=1)^m (partial f^j)/(partial x^i) "d"x^i $
]

#example[
  $F:RR->RR^2, t|->(cos t, sin t)=(x,y)$. 令 $1$-form $omega= x"d"y-y"d"x$，计算 $F^* omega$.

  #solution[
    $
      F^*("d"x) & ="d"(x compose F)="d"(cos t)=-sin t "d"t \
      F^*("d"y) & ="d"(y compose F)="d"(sin t)=cos t "d"t \
      F^* omega & =F^* x dot F^* ("d"y)-F^* y dot F^* ("d"x) \
                & =(cos t) (cos t "d"t)-(sin t) (-sin t "d"t) \
                & = "d"t
    $
  ]
]

#proposition(title: "(0,k) 型协变张量的拉回")[
  $f:M->N$ 是一个光滑映射，$A$ 是一个 $N$ 上的 $(0,k)$ 型协变张量场. 取 $p in M$ 和 $f(p) in N$ 的局部坐标卡如前.

  设 $ T= sum_(j_1,...,j_k=1)^n T_(j_1,...,j_k) (y) "d"y^(j_1) tensor ... tensor "d"y^(j_k) $

  那么
  $
    f^* T = sum_(i_1,...,i_k=1)^m sum_(j_1,...,j_k=1)^n (T_(j_1,...,j_k) compose f) (partial f^(j_1))/(partial x^(i_1)) ... (partial f^(j_k))/(partial x^(i_k)) "d"x^(i_1) tensor ... tensor "d"x^(i_k)
  $
]

#example[
  例子同前. 令 $g="d"x tensor "d"x+ "d"y tensor "d"y$，求 $F^* g$.

  #solution[
    $
      F^* "d"x & =-sin t "d"t \
      F^* "d"y & =cos t "d"t \
         F^* g & =F^* "d"x tensor F^* "d"x+ F^* "d"y tensor F^* "d"y \
               & =(-sin t "d"t) tensor (-sin t "d"t)+(cos t "d"t) tensor (cos t "d"t) \
               & = (sin^2 t + cos^2 t) "d"t tensor "d"t \
               & = "d"t tensor "d"t
    $
  ]
]

== 嵌入子流形 Embedded submanifolds
#definition(title: "嵌入子流形")[
  $M$ 是一个 $n$ 为光滑流形，令 $Sigma subset.eq M$ 是一个子集，我们称 $Sigma$ 为一个光滑的 $k$ 维*嵌入子流形*，如果：

  $forall p in M$, 存在一个 $M$ 在 $p$ 处的局部坐标卡 $(U,x^1,...,x^n)$，使得
  $ chi(U inter Sigma)=chi(U) inter (RR^k times {0}) $
  等价地，
  $ U inter Sigma={q in U, x^(k+1)(q)=...=x^n(q)=0} $
]
#definition(title: "包含映射, inclusion map")[
  令 $(M^n,g)$ 是一个 Riemann 流形, $Sigma^k subset.eq M$ 是一个嵌入子流形. 定义
  $
         i: Sigma & -> M \
    (u^1,...,u^k) & |-> (u^1,...,u^k,0,...,0)
  $
  保持 $i(p)=p, forall p in Sigma$.
]
#definition(title: "子流形上的诱导度量")[
  $ h=i^* g $
  诱导的面元：
  $ "d"V_n= sqrt(det(h)) "d"x^1 ... "d"x^k $
]
#definition(title: "浸入, immersion")[
  令 $f:M->N$ 是一个光滑映射，我们称 $f$ 是一个*浸入*如果 $forall p in M$，
  $ "d"f: T_p M -> T_f(p) N $ 是单射.
]
#proposition(title: "协变张量场与度量的拉回")[
  $f:M->N$ 是一个光滑映射.
  + 若 $phi$ 是一个 $(0,r)$ 型的协变张量场，那么 $f^phi$ 是一个 $(0,r)$ 型的协变张量场；如果 $phi$ 是对称的，那么 $f^* phi$ 也是对称的.

  + 若 $f$ 是一个浸入，$phi$ 是 $N$ 上的 Riemann 度量，那么 $f^* phi$ 是 $M$ 上的 Riemann 度量.
]
#proof[
  1. 是显然的.
  2. 只需验证正定性.
    对 $0!=v in T_p M$，有 $"d"f_p (v)!=0$. 由于 $phi$ 是 Riemann 度量，
    $ f^* phi(v, v)=phi("d"f_p (v), "d"f_p (v))>0. $
]
#proposition(title: "诱导度量的局部表达")[
  令 $(M,g)$ 是一个 Riemann 流形，取前述诱导映射 $i: Sigma->M$ 是一个嵌入子流形. 定义 $h=i^* g$. 令 $Phi: W subset.eq RR^n -> Sigma$ 是一个 $(u^1,...,u^k)$ 局部坐标卡. 则拉回
  $ Phi^* h= sum_(a,b=1)^k h_(a b) "d"u^a tensor "d"u^b $
  其中 $ h_(a b)=g_(Phi(u))((partial Phi)/(partial u^a), (partial Phi)/(partial u^b)) $
]
#proof[
  令 $F: i compose Phi : W->M$. 由于 $h=i^* g$，
  $ F^* g=Phi^*(i^* g)=Phi^* h $
  取 $(y^1,...,y^n)$ 为 $M$ 上的局部坐标卡，则
  $ g=sum_(alpha,beta=1)^n g_(alpha beta) "d"y^alpha tensor "d"y^beta $
  拉回得到
  $
    F^*g &= sum_(alpha,beta=1)^n F^*(g_(alpha beta)) F^*("d"y^alpha) tensor F^*("d"y^beta)\
    &= sum_(alpha,beta=1)^n (g_(alpha beta)compose F) [sum_(a=1)^k (partial F^alpha)/(partial u^a) "d"u^a] tensor [sum_(b=1)^k (partial F^beta)/(partial u^b) "d"u^b] \
    &= sum_(a,b=1)^k sum_(alpha,beta=1)^n (g_(alpha beta) compose F) (partial F^alpha)/(partial u^a) (partial F^beta)/(partial u^b) "d"u^a tensor "d"u^b \
  $
  因此
  $
    h_(a b)=sum_(alpha,beta=1)^n (g_(alpha beta) compose F) (partial F^alpha)/(partial u^a) (partial F^beta)/(partial u^b)=sum_(alpha,beta=1)^n (g_(alpha beta) compose F) (partial y^alpha compose F)/(partial u^a) (partial y^beta compose F)/(partial u^b)
  $
  另一方面
  $
    (partial F)/(partial u^a)=sum_(alpha=1)^n (partial y^alpha)/(partial u^a) dot lr((partial)/(partial y^alpha)|)_(F(u))="d"F((partial)/(partial u^a))
  $
  故
  $
    g((partial F)/(partial u^a), (partial F)/(partial u^b))=sum_(alpha,beta=1)^n (g_(alpha beta) compose F) (partial y^alpha compose F)/(partial u^a) (partial y^beta compose F)/(partial u^b)
  $
  与 (33) 式相等.
]

#example[
  （球面上的诱导度量）令 $S^2={(x,y,z) in RR^3, x^2+y^2+z^2=1}.$ $i: S^2->RR^3$ 是包含映射. 取标准欧式度量 $g_EE= "d"x tensor "d"x+ "d"y tensor "d"y+ "d"z tensor "d"z$. 则拉回度量在局部坐标卡上的表达式为
  $ g_(Omega)=i^* g_EE ="d"theta^2+sin^2 theta "d"phi^2. $

  我们考虑 $ Psi:(0,pi) times (0,2pi) & ->S^2 \
               (theta,phi) & |->(sin theta cos phi, sin theta sin phi, cos theta). $
  则 $x compose Psi=sin theta cos phi$, $y compose Psi=sin theta sin phi$, $z compose Psi=cos theta$. 计算
  $
    Psi^*("d"x) & ="d"(x compose Psi)="d"(sin theta cos phi)=cos theta cos phi "d"theta-sin theta sin phi "d"phi \
    Psi^*("d"y) & =cos theta sin phi "d"theta+sin theta cos phi "d"phi \
    Psi^*("d"z) & =-sin theta "d"theta
  $
  代入计算得对度量的拉回
  $ Psi^*(g_EE)= "d"theta^2+sin^2 theta "d"phi^2 $
]
#example[
  球面上的
  $ g=(2+cos theta)"d"theta^2+(2+ cos theta)sin^2 theta "d"phi^2 $
  也是 $S^2$ 上的一个 Riemann 度量.
]
== 子流形上的0-form积分（第一型曲面积分）
令 $(M,g)$ 是一个 Riemann 流形，$Sigma subset M$ 是一个嵌入子流形，包含映射 $i: Sigma -> M$，诱导度量 $h=i^* g$，面积元为 $"d"V_n= sqrt(det(h)) "d"u^1 ... "d"u^k$.
令 $Phi:W subset.eq RR^k -> Sigma$ 是一个局部坐标卡 $u=(u^1,...,u^k)$，则
$ h_(a b)=g_(Phi(u))((partial Phi)/(partial u^a), (partial Phi)/(partial u^b)) $

#definition(title: "子流形局部的积分")[
  $f:Omega->RR$ 是 $Omega$ 上的紧支函数，定义
  $ int_Omega f "d" V_h:=int_W f compose Phi sqrt(det(h)) "d"u^1 ... "d"u^k $
]

#proposition(title: "参数化无关性")[
  上述定义与局部坐标卡 $Phi$ 的选取无关.
]

#definition(title: "子流形全局积分")[
  令 $f:Sigma->RR$ 是 $Sigma$ 上的紧支函数，取图册 ${(Omega_alpha,X_alpha)}$ 以及每块上的参数化 $Phi_alpha:W_alpha->Omega_alpha subset.eq Sigma$. 选择一个单位分解 ${rho_alpha}$ 使得 $0<=rho_alpha<=1$, $sum_alpha rho_alpha=1$ 且 $supp(rho_alpha) subset.eq Omega_alpha$.

  定义
  $ int_Sigma f "d"V_h:=sum_alpha rho_alpha int_(Omega_alpha) f "d"V_h $
]

*第一型曲线积分*
我们取 $gamma:[a,b]->RR^n$，诱导的度量为 $h_11=chevron.l gamma'(t), gamma'(t) chevron.r=(gamma')^2.$
因此
$"d"V_h=|gamma'(t)| "d"t$. 则上述定义就是
$ int_Sigma f "d"V_n =int_a^b f(gamma(t)) |gamma'(t)| "d"t $

*第一型曲面积分*
我们取 $Phi: W subset.eq RR^2 -> Sigma subset.eq RR^3$. 诱导的度量
$ h=g((partial Phi)/(partial u_a),(partial Phi)/(partial u_b)) $
就是 Jacobian 的"平方"
$
  (h_(a b))=mat(
    chevron.l Phi_u"," Phi_u chevron.r, chevron.l Phi_u"," Phi_v chevron.r;
    chevron.l Phi_v"," Phi_u chevron.r, chevron.l Phi_v"," Phi_v chevron.r
  )
$
算得 $"det"(h)=|Phi_u times Phi_v|^2$
因而
$ int_Sigma f "d"V_h =int_W f compose Phi |Phi_u times Phi_v| "d"u "d"v. $

我们得到和经典的第一型曲线、曲面积分完全一样的结果.
这是一种更高的视角的理解.
