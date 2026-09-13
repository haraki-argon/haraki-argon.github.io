#import "../index.typ": template, tufted
#show: template.with(title: "THUREE")
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

= THUREE 网络学堂插件

仅供个人学习使用，对此带来的后果一切由使用者自行承担。

支持的功能：
- 美化界面 + 方便地显示 ddl
- 显示批改作业的结果

若没有正常执行脚本，可能是网络过慢导致未能按预期排列或加载。请刷新页面重试。

使用的方法为油猴（tampermonkey）脚本，请自行学习。

```
// ==UserScript==
// @name         THUREE
// @namespace    http://tampermonkey.net/
// @version      2025-11-9
// @description  实现了清华自动登录、网络学堂ddl显示、新批改作业显示，使用卡片式布局
// @author       haraki
// @match        https://id.tsinghua.edu.cn/do/off/ui/auth/login/form/*
// @match		 https://learn.tsinghua.edu.cn/f/login
// @match		 https://learn.tsinghua.edu.cn/f/wlxt/index/course/student/
// @icon         https://www.google.com/s2/favicons?sz=64&domain=tsinghua.edu.cn
// @grant        none
// ==/UserScript==

const believed_name = ["网络学堂", "信息门户"] // 如果你需要扩大自动登录的范围，注意登录页面的标题，加入该信任名单
const user_account = "请在此处填入你的清华账号" // 你的清华账号用户名
const user_password = "密码" // 你的密码，保存在本地不会泄露
const waiting_time = 300 // 毫秒单位，如果经常不能顺利加载可以尝试调高延迟时间



var read_grade_list = [];

const attach_css = `#selfcourse > div div.hw_not_complete{
    margin-top:5px;
    padding: 0px 0 0 10px;
    line-height:30px;
    background:linear-gradient(90deg,#5c88ac,#70ddc4);
    border-radius: 5px;
    color:#fff;
    cursor: pointer;
}
#selfcourse > div div.hw_not_complete.kyuu{
    background:linear-gradient(90deg,#d21c1c,#ffac66);
}
#selfcourse > div div.hw_not_complete.nakanaka{
    background:linear-gradient(90deg,#e16741,#ffd666);
}
#selfcourse > div div.hw_not_complete.kuruzo{
    background:linear-gradient(90deg,#93b167,#e1c161);
}
#selfcourse > div div.hw_not_complete.heiwa{
    background:linear-gradient(90deg,#5c88ac,#70ddc4);
}
#selfcourse > div div.hw_not_complete span{
    font-size:18px;
    line-height:32px;
    font-weight: bold;
    cursor: pointer;
}
#selfcourse > div div.hw_not_complete p{
    cursor: pointer;
}
#selfcourse > div div.hw_complete{
    padding: 10px 0 0 0;
    color: #5dba8b;
}
#graded_info{
    height:24%;
    width:18%;
    background:#fff;
    position:fixed;
    bottom:0;
    right:0;
    padding:30px;
    border-radius:5px;
    box-shadow:#00000066 0 0 10px;
    border:1px #eee solid;

}
#graded_info ul{
    overflow-y:scroll;
    list-style:none;
    height:calc(100% - 30px);
}
#graded_info li a{
    display: inline-block;
    width:80%;
    color:#1392f1;
    text-decoration: underline;
    transition: color 0.25s;
}
#graded_info li a:hover{
    color:#13c5f1;
}
#graded_info li{
    margin-bottom:5px;
}
#graded_info h2{
    font-size:18px;
    line-height:24px;
    margin-bottom:8px;
    font-weight:bold;
}
#graded_info button{
    cursor:pointer;
}
.hw_info_2{
    height:90px;
    width:100%;
    text-align:center;
    border-radius:5px 0 0 5px;
}
.completed{
    background:#aaacb4;
    color:#ffffffdd;
    font-size:16px;
    line-height:90px;
}
.not_completed h2{
    font-size:18px;
    font-weight:bold;
    color:white;
    padding-top:19px;
    padding-bottom:3px;
}
.not_completed h2 span{
    font-size:30px;
    font-weight:bold;
    margin-right:2px;
}
.not_completed h3{
    font-size:12px;
    color:#ffffffdd;
    line-height:16px;
}
.kyuu{
    background:#d21c1c;
}
.nakanaka{
    background:#e16741;
}
.kuruzo{
    background:#93b167;
}
.heiwa{
    background:#5c88ac;
}

