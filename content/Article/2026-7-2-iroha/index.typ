//#import "../index.typ": template, tufted
//#show: template.with(title: "iroha")
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
#set enum(numbering: "(イ)(a)")
#let tensor = $times.o$
#let otimes = $times.o$
#show "…": aaa => "..."

Haraki Nihonngo Makura \#02_ Iroha Uta. _
= 伊呂波歌

#align(right, [Haraki 2026/7/12])

#align(right, text(10pt, [预备知识：根据预备知识的不同，可以阅读不同的段落。总之大家都可以试着阅读一下！]))

首先从这样一首歌开始。（读者可以不妨点开这首我推荐的歌曲。由镜音铃演唱）

#box()

#align(center, [*いろはにほへと　ちりぬるを*

  色は匂へど　散りぬるを

  *わかよたれそ　つねならむ*

  我が世誰ぞ　常ならむ

  *うゐのおくやま　けふこえて*

  無為の奥山　今日超えて

  *あさきゆめみし　ゑひもせす*

  浅き夢見し　酔ひもせず])

#box()

这首歌相当古老，时至今日，依然时时被人反复提及。为了深入浅出地介绍它，我想从不同深入的层次来介绍它，部分可能需要一些预备知识，读者可以选择性跳过
这篇文章希望从以下几个角度来介绍いろは歌。


+ 历史假名的演变（ゐ、ゑ的消失、浊点的出现）
+ 伊呂波歌的意味
+ 古日语文法
#pagebreak()
== 历史假名的演变
如果读者对日语略有了解或是学习，可能知道在现代日语中，有如下的「五十音図」（五十音图）：
#align(center, table(
  columns: (auto, auto, auto, auto, auto, auto, auto, auto, auto, auto, auto, auto),
  stroke: none,
  inset: 10pt,
  align: horizon,
  [], [w], [r], [y], [m], [h], [n], [t], [s], [k], [], [],
  [ん], [わ], [ら], [や], [ま], [は], [な], [た], [さ], [か], [あ], [a],
  [], [], [り], [], [み], [ひ], [に], [ち], [し], [き], [い], [i],
  [], [], [る], [ゆ], [む], [ふ], [ぬ], [つ], [す], [く], [う], [u],
  [], [], [れ], [], [め], [へ], [ね], [て], [せ], [け], [え], [e],
  [], [を], [ろ], [よ], [も], [ほ], [の], [と], [そ], [こ], [お], [o],
))
不知道也不要紧，我们在上期介绍了，日语是先有发音，然后借用汉字变化成的假名来表记这些发音。以上的假名就是46个平假名。然而，令人好奇的是，为什么表中会有空缺的内容呢？为什么没有wi,we等发音呢？

事实上，我们可以补完成下面的五十音图：

#table(
  columns: (auto, auto, auto, auto, auto, auto, auto, auto, auto, auto, auto),
  stroke: none,
  inset: 10pt,
  align: horizon,
  [ん], [わ], [ら], [や], [ま], [は], [な], [た], [さ], [か], [あ],
  [], [#text(blue, [*ゐ*])], [り], [#text(blue, [*い*])], [み], [ひ], [に], [ち], [し], [き], [い],
  [], [#text(blue, [*う*])], [る], [ゆ], [む], [ふ], [ぬ], [つ], [す], [く], [う],
  [], [#text(blue, [*ゑ*])], [れ], [#text(blue, [*え*])], [め], [へ], [ね], [て], [せ], [け], [え],
  [], [を], [ろ], [よ], [も], [ほ], [の], [と], [そ], [こ], [お],
)

关于为什么 yi,ye,wu 的表记依然是 い、え、う，我们暂且不在这里讨论。此外，ん 这一列并不能以某种方式填充，因为 ん 是一个相当*特殊*的发音，是鼻音 n，只作为其余发音的延长修饰使用。

我们将主要的好奇放在 ゐ(wi) 和 ゑ(we) 上。在上面的伊吕波歌中，读者可以找一找它们出现在哪里？

想必不用多说，大家都看出来 ゐ 由汉字【為・为】演变而来，很符合我们之前介绍的万叶假名的演变过程。那么，为什么这个假名在现代日语中消失了呢？

