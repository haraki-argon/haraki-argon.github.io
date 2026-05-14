#import "../index.typ": template, tufted
#show: template.with(title: "量子电路")
#import "@preview/theorion:0.4.1": *

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

_Quantum computation and quantum information_
= Section 4. Quantum circuits

#align(right, [Haraki 2026/5/13])

#let bra(xx) = $chevron.l xx|$
#let ket(xx) = $|xx chevron.r$

$$

`I would give a brief introduction to quantum circuits, containing the part 4.1-4.4 of the book, mainly about the controlled gates and measurement.`

$$

量子计算机可以使用更少的资源来完成某些计算任务. 目前核心的算法分为Shor的量子Fourier变换算法和Grover的搜索算法，可以解决例如离散对数、因式分解、统计数值搜素等等问题，对密码学有重要影响. 我们将在之后的章节里再进一步讨论量子算法的设计，这通常相当困难.

我们先来考虑如何表示和设计简单的量子算法.

量子电路是量子计算的一个重要模型，类似于经典计算中的布尔电路。量子电路由量子比特和量子门组成，可以用来描述量子算法的实现过程。

我们先回忆一些基本的假设和记号.

一个量子比特形如 $a""ket(0)+b""ket(1)$，其中 $a,b in CC$ 且 $abs(a)^2+abs(b)^2=1$.
一个量子门是一个酉算子，其中最重要的是三个 Pauli 门：
$ X=mat(0, 1; 1, 0), Y=mat(0, -"i"; "i", 0), Z=mat(1, 0; 0, -1) $
还有一些重要的门，例如 Hadamard 门和 T 门：
$ H=1/sqrt(2) mat(1, 1; 1, -1), T=mat(1, 0; 0, exp("i"pi \/4)). $
下面我们来介绍基本的受控门.

考虑一个简单的问题：我们希望通过判断一个量子比特的状态来修改另一个量子比特的状态. 我们称前者为控制比特(control qubit)，后者为目标比特(target qubit).

一个最简单的例子是 CNOT.
$ mat(1, 0, 0, 0; 0, 1, 0, 0; 0, 0, 0, 1; 0, 0, 1, 0) $
这表示如果控制比特为 $ket(0)$ 则目标比特不变，如果控制比特为 $ket(1)$ 则目标比特进行 X 门操作.
我们用如下的记号表示
#align(center, image("pic1.png"))
上面的圆是实心的，表示判断条件为 $ket(1)$ 则执行下方的 $X$ 门. 我们将 $X$ 画为 $plus.o$ 因为这与经典电路的 XOR 门类似，也一定意义上符合二进制加法 $0+1=1,1+1=0$.

那么，我们可以很简单地设计出要求控制比特的状态为 $ket(0)$ 的门：只需要向上方添加两个 $X$ 门反转控制比特的状态即可.
#align(center, image("pic2.png"))

进一步，我们还可以设计多个控制比特控制单个目标比特的门，例如 Toffoli 门：
$
  mat(1, 0, 0, 0, 0, 0, 0, 0; 0, 1, 0, 0, 0, 0, 0, 0; 0, 0, 1, 0, 0, 0, 0, 0; 0, 0, 0, 1, 0, 0, 0, 0; 0, 0, 0, 0, 1, 0, 0, 0; 0, 0, 0, 0, 0, 1, 0, 0; 0, 0, 0, 0, 0, 0, 0, 1; 0, 0, 0, 0, 0, 0, 1, 0)
$
可以表示为#align(center, image("pic3.png", width: 17%))
同样可以讨论一个控制比特控制多个目标比特的门，例如一个控制比特控制两个目标比特的门：
#align(center, image("pica.png", width: 70%))

前面我们研究的都是简单的受控操作 $X$，我们希望考虑一般的酉矩阵 $U$ 的受控版本
$ ket(0)bra(0) tensor I + ket(1)bra(1) tensor U $
并用基本的一些门来实现它，这有利于实验中的实现.

