#import "../index.typ": template, tufted
#show: template
#set text(
  font: (
    (name: "New Computer Modern", covers: "latin-in-cjk"), // 西文字体
    "MS Mincho",
  ),
  lang: "ja",
)
#set text(
  size: 12pt,
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

#let leading = 1.25em
#set block(spacing: leading)
#set par(spacing: leading)
#set par(leading: leading)
#show math.equation: set text(features: ("cv01",))
#set par(leading: 0.9em)
#show heading.where(level: 1): set block(below: 1em, above: 1em)
#show heading.where(level: 2): set block(below: 1em, above: 2em)
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
#show strong: set text(
  font: (
    "UD Digi Kyokasho N-B", // 中文字体
  ),
)
#set heading(numbering: "1.イ）")

#show heading: it => {
  if it.level == 1 {
    set align(center)
    it.body
  } else {
    it
  }
}
#text(
  size: 20pt,
  weight: "bold",
  font: (
    "TT-NIS平成明朝体W9", // 中文字体
  ),
  "期末試験対応　文法・単語まとめ",
)

はらき 2026年5月

$""$
#import "@preview/rubby:0.10.2": get-ruby
#let ruby = get-ruby(
  size: 0.5em, // Ruby font size
  dy: 0pt, // Vertical offset of the ruby
  pos: top, // Ruby position (top or bottom)
  alignment: "center", // Ruby alignment ("center", "start", "between", "around")
  delimiter: "|", // The delimiter between words
  auto-spacing: true, // Automatically add necessary space around words
)

= 文法
== #ruby[とお][通]りに
- 接続：予定の#ruby[とお][通]りに、予定#ruby[どお][通]りに、言う#ruby[とお][通]りに

== ようだ・そうだ・らしい・みたいだ

- *ようだ*の接続：形式体言と扱う

  *比喩・例示・推測*（証拠ない）

- *みたいだ*：ようだの口語的な表現、使い方が同じだ

  接続：行くみたい、美味しいみたい、綺麗みたい、雨みたい（直接接続）

- *そうだ*
  - *伝言・噂*：句+そうだ

  - *外見の感想や推測*（証拠ある）・*直前の状況*：

    終わりそう、おいしそう、静かそう、良さそう・なさそう

- *らしい*

  通るらしい、美味しいらしい、静からしい、雨らしい

  - “好像”：客観的な判断、目・耳からの情報により

  #table(
    columns: (1fr, 1fr, 1fr),
    inset: 10pt,
    align: center,
    table.header([], [*情報の取得*], [*関心*]),
    [そうだ], [直接的], [大],
    [ようだ], [直接・間接的], [やや大・中],
    [らしい], [やや間接的], [やや中・小],
  )

  - ある特質：男らしい、子供らしい

== つつある

抽象的な変化の途中、ます形と繋げる：する→しつつある

「ている」も変化の意味があるけど、「瞬間動詞」には：

- 死んでいる：結果・状態の続く

- 死につつある：過程・変化の途中

段々・少しずつ・次第に・徐々に

== 一方
形式体言と扱う。対比の意味。

- ...　一方で、...
- ...。　一方、...

== ことにする・ことになる・ことにしている・ことになっている

- *ことにする*：自分の意思で決める
- *ことになる*：自然にそうなる、他人の意思でそうなる
- *ことにしている*：自分の意思で決めて、習慣化している
- *ことになっている*：社会のルールや習慣

$""$
= 動詞変形
== 使役
+ 書く　→　書かせる

+ 食べる　→　食べさせる

+ する　→　させる、来る　→　#ruby[こ][来]させる

*強制・放任・許可*・（誘発）

行為者の格助詞：に（他動詞）、を（自動詞）

させてください、させてもらう、させていただけきたいんですが、させていただけませんか

$""$
= 単語
#table(
  columns: (1fr, 1fr),
  inset: 10pt,
  align: center,
  [宝くじに当たる], [離婚（りこん）する],
  [火事], [英雄（えいゆう）],
  [ピザ], [真っ赤（か）],
  [採用する], [お腹がすく],
  [ペコペコだ], [梅雨（つゆ）があける],
  [抜ける・抜く], [ジャム],
  [穴があく], [破れる],
  [どうも], [息が合う],
  [いかにも], [アボカド],
  [まぐろ], [襲（おそ）う],
  [通知（つうち）], [お住まい],
  [出し物], [パンク],
  [タイヤ], [アイロンをかける],
  [磨（みが）く], [塾（じゅく）],
  [宗教（しゅうきょう）], [効果的],
  [降ろす], [保険（ほけん）],
  [カタログ], [片付け],
  [畳（たた）む], [帽子掛け],
  [たんす], [乾（かわ）かす],
  [仕舞う], [代返する],
  [虫歯], [分別],
  [葬式], [悪口],
  [スイミングスクール], [ワイシャツ],
  [トレーナー], [ワンピース],
  [プラウス], [パーカー],
  [スカート], [セーター],
  [ベルト], [ストッキング],
  [マフラー], [経緯],
  [お見合い], [引き受ける],
  [モンゴル], [乗り気],
  [方針], [休養],
  [サラリーマン], [どうりで],
  [ガン], [ベジタリアン],
  [地滑り], [家族構成],
  [移転する], [エネルギー],
  [シャワー], [無事],
)

単語は4.20まで、文法は使役受身までまとめた、一旦おいてあろう。
