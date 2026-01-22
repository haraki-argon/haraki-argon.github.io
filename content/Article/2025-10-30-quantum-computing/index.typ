#import "../index.typ": template, tufted
#show: template

#set text(
  font: (
    (name: "New Computer Modern", covers: "latin-in-cjk"), // 西文字体
    "Source Han Serif", // 中文字体
  ),
  lang: "zh",
)
#show smartquote: set text(font: "New Computer Modern")
= 量子算法与量子信息-线性代数预备-讲义
#set text(
  size: 12pt,
)
#align(center, [Haraki])
#show math.equation: set text(features: ("cv01",))
#set par(leading: 0.9em)
#show heading.where(level: 2): set block(below: 1em, above: 3em)
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
#set enum(numbering: "(a)")
#let ket(xx) = $|xx chevron.r$
#let bra(xx) = $chevron.l xx|$
#let braket(xx, yy) = $chevron.l xx|yy chevron.r$
== 一、向量空间、向量的记法、基
以下均考虑 $CC$ 上的线性空间，量子力学的基本假设.

向量的记法：ket $ket(v)$. 其伴随向量或者我们之后会表明其共轭转置记作 bra $bra(v)$.

以下记 $square^*$ 为共轭，$square^T$ 为转置，$square^dagger$ 为共轭转置.

=== 线性表出
称 ${ket(v_i)}$ 可以线性表出 $ket(w)$，如果其中有有限个向量 $ket(1),ket(2),...,ket(n)$ 以及 $k_1,...,k_n in CC$ 使得
$ ket(w)=sum_i k_i ket(i) $

=== 线性无关
称 ${ket(v_i)}$ 线性无关，如果其中任意有限个向量 $ket(1),ket(2),...,ket(n)$ 以及 $k_1,...,k_n in CC$ 使得
$ sum_i k_i ket(i)=0 $
那么 $k_i=0,i=1,...,n$.

=== 基、维数
线性无关的一族向量，可以线性表出线性空间中的任一向量.
可以证明线性空间必有一组基，且任两组基的数量相等，记该数量为该线性空间的维数.

以下主要在有限维空间中讨论.

=== 向量在基下的坐标
每个向量 $ket(v)$ 在基 $ket(1),ket(2),...,ket(n)$ 下有唯一的表示：
$ ket(v)=sum_i k_i ket(i) $
我们用列向量 $(k_1,k_2,...,k_n)^T$ 来表示该 ket 的坐标.

=== 线性算子
线性空间 $V,W$ 间的映射 $A:V->W$ 保持线性：
$ A(ket(v)+lambda ket(w))=A ket(v)+ lambda A ket(w) $
注意只要确定基中每个向量映射到哪个向量，线性算子就被确定了.

=== 线性算子的矩阵表示
线性算子 $A:V->W$ 在 $V$ 的基 $ket(v_1),...,ket(v_m)$ 和 $W$ 的基 $ket(w_1),...,ket(w_n)$ 下有：
$ A ket(v_j)= sum_i A_(i,j) ket(w_i) $
称矩阵 $(A_(i,j))$ 是 $A$ 在这两组基下的矩阵表示. 于是可以建立算子和矩阵的一个等同，之后我们会混合使用.

=== 泡利矩阵
#let ii = "i"
$ I=mat(1, 0; 0, 1),X=mat(0, 1; 1, 0), Y=mat(0, -ii; ii, 0),Z=mat(1, 0; 0, -1) $
也对应了一些算子.

== 二、希尔伯特空间
希尔伯特空间是指完备的内积空间.
我们先来讨论内积.

=== 内积
内积是 $V times V -> CC$ 的一个映射 $(dot,dot)$，满足:
- 第二线性性：$(ket(v),ket(w_1)+lambda ket(w_2))=(ket(v),ket(w_1))+lambda (ket(v),ket(w_2))$
- 斜对称性：$(ket(v),ket(w))=(ket(w),ket(v))^*$
- 正定性：$(ket(v),ket(v))>=0$ 且 $(ket(v),ket(v))=0<==>ket(v)=0$
特别地，量子力学中的内积有记法 $(ket(v),ket(w))=braket(v, w)$. 之后我们将会看到这个记法的合理性：在标准正交基下，$ket(v)$ 的列向量表示的共轭转置乘以 $ket(w)$ 的列向量表示（矩阵的乘法），就是 $braket(v, w)$.