#suoxuecourse > div{
    padding:14px 20px 20px 20px;
}
#suoxuecourse > div > div.fl.cour_right > div.hdtitle.stu > a{
    font-weight:bold;
    font-size:19px;
    padding:2px 0 10px 0;
}
#suoxuecourse > div > div.fl.cour_right > div.state.stu.clearfix ul{
    border-radius:5px;
    border:1px solid #ddd;
}
#suoxuecourse > div > div.fl.cour_right > div.state.stu.clearfix ul li{
    border-radius: 5px;
    border:none;
}
#suoxuecourse > div > div.fl.cour_right > div.state.stu.clearfix ul li:nth-child(1){
    border: none;
}
#suoxuecourse > div > div.fl.cour_right > div.state.stu.clearfix > ul > li a.counte{
    color:#ddd;
}
#suoxuecourse > div > div.fl.cour_right > div.state.stu.clearfix > ul > li{
    padding:0;
    background:#fff;
}
#suoxuecourse > div > div.fl.cour_right > div.state.stu.clearfix > ul > li p{
    padding: 10px 10px 10px 10px;
    background:#ddd;
    border-radius:0px;
    cursor:pointer;

}
#suoxuecourse > div > div.fl.cour_right > div.state.stu.clearfix > ul > li p a{
    font-weight:bold;
    color:#555;
}
#suoxuecourse > div > div.fl.cour_right > div.state.stu.clearfix > ul > li p.rt{
    padding: 0px;
    background:none;
    margin-top:15px;
}
#suoxuecourse > div > div.fl.cour_right > div.state.stu.clearfix > ul > li.aru{
    border-left:3px solid #1392f1;
    border-right:3px solid #1392f1;
    border-bottom:3px solid #1392f1;
}

