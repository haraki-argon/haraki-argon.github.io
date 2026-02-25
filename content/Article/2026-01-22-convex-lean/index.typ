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

#set text(
  size: 12pt,
)

#show math.equation: set text(features: ("cv01",))
#set par(leading: 0.9em)
#show heading.where(level: 1): set block(below: 1em, above: 2em)
#show heading.where(level: 2): set block(below: 1em, above: 1em)
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


= 凸分析在Lean/mathlib中的形式化概况
Haraki, 2026/1/23$" "$#footnote[这是2026年冬令营 AI4FormalProofs 的第五日pre的材料.]
= 目录位置和核心文件

*目录位置*： `Mathlib.Analysis.Convex`

*核心文件*

- `Basic.lean` 凸集的定义及相关命题
- `Combination.lean` 凸组合的定义及相关命题
- `Function.lean` 凸、凹函数的定义及相关命题
- `Hull.lean` 凸包的定义及相关命题
- `Topology.lean` 凸集的拓扑性质
- `Segment.lean` 利用凸组合定义线段

= 主要定义

== `Convex` 凸集

用法为 `Convex 𝕜 s`，其中 $bb(k)$ 是凸组合系数所采取的（半环）标量（例如 $RR,QQ$），$s$ 是一个带偏序、加法交换，可以做标量乘法的集合.

定义采取 `starConvex 𝕜 x s` 间接定义，其中 `x` 是集合 `s` 中一点.
星形集的定义是指从点 `x` 到 `s` 内任意一点的线段都包含于 `s` 内.

#align(image("image.png", width: 20%), center)

```lean
def StarConvex (𝕜 : Type*) {E : Type*} [Semiring 𝕜] [PartialOrder 𝕜]
[AddCommMonoid E] [SMul 𝕜 E] (x : E) (s : Set E) : Prop :=
∀ ⦃y : E⦄, y ∈ s → ∀ ⦃a b : 𝕜⦄, 0 ≤ a → 0 ≤ b → a + b = 1 → a • x + b • y ∈ s

def Convex : Prop :=
∀ ⦃x : E⦄, x ∈ s → StarConvex 𝕜 x s
```

== `convexHull` 取凸包（最小凸集）

用法为 `convexHull 𝕜 s`，表示取 `s` 的凸包.

```lean
def convexHull : ClosureOperator (Set E) := .ofCompletePred (Convex 𝕜) fun _ ↦ convex_sInter
```

数学对应：

$ "convexHull"(s) = ⋂ { t | s ⊆ t ∧ t "convex" } $

== `ConvexOn` 凸函数

用法为 `ConvexOn 𝕜 s f`，表示函数 `f` 在集合 `s` 上是凸的. 定义包含两个方面：

- `s` 是凸集 `Convex 𝕜 s`
- 凸组合处函数值小于等于端点函数值的对应凸组合

```lean
def ConvexOn : Prop :=
  Convex 𝕜 s ∧ ∀ ⦃x⦄, x ∈ s → ∀ ⦃y⦄, y ∈ s → ∀ ⦃a b : 𝕜⦄, 0 ≤ a → 0 ≤ b → a + b = 1 →
    f (a • x + b • y) ≤ a • f x + b • f y
```

= 主要定理

== `convex_sInter` 凸集的任意交仍是凸集

```lean
convex_sInter.{u_1, u_2} {𝕜 : Type u_1} {E : Type u_2} [Semiring 𝕜] [PartialOrder 𝕜] [AddCommMonoid E] [SMul 𝕜 E]
  {S : Set (Set E)} (h : ∀ s ∈ S, Convex 𝕜 s) : Convex 𝕜 (⋂₀ S)
```

给出一个集合族，其中每一个都是凸集，那么其交也是凸集.

== `ConvexOn.add, ConvexOn.smul` 凸函数的加法和数乘是凸函数