我们先给出一个定理.

#theorem[
  设 $U$ 是一个单量子比特上的酉算子，则存在个单量子比特上的酉算子 $A,B,C$ 满足
  $ A B C =I, U= e^(i alpha) A X B X C $
  其中 $alpha in RR$ 表示 $e^(i alpha)$ 是 $U$ 的相对相位（$A,B,C in S U(2)$ 是简单的一些旋转）
]

这个证明比较复杂，我们先跳过证明的细节，直接看定理的应用.

由此我们可以设计出一般的受控 $U$ 门：

#align(center, image("pic4.png"))

我们可以看到，在控制比特为 $ket(0)$时，上侧的控制门不会触发，下面目标比特经历 $A B C=I$ 不变，符合控制 $U$ 的定义；在控制比特为 $ket(1)$ 时，上侧的控制门会触发，然后下侧目标比特经历 $A X B X C$，按照我们的定理其几乎就是 $U$. 然而两者差一个相位 $e^(i alpha)$，我们要如何实现呢？

我们希望有一个控制门来实现 $ket(0)|-> I, ket(1) |-> e^(i alpha)$. 这可以直接通过对控制比特进行 $mat(1, 0; 0, e^(i alpha))$ 来实现，因为
$ ket(0) bra(0) tensor I+ ket(1) bra(1) tensor e^(i alpha) I = (ket(0)bra(0) + e^(i alpha)ket(1)bra(1)) tensor I $
这反映出我们可以通过在控制比特上进行一个相位旋转来实现受控 $U$ 门的相位变化！这其实是一种非常重要的技巧，称为相位提升（phase kickback），在量子算法设计中经常使用.

回到上面图片中，由于我们在控制比特上进行了 $mat(1, 0; 0, e^(i alpha))$ 的操作，这个相位提升就会发生，使得当控制比特为 $ket(1)$ 时，目标比特经历的操作实际上是 $e^(i alpha) A X B X C$，正好是我们需要的 $U$.

下面我们来讨论 Toffoli 门的简单实现. 首先对于一般的2控1-$U$ 电路（这是我起的名字），设 $V^2=U$ 是 $U$ 的平方根，那么我们可以设计如下的电路：
#align(center, image("pic5.png"))
这是一个很有趣的电路！
- 当控制比特为 $ket(00)$ 时，什么控制都不触发，最下不变；
- 当控制比特为 $ket(01)$ 时，只有中间线路的控制门触发，目标比特经历 $V^dagger V=I$；
- 当控制比特为 $ket(10)$ 时，只有上面线路的控制门触发，这会使得中间的两个 CNOT 触发. 在第二条线路最开始为 $ket(0)$，经历一次变为 $ket(1)$，然后触发 $V^dagger$，然后又 CNOT 变为 $ket(0)$；注意最上面的最后一个控制门使得目标比特再受一次 $V$ 的作用，所以目标比特经历 $V V^dagger V=I$；

- 当控制比特为 $ket(11)$ 时，我懒得写了，但你可以自己验证一下，目标比特经历 $V^2=U$.

经过计算我们得到 $X$ 的平方根为 $V=(1-i)(I+i X)\/2$，那么我们是不是直接塞进去就可以了呢？但是我们希望只使用基本的一些门来实现尽可能多的电路，就像数理逻辑中 $or$ 和 $and$ 可以实现任意的布尔函数（合取、析取命题）、经典电路中 NAND 门（或者说 Toffoli 门）可以实现任意的布尔函数一样，我们希望有一些基本的量子门来实现任意的量子电路. 事实上，Hadamard 门，T 门，CNOT 门就足以以任意精度逼近任意量子门. 这在之后的章节会介绍到.