#suoxuecourse > div > div.fl.cour_right > div.state.stu.clearfix > ul > li.aru p{
    background:#1392f1;

}
#suoxuecourse > div > div.fl.cour_right > div.state.stu.clearfix > ul > li.aru p span{
    color: #ffffffcc;

}
#suoxuecourse > div > div.fl.cour_right > div.state.stu.clearfix > ul > li.aru p a{
    color:#fff;
}
#suoxuecourse > div > div.fl.cour_right > div.state.stu.clearfix > ul > li.aru p.rt{
    background:none;
    margin-top:14px;
}
#suoxuecourse > div > div.fl.cour_right > div.state.stu.clearfix > ul > li.aru p.rt a{
    color:#1392f1;
}
.teacherName{
    padding-bottom:5px;
}
#calendar > h3{
    background:#1392f1;
}
#thuree_panel button.checked{
	background:#1392f1;
	color:#fff;
}
`
if (window.location.href.indexOf("id.tsinghua.edu.cn/do/off/ui/auth/login/") != -1) {
	if (user_account != "请在此处填入你的清华账号") {
		let s = document.querySelector('body > div > div.container.font > div > h3').innerText
		if (s.indexOf("您即将登录") != -1) {
			let believed = false
			believed_name.forEach(x => {
				if (s.indexOf(x) != -1) believed = true
			})
			if (believed) {
				document.querySelector("#i_user").value = user_account
				document.querySelector("#i_pass").value = user_password
				document.querySelector("#theform > div:nth-child(8) > a").click()
			}
		}
	}
}
if (window.location.href.indexOf("/learn.tsinghua.edu.cn/f/login") != -1) {
	document.querySelector("#loginButtonId").click()
}
// 获取指定课程的未交作业
function getUnsubmittedAssignmentsByWlkcid(wlkcid) {
	return new Promise(async (resolve, reject) => {
		try {
			// 获取CSRF token
			let csrf = '';
			for (var imgNode of document.querySelectorAll('img')) {
				csrf = new URL(imgNode.src).searchParams.get('_csrf');
				if (csrf) {
					break;
				}
			}
			if (!csrf) {
				reject(new Error('无法获取CSRF token'));
				return;
			}

			if (!wlkcid) {
				reject(new Error('请提供课程ID (wlkcid)'));
				return;
			}
			// 请求参数
			const requestData = {
				sEcho: 1,
				iColumns: 8,
				sColumns: ',,,,,,,',
				iDisplayStart: 0,
				iDisplayLength: '50', // 获取更多作业
				mDataProp_0: 'wz',
				bSortable_0: false,
				mDataProp_1: 'bt',
				bSortable_1: true,
				mDataProp_2: 'mxdxmc',
				bSortable_2: true,
				mDataProp_3: 'zywcfs',
				bSortable_3: true,
				mDataProp_4: 'kssj',
				bSortable_4: true,
				mDataProp_5: 'jzsj',
				bSortable_5: true,
				mDataProp_6: 'jzsj',
				bSortable_6: true,
				mDataProp_7: 'function',
				bSortable_7: false,
				iSortCol_0: 5,
				sSortDir_0: 'desc',
				iSortCol_1: 6,
				sSortDir_1: 'desc',
				iSortingCols: 2,
				wlkcid: wlkcid,
			};

			// 发送请求
			const response = await fetch(
				`https://learn.tsinghua.edu.cn/b/wlxt/kczy/zy/student/zyListWj?_csrf=${csrf}`, {
					method: 'POST',
					headers: {
						'Accept': 'application/json, text/javascript, */*; q=0.01',
						'Cache-Control': 'max-age=0',
						'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
						'X-Requested-With': 'XMLHttpRequest',
					},
					credentials: 'include',
					referrer: 'https://learn.tsinghua.edu.cn/',
					body: new URLSearchParams({
						aoData: JSON.stringify(
							Object.entries(requestData).map(([name, value]) => ({
								name,
								value
							}))
						),
					}),
				});

			if (!response.ok) {
				throw new Error(`HTTP error! status: ${response.status}`);
			}

			const data = await response.json();

			if (data && data.object && data.object.aaData) {
				const assignments = data.object.aaData;

				// 处理并返回作业数据
				const processedAssignments = assignments.map(hw => {
					const now = Date.now();
					const timeLeft = hw.jzsj - now;
					const daysLeft = Math.floor(timeLeft / 1000 / 60 / 60 / 24);
					const hoursLeft = Math.floor((timeLeft % (1000 * 60 * 60 * 24)) / (1000 * 60 *
						60));
					const minutesLeft = Math.floor((timeLeft % (1000 * 60 * 60)) / (1000 * 60));

					return {
						title: hw.bt,
						publishTarget: hw.mxdxmc,
						completionType: hw.zywcfs === 2 ? '小组作业' : '个人作业',
						startTime: hw.kssjStr,
						deadline: hw.jzsjStr,
						deadlineTimestamp: hw.jzsj,
						lateDeadline: hw.bjjzsjStr || '无',
						lateDeadlineTimestamp: hw.bjjzsj,
						daysLeft: daysLeft,
						hoursLeft: hoursLeft,
						minutesLeft: minutesLeft,
						totalHoursLeft: Math.floor(timeLeft / (1000 * 60 * 60)),
						isOverdue: timeLeft <= 0,
						assignmentId: hw.zyid,
						studentAssignmentId: hw.xszyid,
						courseId: hw.wlkcid,
						rawData: hw,
						viewUrl: `https://learn.tsinghua.edu.cn/f/wlxt/kczy/zy/student/viewZy?wlkcid=${hw.wlkcid}&sfgq=0&zyid=${hw.zyid}&xszyid=${hw.xszyid}`
					};
				});

				// 按截止时间排序（最近的在前）
				processedAssignments.sort((a, b) => a.deadlineTimestamp - b.deadlineTimestamp);

				resolve({
					success: true,
					courseId: wlkcid,
					totalCount: assignments.length,
					assignments: processedAssignments,
					rawData: data,
					timestamp: new Date().toISOString()
				});
			} else {
				resolve({
					success: true,
					courseId: wlkcid,
					totalCount: 0,
					assignments: [],
					message: '没有未交作业',
					timestamp: new Date().toISOString()
				});
			}

		} catch (error) {
			reject(error);
		}
	});
}