- `ConvexOn.add`

  ```lean
  ConvexOn.add.{u_1, u_2, u_5} {𝕜 : Type u_1} {E : Type u_2} {β : Type u_5} [Semiring 𝕜] [PartialOrder 𝕜]
  [AddCommMonoid E] [AddCommMonoid β] [PartialOrder β] [IsOrderedAddMonoid β] [SMul 𝕜 E] [DistribMulAction 𝕜 β]
  {s : Set E} {f g : E → β}
  (hf : ConvexOn 𝕜 s f) (hg : ConvexOn 𝕜 s g) : ConvexOn 𝕜 s (f + g)
  ```

  两个凸函数 `f,g` 之和 `f+g` 也是凸函数.

- `ConvexOn.smul`

  ```lean
  ConvexOn.smul.{u_1, u_2, u_5} {𝕜 : Type u_1} {E : Type u_2} {β : Type u_5} [CommSemiring 𝕜] [PartialOrder 𝕜]
  [AddCommMonoid E] [AddCommMonoid β] [PartialOrder β] [SMul 𝕜 E] [Module 𝕜 β] [PosSMulMono 𝕜 β] {s : Set E} {f : E → β}
  {c : 𝕜}
  (hc : 0 ≤ c) (hf : ConvexOn 𝕜 s f) : ConvexOn 𝕜 s fun x ↦ c • f x
  ```

  凸函数 `f` 乘以一个正数依然是凸函数.

== `ConvexOn.map_centerMass_le` 离散/积分版本 Jensen 不等式
- 离散版本 Jensen 不等式
  ```lean
  ConvexOn.map_centerMass_le.{u_1, u_2, u_4, u_5} {𝕜 : Type u_1} {E : Type u_2} {β : Type u_4} {ι : Type u_5} [Field 𝕜]
  [LinearOrder 𝕜] [IsStrictOrderedRing 𝕜] [AddCommGroup E] [AddCommGroup β] [PartialOrder β] [IsOrderedAddMonoid β]
  [Module 𝕜 E] [Module 𝕜 β] [IsStrictOrderedModule 𝕜 β] {s : Set E} {f : E → β} {t : Finset ι} {w : ι → 𝕜} {p : ι → E}
  (hf : ConvexOn 𝕜 s f) (h₀ : ∀ i ∈ t, 0 ≤ w i) (h₁ : 0 < ∑ i ∈ t, w i) (hmem : ∀ i ∈ t, p i ∈ s) :
  f (t.centerMass w p) ≤ t.centerMass w (f ∘ p)
  ```

  要求 `f` 是 `s` 上的凸函数，有一系列大于等于 0 的权重 `w_i`（不全为 0，和至少>0），以及有凸集 `s` 上的一些点 `p_i`，满足：


  $f(sum (omega_i / (sum omega_i)) * p_i) ≤ sum (omega_i /( sum omega_i)) * f(p_i)$

  定理中使用的 `centerMass` 就是加权平均.

- 积分版本 Jensen 不等式

  ```lean
  ConvexOn.map_average_le.{u_1, u_2} {α : Type u_1} {E : Type u_2} {m0 : MeasurableSpace α} [NormedAddCommGroup E]
  [NormedSpace ℝ E] [CompleteSpace E] {μ : MeasureTheory.Measure α} {s : Set E} {f : α → E} {g : E → ℝ}
  [MeasureTheory.IsFiniteMeasure μ] [NeZero μ]
  (hg : ConvexOn ℝ s g) (hgc : ContinuousOn g s) (hsc : IsClosed s)
  (hfs : ∀ᵐ (x : α) ∂μ, f x ∈ s) (hfi : MeasureTheory.Integrable f μ) (hgi : MeasureTheory.Integrable (g ∘ f) μ) :
  g (⨍ (x : α), f x ∂μ) ≤ ⨍ (x : α), g (f x) ∂μ
  ```

  自然语言对应：


  $g((integral f "d" mu) / mu(alpha)) <= (integral g compose f "d" mu) / mu(alpha)$


= 待形式化的内容

- 证明严格凸函数的微分性质
- 平衡集 ($s: forall |lambda|≤1, lambda dot s subset.eq s$) 是星形集
- 星形集的闭包是星形集
- 星形集可缩（单点空间同伦等价）
- 凸集的支撑集
- 定义正凸体，要求内部非空
- 凸体空间的代数运算和其上的 Hausdorff 距离相容

\<p\>test\<\/p\>