总而言之，书中提供了这样一个用 基本门实现 Toffoli 门的电路：
#align(center, image("pic6.png"))
其中 $S=T^2$ 也被称为 phase 门.
这个电路的正确性验证比较麻烦，我们不在这里展开了.

最后，只要参考 Toffoli 门的经典电路性质，我们就可以构造出任意多控制比特控制一个目标比特 $U$ 门的电路了！这是很容易的，只要想到数学中多元的运算事实上是拆分为多次的二元运算：

#align(center, image("pic7.png"))

下面我们来讨论测量. 书94页（2.2.8,pdf 112 页）证明了一般的测量算子等效于一个酉变换+投影测量. 因此我们只需要讨论标准投影测量就可以了.

这引导出两个重要的测量的基本原理：

*测量可以放在电路的最后*. 我们之前在 Alice Bob 传信的例子中用了这样一个电路：
#align(center, image("pic8.png"))
其中要求测量 $M_1$ 和 $M_2$ 后决定最下层门的操作. 但是我们可以把测量变为酉变换和控制门（判断操作），进行相应的操作后再测量，这样就把测量放在了电路的最后：
#align(center, image("pic9.png"))
第二个原理是
*可以假设在电路的末尾，我们对所有的量子比特进行测量*. 保障这一原理成立的关键是测量其他量子比特但不去知道其结果，并不会影响我们对目标量子比特的测量结果.

习题 4.3.2 给出了一个例子：设 $rho$ 是两个量子比特的密度矩阵，有两个对第二个量子比特的投影测量 $P_1=I tensor ket(0)bra(0), P_2=I tensor ket(1)bra(1)$. 假设一个观测者测量了第二个量子比特但不知道结果，那么其得到的新的密度矩阵为（见书100页，pdf 128 页，2.4.1节末尾）
$
  rho'=sum_i p(i) rho_i = sum_i tr(P_i rho P_i^dagger) (P_i rho P_i^dagger)/(tr(P_i rho P_i^dagger))= sum_i P_i rho P_i^dagger
$
也就是
$ rho'=P_1 rho P_1^dagger + P_2 rho P_2^dagger $
我们考虑其在第一个量子比特上的约化密度矩阵
$
  tr_2(rho') & = tr_2(P_1 rho P_1^dagger + P_2 rho P_2^dagger) \
             & =tr_2(P_1^2 rho)+ tr_2(P_2^2 rho) \
             & = tr_2(P_1 rho)+ tr_2(P_2 rho) \
             & = tr_2((P_1+P_2) rho) \
             & = tr_2(rho)
$
这表明测量第二个量子比特但不知道结果，并不会改变第一个量子比特的状态.

这样隐式地测量其余的量子比特避免了最后残余未被测量的量子比特进行后续发展，对系统产生干扰，封闭整个电路系统形成整体模块.

*补充* 关于 $A X B X C$ 分解的证明

首先我们定义三个旋转算子
$
  R_x (theta)=e^(-i theta X/2)=mat(cos(theta/2), -i sin(theta/2); -i sin(theta/2), cos(theta/2))\
  R_y (theta)=e^(-i theta Y/2)=mat(cos(theta/2), -sin(theta/2); sin(theta/2), cos(theta/2))\
  R_z (theta)=e^(-i theta Z/2)=mat(e^(-i theta/2), 0; 0, e^(i theta/2))
$
之所以是 $x,y,z$ 和“旋转”这样比较看起来像是在三维空间中的球面操作，是因为我们可以把量子比特看成是 Bloch 球面上的一个点：$a ket(0)+b ket(1)$ 其中 $a=cos(theta/2),b=e^(i phi) sin(theta/2)$. 我们取 $a, theta in RR$ 因为相位不可观测. 这样其对应 $(cos phi sin theta, sin phi sin theta, cos theta)$ 称为 Bloch 向量.


我们需要关注，酉演化作为 $S U(2)$ 群的元素，其与 $S O (3)$ 有着二重覆叠关系.


不写了