// 显示指定课程的未交作业
async function displayUnsubmittedAssignmentsByWlkcid(wlkcid, x) {
	try {
		if (!wlkcid) {
			console.error('请提供课程ID (wlkcid)');
			return;
		}
		const result = await getUnsubmittedAssignmentsByWlkcid(wlkcid);

		if (result.success) {
			if (result.assignments.length > 0) {
				let col;
				if (result.assignments[0].daysLeft >= 10) {
					col='heiwa'
				} else if (result.assignments[0].daysLeft >= 5) {
					col='kuruzo'
				} else if (result.assignments[0].daysLeft >= 2) {
					col='nakanaka'
				} else {
					col='kyuu'
				}
				let hw_href = x.querySelector("ul > li:nth-child(4) > p:nth-child(1) > span.name > a").href
				x.querySelector("div.fl.cour_right > div.state.stu.clearfix > ul > li:nth-child(1)").innerHTML = `
				<div
				class="hw_info_2 not_completed ${col}"
				ddl_time="${Date.parse(result.assignments[0].deadline.replace(" ", "T") + ":00")}"
				onclick="window.open('${hw_href}', '_blank')"
				><h2><span>${result.assignments[0].daysLeft}</span>天</h2><h3>${result.assignments[0].deadline}</h3></div>
				`
				console.log(x)
			} else {
				x.querySelector("div.fl.cour_right > div.state.stu.clearfix > ul > li:nth-child(1)").innerHTML = `
				<div class="hw_info_2 completed" ddl_time="10000000000000">作业已完成</div>
				`
			}

			return result;
		}

	} catch (error) {
		console.error('获取未交作业失败:', error);
	}
}

async function getMultipleCoursesAssignments(wlkcidList) {
	const results = [];

	for (const wlkcid of wlkcidList) {
		try {
			console.log(`正在查询课程 ${wlkcid}...`);
			const result = await getUnsubmittedAssignmentsByWlkcid(wlkcid);
			results.push(result);
		} catch (error) {
			console.error(`查询课程 ${wlkcid} 失败:`, error);
			results.push({
				success: false,
				courseId: wlkcid,
				error: error.message
			});
		}
		// 添加延迟避免请求过快
		await new Promise(resolve => setTimeout(resolve, 500));
	}

	return results;
}

// 等待元素的实用函数
function waitForKeyElements(selector, callback, waitOnce, interval, maxTries) {
	const _interval = interval || 300;
	const _maxTries = maxTries || -1;
	let tries = 0;

	const checker = setInterval(() => {
		if (_maxTries !== -1 && tries >= _maxTries) {
			clearInterval(checker);
			return;
		}

		const elements = document.querySelectorAll(selector);
		if (elements.length > 0) {
			if (waitOnce) {
				clearInterval(checker);
			}
			callback(elements);
		}

		tries++;
	}, _interval);

	// 立即检查一次
	const immediateElements = document.querySelectorAll(selector);
	if (immediateElements.length > 0) {
		if (waitOnce) {
			clearInterval(checker);
		}
		callback(immediateElements);
	}

	return checker;
}

