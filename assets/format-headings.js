var hitokotoList = [
    {
        "content": "彼女のための楽園は、ああ脆くも儚く崩れてく。",
        "from": "『悪ノ娘』"
    },
    {
        "content": "運命の分かつ、哀れな双子",
        "from": "『悪ノ召使』"
    },
    {
        "content": "魔法が解ける、それまで、繋いでいてよ、手を、手を、手を",
        "from": "『テオ』"
    },
    {
        "content": "ラルラリ 唱えろ 生",
        "from": "『ブリキノダンス』"
    },
    {
        "content": "迂闊に今夜も極度に素敵なこれが大！大！大！大！大・天・才！",
        "from": "『ドクター＝ファンクビート』"
    },
    {
        "content": "可愛 可愛 幻 一定再見",
        "from": "『クーロンズ・ホテル』"
    },
    {
        "content": "いろはにほへと　ちりぬるを",
        "from": "『いろは唄』"
    },
    {
        "content": "わかよたれそ　つねならむ",
        "from": "『いろは唄』"
    },
    {
        "content": "うゐのおくやま　けふこえて",
        "from": "『いろは唄』"
    },
    {
        "content": "あさきゆめみじ　ゑひもせす",
        "from": "『いろは唄』"
    },
    {
        "content": "絡まって解いてを輪廻する愚者の群。",
        "from": "『キティ』"
    },
    {
        "content": "独りで愛し、愛されて居たい。",
        "from": "『キティ』"
    },
    {
        "content": "確かな愛が視たいなら 音に成って 今 逃げ出して！",
        "from": "『キティ』"
    },
    {
        "content": "此の歌が間違いでも構わないわ。声 を枯らして！",
        "from": "『キティ』"
    },
    {
        "content": "掻鳴らせ、ブルウスドライバ・アンド・テレキャスタ。",
        "from": "『キティ』"
    },
    {
        "content": "不都合等蹴飛ばして，銘々に踊れや。One, Two, Three, Four!",
        "from": "『キティ』"
    },
    {
        "content": "優しい人にならなくちゃ 僕は僕を肯定していたい",
        "from": "『How to 世界征服』"
    },
    {
        "content": "優しい人にならなくちゃ 心が悴む前に",
        "from": "『How to 世界征服』"
    },
    {
        "content": "ああ、愛も恋も化学式の中の幻",
        "from": "『天才ロック』"
    },
    {
        "content": "また ゆら ゆら ひゅらら あたしは誰？ 身は違うのに 化かし合うのは 誰が為の番狂わせ?",
        "from": "『見呉行進曲』"
    },
    {
        "content": "はなまる よくできまちた☆",
        "from": "『おこちゃま戦争』"
    },
    {
        "content": "退屈な everyday よリも 誰も知らないフレ一ズで 常に戦闘モ一ド思想  市場は メ一デ一",
        "from": "『バリィ』"
    },
    {
        "content": "誰かの願いに命は宿る 一年に一度きりの冬の魔法 動きだす僕はスノーマン",
        "from": "『スノーマン』"
    },
    {
        "content": "「そばにいたいよ」",
        "from": "『スノーマン』"
    },
    {
        "content": "どんな冬にだってさ 春は訪れるから",
        "from": "『スノーマン』"
    },
    {
        "content": "「夢 希望が賞味期限があるのよ」",
        "from": "『アンチウー』"
    },
    {
        "content": "山があったら谷もあんだわ だったらMore and More",
        "from": "『アンチウー』"
    },
    {
        "content": "人類最後に愛を持ったって 僕に居場所はないでしょうか",
        "from": "『スロウダウナー』"
    },
    {
        "content": "僕は最上最愛の この世界に産み落とされたモンスター",
        "from": "『スロウダウナー』"
    },
    {
        "content": "you raise me up 重なり合う手と手は続く",
        "from": "『陽だまりのセツナ』"
    },
    {
        "content": "今 相対した感情 いつものように 貴方を抱きしめたいと 思う 思う 思うよ",
        "from": "『ヘッジホッグ』"
    },
    {
        "content": "僕の心はエゴロック 斜め45度ナンセンス",
        "from": "『エゴロック』"
    },
    {
        "content": "僕ら 馬鹿になって 宙を待って 今だけは忘れてラッタッタ",
        "from": "『ナンセンス文学』"
    }
]

document.addEventListener('DOMContentLoaded', function () {
    // 选择所有级别的标题
    const headings = document.querySelectorAll('h1, h2, h3, h4, h5, h6');

    headings.forEach(el => {
        processNode(el);
    });

    function processNode(node) {
        if (node.nodeType === 3) { // 3 代表文本节点
            const text = node.nodeValue;

            // 如果包含 ASCII 字符 (英文、数字、半角标点)
            if (/[\x00-\x7F]/.test(text)) {
                const fragment = document.createDocumentFragment();
                let lastIndex = 0;
                // 正则：匹配连续的 ASCII 字符
                const regex = /[\x00-\x7F]+/g;
                let match;

                while ((match = regex.exec(text)) !== null) {
                    // 1. 添加匹配前的中文文本
                    if (match.index > lastIndex) {
                        fragment.appendChild(document.createTextNode(text.substring(lastIndex, match.index)));
                    }

                    // 2. 添加匹配到的英文文本，包裹 span
                    const span = document.createElement('span');
                    span.className = 'heading-en';
                    span.textContent = match[0];
                    fragment.appendChild(span);

                    lastIndex = regex.lastIndex;
                }

                // 3. 添加剩余的文本
                if (lastIndex < text.length) {
                    fragment.appendChild(document.createTextNode(text.substring(lastIndex)));
                }

                // 用新的片段替换原来的文本节点
                node.parentNode.replaceChild(fragment, node);
            }
        } else if (node.nodeType === 1) { // 1 代表元素节点 (如 h2 里的 a 标签)
            // 递归处理子节点
            Array.from(node.childNodes).forEach(processNode);
        }
    }


});
//首页hitokoto 刷新系统
window.onload = function () {
    let hitoElem = document.querySelector("body > article > section > p");
    if (hitoElem.innerHTML == "hitokoto") {
        let u = hitokotoList[Math.floor(Math.random() * hitokotoList.length)]
        hitoElem.innerHTML = u.content + "<br>" + '<p style="color: #999;">——' + u.from + "</p>";
    }
}