=== 正交，范数（模长）
称两个向量 $ket(v),ket(w)$ 正交，如果 $braket(v, w)=0$.

对向量 $ket(v)$ 有范数 $||ket(v)||=sqrt(braket(v, v))$.

=== 标准正交基
一组基 $ket(1),...,ket(n)$ 称为标准正交基如果每个向量模长都为 1 且两两正交.
#let otimes = $times.o$

例：$CC^2$ 中的 $ket(0)=(1,0)^T,ket(1)=(0,1)^T$，$CC^2 otimes CC^2$ 中的四个 Bell states.

=== Gram-Schmidt 正交化

=== 外积表示
$ket(v)bra(w)$ 可以看做是一个算子：$ket(v)bra(w)ket(u):=ket(v)braket(w, u)$ 可以视作一个复数 $braket(w, u)$ 乘以 $ket(v)$.

=== 在标准正交基下的向量坐标
$ket(1),...,ket(n)$ 是一组标准正交基.
$ ket(v)=k_1 ket(1)+dots.c+k_n ket(n) $
作用 $bra(i)$ 得到 $k_i= braket(i, v)$，于是
$ ket(v)=ket(1)braket(1, v)+dots.c+ket(n)braket(n, v) $
这给出了一个显式的坐标表达. 同时得到一个不太显然的*完备性关系*：
$ ket(1)bra(1)+dots.c+ket(n) bra(n)= "Id" $

可以认为 $ket(i)bra(i)$ 是一种投影算符，即 $ket(v)$ 在 $ket(1)$ 上的坐标. 完备性关系说明向量分解到标准正交基可以复原.

投影之后可能会解释到，是一种测量：要测量的物理量的本征态构成一组标准正交基，被测量的量子态 $ket(phi)$ 测量到每个本征态的概率是 $bra(phi)(ket(i)bra(i))ket(phi)$，由完备性关系知概率和为 1.

=== Cauchy-Schwarz 不等式
$ braket(v, w)^2<=braket(v, v)braket(w, w) $

== 本征态和本征值（特征向量和特征值）
对于算子 $A$ 如果有向量 $ket(v)$ 和复数 $lambda$ 满足
$ A ket(v)=lambda ket(v) $
就称为特征向量和特征值. 注意到把特征向量作为一组基中的一个向量的话，在这个方向上的矩阵表示相当简单（对角元）；进一步，如果能找到一整组基都是特征向量，$A$ 的矩阵表示就是一个对角阵. 但这件事未必能做到，但对某些特殊的 $A$ 可以做到！

量子力学的测量假设，即是被测量的量子态的结果是测量算子的本征态.

计算本征值和本征态的办法：$det(A-lambda I)=0$，得到特征值之后解方程.

== 伴随，Hermite（厄米）算子，正规算子，正定算子，酉算子
伴随是指对一个算子 $A$，如果存在 $B$ 满足
$ (ket(v),A ket(w))=(B ket(v),ket(w)) $
称 $B$ 是 $A$ 的伴随，记作 $A^dagger$. 可以证明伴随一定存在，且在标准正交基下的矩阵表示有关系 $M(A)^dagger=M(A^dagger)$.
=== Hermite 算子（自伴算子）——物理可观测量
$A=A^dagger$.

一类典型的 Hermite 算子：投影算子：标准正交基 $ket(1),...,ket(n)$ 在子空间 $"span"{ket(1),...,ket(k)}$ 上的投影 $ket(1)bra(1)+dots.c+ket(k)bra(k)$.

=== 正规算子
$A A^dagger=A^dagger A$. Hermite 和酉算子都是正规算子.

【定理】正规算子 $A$ 可以以一组标准正交基作为其特征向量 $ket(1),...,ket(n)$ 对角化，即谱分解：
$ A=sum lambda_i ket(i) bra(i), A ket(i)=lambda_i ket(i) $

顺便反过来也成立，如果可以对角化，那么正规.

=== 酉算子——封闭量子系统的时间演化
$A A^dagger=I$. 也等价于 $A^dagger A=I$.
- 保距：$braket(v, w)=braket(A v, A w)$
其特征值模长为 1.

=== 正算子——投影、测量、概率
$bra(v) A ket(v)>=0, forall ket(v) in V$.