// 获取指定课程的已批改作业
function getGradedAssignmentsByWlkcid(wlkcid) {
	return new Promise(async (resolve, reject) => {
		try {
			// 获取CSRF token
			let csrf = '';
			for (var imgNode of document.querySelectorAll('img')) {
				csrf = new URL(imgNode.src).searchParams.get('_csrf');
				if (csrf) {
					break;
				}
			}

			if (!csrf) {
				reject(new Error('无法获取CSRF token'));
				return;
			}

			if (!wlkcid) {
				reject(new Error('请提供课程ID (wlkcid)'));
				return;
			}

			// 请求参数 - 已批改作业的接口参数
			const requestData = {
				sEcho: 1,
				iColumns: 8,
				sColumns: ',,,,,,,',
				iDisplayStart: 0,
				iDisplayLength: '50',
				mDataProp_0: 'wz',
				bSortable_0: false,
				mDataProp_1: 'bt',
				bSortable_1: true,
				mDataProp_2: 'zywcfs',
				bSortable_2: true,
				mDataProp_3: 'scsj',
				bSortable_3: true,
				mDataProp_4: 'jsm',
				bSortable_4: true,
				mDataProp_5: 'pysj',
				bSortable_5: true,
				mDataProp_6: 'cj',
				bSortable_6: true,
				mDataProp_7: 'function',
				bSortable_7: false,
				iSortCol_0: 3, // 按提交时间排序
				sSortDir_0: 'desc',
				iSortingCols: 1,
				wlkcid: wlkcid,
			};

			// 发送请求到已批改作业接口
			const response = await fetch(
				`https://learn.tsinghua.edu.cn/b/wlxt/kczy/zy/student/zyListYpg?_csrf=${csrf}`, {
					method: 'POST',
					headers: {
						'Accept': 'application/json, text/javascript, */*; q=0.01',
						'Cache-Control': 'max-age=0',
						'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
						'X-Requested-With': 'XMLHttpRequest',
					},
					credentials: 'include',
					referrer: 'https://learn.tsinghua.edu.cn/',
					body: new URLSearchParams({
						aoData: JSON.stringify(
							Object.entries(requestData).map(([name, value]) => ({
								name,
								value
							}))
						),
					}),
				});

			if (!response.ok) {
				throw new Error(`HTTP error! status: ${response.status}`);
			}

			const data = await response.json();

			if (data && data.object && data.object.aaData) {
				const assignments = data.object.aaData;

				// 处理并返回作业数据
				const processedAssignments = assignments.map(hw => {
					// 处理成绩显示
					let score = hw.cj;

					return {
						title: hw.bt,
						completionType: hw.zywcfs === 2 ? '小组作业' : '个人作业',
						submitTime: hw.scsjStr,
						teacher: hw.jsm || '未知老师',
						gradeTime: hw.pysjStr,
						score: score,
						gradeType: score >= 0 ? '分数' : '等级',
						assignmentId: hw.zyid,
						studentAssignmentId: hw.xszyid,
						courseId: hw.wlkcid,
						hasAttachment: !!(hw.zyfjid && hw.zyfjid !== ''),
						rawData: hw,
						viewUrl: `https://learn.tsinghua.edu.cn/f/wlxt/kczy/zy/student/viewCj?wlkcid=${hw.wlkcid}&zyid=${hw.zyid}&xszyid=${hw.xszyid}`
					};
				});

				// 按批改时间排序（最新的在前）
				processedAssignments.sort((a, b) => new Date(b.gradeTime) - new Date(a.gradeTime));

				resolve({
					success: true,
					courseId: wlkcid,
					totalCount: assignments.length,
					assignments: processedAssignments,
					rawData: data,
					timestamp: new Date().toISOString()
				});
			} else {
				resolve({
					success: true,
					courseId: wlkcid,
					totalCount: 0,
					assignments: [],
					message: '没有已批改作业',
					timestamp: new Date().toISOString()
				});
			}

		} catch (error) {
			reject(error);
		}
	});
}

// 显示指定课程的已批改作业
var ginfo;

function append_graded_info() {
	ginfo = document.createElement('div')
	ginfo.setAttribute('id', 'graded_info')
	ginfo.innerHTML = `
	<h2>已批改作业消息</h2>
	<ul></ul>
	`
	document.querySelector('body').appendChild(ginfo)
}

