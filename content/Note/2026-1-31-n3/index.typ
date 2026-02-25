//#import "../index.typ": template, tufted
//#show: template
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
清華大学第二外国語日本語課程

$""$

= *N3蓝宝书重点自记*

$""$
はらき
#show math.equation: set text(features: ("cv01",))
#set par(leading: 0.9em)
#show heading.where(level: 1): set block(below: 2em, above: 3em)
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

#let leq = $lt.eq.slant$
#let eps = $epsilon$
#let int = $integral$
#let supp = $"supp"$
$""$

1. ～間・間に

  接续类似うち、とき。間接持续性动作，間に接瞬间性动作

2. ～いい・よい

  用法类似～やすい，但表示做起来好，对比壊れやすい。

3. 动词原形+以上（は）

  既然……就……。后句通常表示决心

4. 一方（で）

  一方面……另一方面……，同时。可以对同一事物或者不同事物，可以表示并列或对比。

5. 动词原形+～一方だ。

  越来越……。

6. 上に

  不仅……而且……。

7. ～上で（の）

  ……之后，根据该结果做出某种选择