正算子一定是 Hermite 的，从而有谱分解，且特征值 $>=0$.（证明见附件）


== 张量积
两个向量空间 $V$ 和 $W$ 各有一组基 $ket(v_1),...,ket(v_n)$ 和 $ket(w_1),...,ket(w_m)$. 定义 $V otimes W$ 是由基 $ket(v_i) otimes ket(w_j)$ 张成的空间. 有时候记 $ket(v) otimes ket(w)=ket(v w)$.

对 $ket(v)=sum k_i ket(v_i), ket(w)= sum s_j ket(w_j)$，定义
$ ket(v) otimes ket(w)=sum_(i,j) k_i s_j ket(v_i) otimes ket(w_j) $

即满足结合律. 注意这里 $ket(v_i) otimes ket(w_j)$ 是一个抽象的基，和 $V times W$ 的 $(ket(v),ket(w))+(ket(v'),ket(w'))=(ket(v)+ket(v'),ket(w)+ket(w'))$ 有区别：例如 $1/sqrt(2) (ket(00)+ket(11))$ 是不可以写成简单的 $ket(v) otimes ket(w)$ 的形式. 和纠缠相关.

如果 $V,W$ 是内积空间， $V otimes W$ 上也有一个自然的内积：
$
  (sum a_i ket(v_n_i)otimes ket(w_m_i),sum b_j ket(v_n'_j)otimes ket(w_n'_j))=sum_(i,j)a_i^* b_j braket(v_n_i, v_n'_j)braket(w_m_i, w_m'_j)
$
于是在张量积空间上也有前面所讨论的一些性质.

直接使用 kronecker 积和矩阵表示来说明张量积：

$A_(n times m), B_(p times q),$
$ A otimes B=mat(A_11 B, dots.c, A_(1m) B; dots.v, , dots.v; A_(n 1) B, dots.c, A_(n m) B) $

例如 $ket(0) otimes ket(1)=mat(ket(1); 0)=mat(0; 1; 0; 0)$. 记作 $ket(01)$.

张量积描述了多个量子比特的复合系统状态.



特别说明一个记号：$A^(otimes n)=A otimes dots.c otimes A$, $ket(a)^(otimes n)=ket(a) otimes dots.c otimes ket(a).$

== 算子函数
这里仅对可对角化的正规算子讨论算子函数. 考虑正规算子 $A$ 的谱分解 $A=sum_i lambda_i ket(i)bra(i)$，定义 $f(A)=sum_i f(lambda_i)ket(i)bra(i)$. 取 $f$ 为 $exp,ln,$根号等等可以得到不同的函数.

介绍一个结果：
$ U "unitary" <==> exists K "Hermite", U=exp("i" K) $
这暗示了用酉算子的离散时间动力学描述和用哈密顿量的连续时间动力学描述之间存在一一对应关系.

=== Trace
下面再介绍一个重要的算子函数 $tr$. $V$ 是一个向量空间，基为 $ket(1),...,ket(n)$，$A:V->V$ 是一个算子. 定义
$ tr(A)=bra(1) A ket(1)+dots.c+bra(n) A ket(n) $

即在该组基下矩阵表示对角元之和. 可以证明 $tr$ 是线性的，且 $tr(A B)=tr(B A)$ 进而在不同基下有相同的基 $tr(A)=tr(P A P^(-1))$.

== 对易和反对易
=== 对易子
$ [A,B]=A B-B A $
$[X,Y]=2"i"Z; [Y,Z]=2"i"X; [Z,X]=2"i"Y.$
=== 对易的正规算子可以同时以公共特征向量标准正交基对角化
=== 反对易子
$ {A,B}=A B+B A $
${X,Y}={Y,Z}={Z,X}=0.$

== 极分解，奇异值分解
=== 极分解
设 $A$ 是向量空间 $V$ 上一个线性算子，那么存在酉算子 $U$ 和正算子 $J,K$ 使得
$ A=U J=K U $
其中 $J=sqrt(A^dagger A),K≡sqrt(A A^dagger)$,并且J和K是唯一满足这些等式的正算子.

且若 A 可逆，U唯一.
=== 奇异值分解
$A$ 是一个方阵，那么存在酉矩阵 $U$ 和 $V$，以及非负对角阵 $D$ 使得
$ A=U D V $
$D$ 的对角元素称为 $A$ 的奇异值.