async function displayGradedAssignmentsByWlkcid(wlkcid) {
	try {
		if (!wlkcid) {
			console.error('请提供课程ID (wlkcid)');
			return;
		}

		const result = await getGradedAssignmentsByWlkcid(wlkcid);

		if (result.success) {
			if (result.assignments.length > 0) {
				result.assignments.forEach((hw, index) => {
					if (read_grade_list.indexOf(hw.assignmentId) == -1) {
						let newli = document.createElement('li')
						newli.innerHTML =
							`<a href=${hw.viewUrl} target="_blank">${hw.title}, 成绩：${hw.score}</a><button>已读</button>`
						newli.querySelector('button').addEventListener('click', () => {
							read_grade_list.push(hw.assignmentId)
							localStorage.setItem("haraki_grade_list", JSON.stringify(
								read_grade_list))
							newli.style.display = 'none'
						})
						ginfo.querySelector('ul').appendChild(newli)
					}
				})
			}
		}

	} catch (error) {
		console.error('获取已批改作业失败:', error);
	}
}
if (window.location.href.indexOf("wlxt/index/course/student/") != -1) {
	read_grade_list = JSON.parse(localStorage.getItem("haraki_grade_list")) || []
	changeTabkc('2')
	add_panel()
	waitForKeyElements("#selfcourse > div:nth-child(1)", function(elements) {
		setTimeout(() => {

			append_graded_info()
			let attach_style = document.createElement("style")
			attach_style.innerHTML = attach_css
			document.querySelector('head').appendChild(attach_style)

			let all_katei = document.querySelectorAll("#suoxuecourse > div")
			all_katei.forEach(x => {
				let wlkcid = x.querySelector("input.wlkcid").value
				displayUnsubmittedAssignmentsByWlkcid(wlkcid, x)
				displayGradedAssignmentsByWlkcid(wlkcid)
			})

			document.querySelectorAll("#suoxuecourse > div > div.fl.cour_right > div.state.stu.clearfix > ul > li").forEach(x=>{
				if(x.querySelectorAll('.counte').length>0){
					if(parseInt(x.querySelector('.counte').innerHTML)!=0){
						x.classList.add('aru')
					}
				}
				if(x.querySelectorAll(" span.name > a").length>0){
					x.setAttribute('onclick',`window.open('${x.querySelector(' span.name > a').getAttribute('href')}','_blank')`)
				}
			})

			setTimeout(() => {
				let rnk = []
				for (let i = 0; i < all_katei.length; i++) {
					let ddl = all_katei[i].querySelector(".hw_info_2").getAttribute('ddl_time')
					rnk.push([ddl, i])
				}
				for (let i = 0; i < all_katei.length; i++) {
					for (let j = i + 1; j < all_katei.length; j++) {
						if (parseInt(rnk[i][0]) > parseInt(rnk[j][0])) {
							let temp = rnk[i]
							rnk[i] = rnk[j]
							rnk[j] = temp
						}
					}
				}
				console.log(rnk)
				for (let i = 0; i < all_katei.length; i++) {
					document.querySelector('#suoxuecourse').appendChild(all_katei[rnk[i][1]])
				}
			}, waiting_time)

		}, waiting_time)
	}, true);
}
function add_panel(){
	return;
	//#banner > div > div.left
	let panel_button=document.createElement('button')
	panel_button.innerHTML='THUREE 面板'
	document.querySelector('#banner > div > div.left').appendChild(panel_button)

	let panel=document.createElement('div')
	panel.setAttribute('id','thuree_panel')
	panel.style.display='none'
	panel.innerHTML=`
	<ul>
		<li>
			<p>默认风格</p>
			<button id="show_list" class="checked">列表式</button><button id="show_card">卡片式</button>
		</li>
		<li>
			<p>显示批改作业列表</p>
			<input type="checkbox" id="show_scored" checked="true">
		</li>
		<li>
			<p>显示未处理项目</p>
			<input type="checkbox" id="show_unread" checked="true">
		</li>
		<li>
			<p>Haraki 开发中...</p>
		</li>
	</ul>

	`
	document.querySelector('body').appendChild(panel)
	// panel_button=document.querySelector("#banner > div > div.left>button")
	// panel=document.querySelector("#thuree_panel")
	panel_button.addEventListener('click',()=>{
		if(panel.style.display=='block')panel.style.display='none'
		else if(panel.style.display=='none'){
			panel.style.display='block'
			panel.style.left=panel_button.offsetLeft;
		}
	})
}
```
