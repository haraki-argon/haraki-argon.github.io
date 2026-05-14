//#import "../index.typ": template, tufted
//#show: template
#set text(
  font: (
    (name: "New Computer Modern", covers: "latin-in-cjk"), // 西文字体
    "MS Mincho", // 中文字体
  ),
  lang: "ja",
)
#show math.equation: set text(font: (
  (name: "New Computer Modern Math", covers: "latin-in-cjk"), // 数学
  (name: "MS Mincho", covers: regex(".")), // 中文
))
#show raw: set text(
  font: (
    (name: "New Computer Modern", covers: "latin-in-cjk"), // 西文字体
    "MS Mincho", // 中文字体
  ),
  lang: "ja",
)
#set text(
  size: 13pt,
)
#show heading.where(level: 1): set text(
  font: (
    "TT-NIS平成明朝体W9", // 中文字体
  ),
)
#show heading.where(level: 2): set text(
  font: (
    "TT-NIS平成明朝体W9", // 中文字体
  ),
)
#show heading.where(level: 3): set text(
  font: (
    "TT-NIS平成明朝体W9", // 中文字体
  ),
)
$""$

= 期末試験対応　文法・単語まとめ


はらき
#show math.equation: set text(features: ("cv01",))
#set par(leading: 0.9em)
#show heading.where(level: 1): set block(below: 1em, above: 1em)
#show heading.where(level: 2): set block(below: 1em, above: 1em)
#show heading.where(level: 3): set block(below: 1em, above: 1em)
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

$""$

== 文法

=== よう
接続：形式体言と扱う　意味：比喩・例示・推測

「みたい」と

