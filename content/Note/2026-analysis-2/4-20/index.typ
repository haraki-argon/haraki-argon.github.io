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

= Riemann 流形
== Review

#definition(title: "covectors")[
  有限维 $k$-线性空间 $V$ 的对偶空间 $V^*=cal(L)(V,k)$ 中的元素.

  #example[$V=RR^2, omega(x, y)=3x-y, omega in V^*.$]
]

#definition(title: "bilinear form")[
  一个 $V$ 上的双线性形式是一个 $V$ 上的二元函数 $B: V times V$，使得对于任意固定的 $v in V$，函数 $B(v, -)$ 和 $B(-, v)$ 都是 $V$ 上的线性函数.

  e.g. 内积 $chevron.l -,- chevron.r$
]
#remark[
  2-form $"d"x_1 and "d"x_2$ 也是 $RR^2$ 上的双线性形式.
  考虑 $u=(u_1, u_2),v=(v_1, v_2),$ 则
  $ ("d"x_1 and "d"x_2) (u,v)= det mat("d"x_1(u), "d"x_1(v); "d"x_2(u), "d"x_2(v))=u_1v_2-u_2v_1 $
  其几何含义是 $u$ 和 $v$ 生成的平行四边形的有向面积. 又，可以考虑为叉积 $(u_1,u_2,0) times (v_1,v_2,0)$. 即
  $ ("d"x_1 and "d"x_2)(u,v)=(u times v)bold(k) $
]
== Tensor
#definition(title: "tensor")[
  设 $V$ 是一个有限维 $RR$-线性空间. 一个 $V$ 上的张量(tensor) 是一个多线性函数 $ T: V^* times ... times V^* times V times ... times V -> RR, $其中 $V^*$ 出现 $r$ 次，$V$ 出现 $s$ 次. 这样的张量被称为类型(type) $(r, s)$ 的张量.
]
#example[
  + 向量是类型 $(1, 0)$ 的张量. (拉回映射)
  + covector（协向量）是类型 $(0, 1)$ 的张量.
  + 双线性形式是类型 $(0, 2)$ 的张量.
  + 对向量 $u,v$ 定义
    $ T_(u,v):V^* times V^* -> RR : T_(u,v)(alpha,beta)=alpha(u)beta(v) $
    是一个 $(2, 0)$ 类型的张量.

  + 对 $omega in V^*, u in V$ 定义
    $ T_(omega,u)=omega(u) $
    是一个 $(1, 1)$ 类型的张量.
]
#definition(title: "tensor product")[
  设 $F in cal(L)(V_1,...,V_k, RR)$（这里并不区分类型）, $G in cal(L)(W_1,...,W_l, RR)$ 是两个多重线性映射，则它们的张量积 $F tensor G$ 定义为
  $
    F tensor G in L(V_1,...,V_k,W_1,...,W_l, RR)\
    F tensor G(v_1,...,v_k,w_1,...,w_l)=F(v_1,...,v_k)G(w_1,...,w_l)
  $
]
#example[
  对 $omega, eta in V^*$, $omega tensor eta : V times V ->RR$ 为
  $ omega tensor eta (u,v)=omega(u)eta(v) $
  是一个 $(0, 2)$ 类型的张量.
]

#example[
  设 $e_1,e_2$ 是 $RR^2$ 标准基，$e^1,e^2$ 是对应的对偶基，那么
  $ e^1 tensor e^2(u,v)=e^1(u)e^2(v)=u_1v_2 $
]
#remark[
  通常来说，张量积不满足交换律，即 $omega tensor eta != eta tensor omega$.
]

== Tensor field on manifold

令 $M$ 为一个光滑流形， $p in M$ 处的切空间记为 $T_p M$，余切空间记作 $T_p^* M$.

#definition(title: "tensor field")[
  $M$ 上的在 $p in M$ 处的一个 $(r,s)$ 型的张量场是指
  $
    T_p: underbrace(T_p^* M times dots.c times T_p^* M, r" times") times underbrace(T_p M times dots.c times T_p M, s" times") -> RR
  $
  且 $T_p$ 随 $p$ 平滑变化.
]

考虑流形上的一个局部坐标卡 $(U,x_1,...,x_n)$. $(partial)/(partial x^1),...,(partial)/(partial x^n)$ 是 $T_p M$ 的一个基，$"d"x_1,...,"d"x_n$ 是 $T_p^* M$ 的一个对偶基.#footnote[这里的上标和下标并没有实际含义，只表示第几个分量，为了适用 Einstein 求和约定而已.]
则 $(r,s)$ 型的张量场 $T$ 可以表示为
$
  T=T^(i_1...i_r)_(j_1...j_s) partial/(partial x_(i_1)) tensor dots.c tensor partial/(partial x_(i_r)) tensor "d"x_(j_1) tensor dots.c tensor "d"x_(j_s)
$
其中系数 $T^(i_1...i_r)_(j_1...j_s)$ 是 $U$ 上的一个光滑函数.

注. (10) 式使用了*Einstein 求和约定*，即
$ T=sum_(i_1,...,i_r,j_1,...,j_s) ... $
一般地，
$ a_i b^i=sum_(i=1)^n a_i b^i =sum_(i=1)^n a_i b_i $

#remark(title: "covariant tensor，协变张量")[
  $(0,s)$ 类型的张量场被称为协变张量(covariant tensor).
]

== $(0,2)$ 型张量和 $2$-form
#definition(title: "(0,2) 型张量")[
  $(0,2)$ 型的张量场 $T_p$ 即
  $ T_p :T_p M times T_p M -> RR $
]
在局部坐标卡中可表示为
$ T= T_(i j) "d"x_i tensor "d"x_j= sum... $
具体地对 $X=X^i partial/(partial x_i), Y=Y^j partial/(partial x_j)$，有
$
  T(X,Y) & =T_(i j) ("d"x^i tensor "d"x^j)(X^i partial/(partial x_i), Y^j partial/(partial x_j)) \
         & = T_(i j) X^i Y^j
$
#definition(title: "对称与反对称")[
  $V$ 上的一个 $(0,2)$ 型张量 $B$ 被称为对称的，如果
  $ B(u,v)=B(v,u), forall u,v in V $
  被称为反对称的，如果
  $ B(u,v)=-B(v,u), forall u,v in V $
  #remark[
    $2$-form 是反对称的 $(0,2)$ 型张量.
  ]
]

#definition(title: "微分映射")[
  设 $F:M->N$ 是一个光滑映射. $forall p in M,$ 定义 $F$ 在 $p$ 处的微分是一个线性映射
  $ "d"F_p: T_p M & -> T_(F(p)) N $
  使得 $"d"F_p (v)(f)=v(f compose F), forall f in C^oo (N)$
]

回忆
#definition(title: "微分形式的拉回")[
  令 $F:M->N$ 是一个光滑映射， $omega in Omega^k (N)$ 是一个 $N$ 上的 $k$-form，则 $F$ 的拉回映射 $F^*: Omega^k (N) -> Omega^k (M)$ 定义为
  $ (F^* omega)_p (v_1, ..., v_k)=omega_(F(p)) ("d"F_p (v_1), ..., "d"F_p (v_k)) $
]

我们定义
#definition(title: "协变张量的拉回")[
  令 $F:M->N$ 是一个光滑映射，$A$ 是一个 $k$ 类型的 $N$ 上的协变张量场，则 $F$ 的拉回映射 $F^*$ 定义为
  $ F^*A(v_1, ..., v_k)=A_(F(p))( "d"F_p (v_1), ..., "d"F_p (v_k)) $
]

#proposition(title: "双线性形式的基本事实")[
  令 $V$ 是一个实线性空间， $A,B : V times V -> RR$ 是两个双线性形式，则
  + $A+B$ 是一个双线性形式.

  + $forall lambda in RR$, $lambda A$ 是一个双线性形式.

  + $A,B$ 对称，则 $A+B$ 对称.

  + $A$ 对称， $forall lambda in RR$, $lambda A$ 也是对称的.
]
#proof[ 这是简单的线性代数.]

#definition(title: "Riemann 度量，Riemann 流形")[
  一个 $M$ 上的 Riemann 度量是一个 $(0,2)$ 型的协变张量场，
  $ forall p in M, g_p : T_p M times T_p M -> RR $
  满足：
  + $g_p$ 是对称的.
  + $g_p$ 是正定的，即 $forall u in T_p (M)\\{0}, g_p (u,u)>0$.

  如果 $M$ 上存在一个 Riemann 度量 $g$ ，则称 $(M,g)$ 是一个 Riemann 流形.
]
在局部坐标卡 $(U,x_1,...,x_n)$ 下，Riemann 度量 $g$ 可以表示为
$
  g=g_(i j) "d"x^i tensor "d"x^j=sum_(i,j=1)^n g_(i j) "d"x^i tensor "d"x^j
$
其中系数 $g_(i j)$ 是 $U$ 上的一个光滑函数，矩阵 $(g_(i j))$ 是对称正定的.

如果 $X=X^i partial/(partial x_i)$, $Y=Y^j partial/(partial x_j)$，则
$
  g(X,Y) & =g_(i j) X^i Y^j \
         & =(X^1,...,X^n) mat(g_(11), ..., g_(1n); dots.v, , dots.v; g_(n 1), ..., g_(n n)) vec(Y^1, ..., Y^n)
$

我们把 Riemann 度量 $g$ 的 tensor 符号略去，可以简记为
$ g=g_(i j)"d"x^i "d"x^j $
还有比如 $"d"theta^2="d"theta tensor "d"theta$.
