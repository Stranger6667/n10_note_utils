# 读书笔记处理程序

## 现有笔记功能的问题

1. 摘抄出来的文本乱糟糟的
   * 一段话被分成了多行
   * 中文之间或英文单词之间有多余的空格
   * 标点使用不规范
2. 截图和文本是分开的
3. 摘抄的顺序问题
   * 一般有两种排序：
     1. 按摘抄在书中的出现顺序排序
     2. 按摘抄的时间顺序排序
   * 这两种排序都有不尽如人意的地方：
     * 按出现顺序排序的问题：有时我们希望将相关的内容摘抄在一起，按出现顺序排序无法做到这点
     * 按时间顺序排序的问题：如果我们在第N页摘抄了一些文本，然后读到了N+3页，突然想到第N页有漏掉的，就返回到第N页。这种情况下，按时间排序会打乱我们的想法
     * 有时，我们希望把相关的内容聚合在一起，而不是简单的按页或按时间排序

## 各电纸书笔记功能的问题与特色

### 问题

墨水屏的**刷新率太慢**，从而导致很多操作非常不方便

* 打字不方便，一分钟打不了几个字
* 文本编辑不方便：操作起来太慢了

因此，将笔记导出到电脑上处理是唯一的选择，但这会引发其他一些问题：

* 即时性问题：想法稍纵即逝，有些操作必须要在记笔记的同时及时的完成，导出到电脑之后再处理，可能就想不起来了

### 特色

一般来说，各电纸书的笔记有以下来源:

1. 摘抄文件或是笔记导出文件，这里面有原始的摘抄，也有打开摘抄文件后自已写的想法等
2. 截图，截图来源：
    1. 屏幕截图
    2. 手写笔记导出为图片
3. 手写笔记OCR识别为文本

各家电纸书又稍有不同，各有优缺点：

* 直接摘抄类，选中的文本可以直接摘抄到文本文件，不需要事后导出。典型的是汉王N10
  * 如果要写自已的想法，需要从菜单中打开摘抄文件进行编辑
  * 优点：能随时修改笔记**原文**，这就给了我们使用**markdown**语法来标记一些重点词、保留原文中的列表之类的格式化文本
  * 缺点：随着笔记文件内容越来越多，如果**过了一段时间后**想针对某个摘抄写自已的想法，很难定位到相应的原文
    * **即时**想法不受影响，即时想法能立即打开摘抄文件写下来
    * **非即时**想法可以通过按页排序来减小影响
* 笔记导出类，这类一般是读书时做标志，如高亮、下划线、标注等，读完书后需要手工做导出操作：
  * 优点：在原文上做标注更精准，笔记再多也不影响
  * 缺点：原文却无法修改，有些事是标注做不到的，比如标志一些重点词、保留原文中的列表之类格式化文本

个人认为汉王N10的直接摘抄提供了更多的自由，一般情况下我们都是写即时想法多些，N10的缺点实际影响不大

### 汉王N10笔记功能的问题

摘抄内容越积越多时，打开摘抄文件，没有自动定位到文件最后，不方便编辑

这个问题可以通过安装百度输入法或是搜狗输入法解决

以百度输入法为例，在键盘上方的工具栏里看到一个`<I>`这样的工具按钮，点进去，里面有跳到文件开始和结尾的按钮

## 我的读书笔记处理程序

程序的目的就是尽量提供相关的功能来减轻在电纸书上的操作负担

### 程序的功能

* 解析电纸书的摘抄文件或者是笔记导出文件
  * 目前只支持汉王N10，因为我没有别的电纸书
* 多行文本智能合并: 能识别markdown，依据commonmark markdown语法进行智能多行合并
* 文本规范化: 智能处理空格、标点等，markdown规范
* 合并图片和文本：按时间顺序，将图片插入到markdown文件的特定位置
* 手写OCR文本合并: 也是按时间顺序，这需要在手写笔记时手工写上时间标志
* 更自由的笔记排序:
  * 智能排序:
    * 按时间排序+按页排序: 在按时间排序的基础上，将相同页码的笔记聚合到一起，从而允许在读到第N+n页后，返回第N页摘抄漏掉的笔记
    * 内容跟随(`[]:+`): 方便将相关的内容聚合在一起，不受时间、页码的影响
    * 内容固定(`[]:.`：在按时间排序的基础上，允许某些内容不受按页排序的影响
  * 插入和替换：手工指定特定文本的位置，之所以有这个功能，是因为在电纸书上拷贝粘帖、删除**大量**文本太麻烦了
    * 插入：将某个摘抄插入到其他的任意位置
    * 替换：使用一个新的摘抄替换掉某个不想要的摘抄
* 删除某个摘抄(`[]:-`)
* 删除摘抄中的某些文本: 使用language为`delete`的fenced block
* PC端的摘抄监控程序
  * 支持多来源混合笔记: 从多个文件，甚至是从网页摘抄笔记
* 其他辅助功能

后面会对一些功能进行详细说明

### 程序的输出形式

程序会生成markdown和html两种格式的文本

* XXX.md: 这个md文件是markdown格式的处理后的文件
* XXX.html: 这是渲染出的网页文件
  
如果你喜欢markdown，可以打开md文件进行编辑。

程序还会将markdown和html**放入剪贴板**，如果你想导入到笔记软件或word中，并且保留加粗/斜体/列表等格式，你可以直接打开笔记软件，粘贴即可

### 内容跟随

使用`[]:+`标志，在N10的摘抄文件中，这个标志必须紧跟抬头行单独一行，示例如下

```text
2022年10月04日 12:51:08  摘自<<Psychology and Life 20th.pdf>> 第196页
aaa

2022年10月04日 12:51:08  摘自<<Psychology and Life 20th.pdf>> 第600页
[]:+
bbb
```

有了`[]:+`标志，bbb会一直跟随aaa，哪怕是插入或替换，也会一直跟着aaa

### 内容固定

使用`[]:.`标志，在N10的摘抄文件中，这个标志必须紧跟抬头行单独一行，示例如下

```text
2022年10月04日 12:51:08  摘自<<Psychology and Life 20th.pdf>> 第196页
aaa

2022年10月04日 12:51:08  摘自<<Psychology and Life 20th.pdf>> 第197页
bbb

2022年10月04日 12:51:08  摘自<<Psychology and Life 20th.pdf>> 第196页
[]:.
ccc
```

如果没有`[]:.`标志，ccc会因为按页排序排到aaa后面，有了固定标志后，就不受按页排序的影响了

### 摘抄删除

使用`[]:-`标志，在N10的摘抄文件中，这个标志必须紧跟抬头行单独一行，示例如下

```text
2022年10月04日 12:51:08  摘自<<Psychology and Life 20th.pdf>> 第196页
aaa

2022年10月04日 12:51:08  摘自<<Psychology and Life 20th.pdf>> 第197页
[]:-
bbb

2022年10月04日 12:51:08  摘自<<Psychology and Life 20th.pdf>> 第196页
ccc
```

上面的bbb会被删除，不会出现在最终的markdown文件中

### 删除部分文本

使用language为`delete`的fenced block, 示例如下:

`````text
aaa

```delete
这些
内容
是要
删除的
```
bbb
`````

### 插入和替换

适用于以下场景：

> 当简单的页码排序不满足你的要求时，比如你想将后摘抄的内容插入前面摘抄内容的某个位置，或者完全替换掉某个摘抄

**插入**功能使用方法如下

* 如果想把某一次摘抄插入到别的位置，则在这个摘抄的抬头行后第一行添加一个`[placeholder]:.`标志，其中的placeholder名字可以任意取
* 在`插入点`添加`[placeholder]`

下面的例子中，c和d会插入到a的的后面

```text
2022年10月04日 09:58:38  摘自<<Psychology and Life 20th.pdf>> 第176页
aaaaaaaaaa
[placeholder]

2022年10月04日 10:01:12  摘自<<Psychology and Life 20th.pdf>> 第176页
bbbbbbbbbb

......
......

2022年10月04日 13:00:27  摘自<<Psychology and Life 20th.pdf>> 第178页
[placeholder]:.
ccccccccc

ddddddddd
```

替换功能使用方法如下

* 如果想把某一次摘抄替换到别的位置，则在这个摘抄的抬头行后第一行添加一个`[placeholder]:.`标志，其中的placeholder名字可以任意取
* 在需要被替换掉的摘抄的抬头行后第一行添加`[placeholder]:-`

下面的例子中，a和b的内容会完全替换掉x和y的内容

```text
2022年10月04日 09:58:38  摘自<<Psychology and Life 20th.pdf>> 第176页
[placeholder]:-
xxxxxx

yyyyyy

2022年10月04日 10:01:12  摘自<<Psychology and Life 20th.pdf>> 第176页
zzzzzz

......
......

2022年10月04日 13:00:27  摘自<<Psychology and Life 20th.pdf>> 第178页
[placeholder]:.
aaaaaaa

bbbbbbb
```

### PC端的摘抄功能

脚本中还有一个notes_monitor.py，在PC端模拟了汉王N10的摘抄功能，生成的摘抄文件和汉王N10是一致的，可以使用脚本的其他功能解析

因为不能像电纸书那样获取摘抄时的文件名和页码，程序使用了tesseract进行OCR，文件名和页码的OCR区域需要在settings.json中指定

```json
"foxit_filename_region": "34, 0, 2641, 48",
"foxit_page_number_region": "104, 1858, 299, 1896",
"adobe_filename_region": "586, 0, 2641, 48",
"adobe_page_number_region": "782, 183, 1021, 223"
"temp_notes_dir" : "D:\\temp\\notes",
"tesseract_cmd" : "C:\\Program Files\\Tesseract-OCR\\tesseract.exe"
```

region的指定格式为: left, top, right, bottom

上面还有两个设置项:

* temp_notes_dir: 摘抄和截图保存目录
* tesseract_cmd：tesseract.exe的位置

脚本会监控剪贴板，因此一般情况下只需要使用`Ctrl+C`拷贝，就能自动拼到摘抄文件里

对于剪贴板里的图片文件，会保存为png图片文件

辅助的ahk快捷键如下:

* CapsLock & 1:: 将文本拷贝为markdown level 1 header(#)
* CapsLock & 2:: 将文本拷贝为markdown level 2 header(##)
* CapsLock & 3:: 将文本拷贝为markdown level 3 header(###)
* CapsLock & 4:: 将文本拷贝为markdown level 4 header(####)
* CapsLock & 5:: 将文本拷贝为markdown level 5 header(#####)
* CapsLock & 6:: 将文本拷贝为markdown level 6 header(######)
* CapsLock & n:: 启动notes_monitor.py

### 其他辅助功能

* **CapsLock & c**: 将剪贴板中的文本转为纯文本
* **CapsLock & v**: 将剪贴板中文本规范化后再进行粘贴
* **CapsLock & d**: 对选中的文本查找GodenDict词典
  * 注：事先需要将GodenDict的查词hotkey改为`Ctrl+Alt+Shift+C`

### 手写笔记手写时间格式

手写时间戳的时候，经过识别出来的格式要是下面这个样子的

```txt
2022.9.14-13:56
```

* 年：4位数字
* 月：1~2位数字
* 日：1~2位数字

年月日用英文点(.)分隔

* 时：1~2位数字，要使用24小时制
* 分：1~2位数字
  
时分用英文冒号(:)分隔

年月日 和 时分 之间用短横(-)分隔

## 程序安装

程序使用Python编写，放在github上，可以从下面的位置获取，

<https://github.com/lutts/n10_note_utils>

* 如果你是程序员，安装了git，直接git clone即可
* 如果你不是程序员，可以下载zip打包文件

运行脚本所需要的环境：python 3

### python 3

如果你不是程序员，建议从Microsoft Store安装，安装完后就可以用了，不需要其他手工设置，方法如下

1. 打开Microsoft Store
2. 搜索`python`
3. 安装最新的版本，写这篇文章时是3.10，如下图所示，注意不要安装带(RC)字样的版本

![python_install](img/microsoft_store_python.png)

安装完python后，还要安装程序依赖的一些程序包，

打开windows命令行或是PowerShell，依次执行以下命令：

1. `pip install pyperclip`
2. `pip install markdown-it-py[plugins]`
3. `pip install css_inline`
4. `pip install regex`
5. `pip install pywin32`
6. `pip install pathlib2`
7. `pip install pillow`

或者进入到我的程序目录，使用`pip install -r requirements.txt`来安装所有的依赖

安装完pythong就可以从运行我的脚本了，但每次都要打开命令行，很不友好，因此建议再安装AutoHotKey

### AutoHotKey

AutoHotKey的作用就是你可以定制一个快捷键来执行一些脚本，省得每次都要打开命令行

AutoHotKey可以从它官网下载：<https://www.autohotkey.com/>

我的脚本ahk目录下有个MyHotScripts.ahk，不过你暂时不能直接运行，需要稍加修改

打开MyHotScripts.ahk，在第11行找到类似以下内容:

```txt
PYTHON_UTILS_DIR := "D:\Data\python\projects\note_utils\"
```

将其中的路径改为脚本的目录路径。

如果需要在系统开机的时候自动启动，将MyHotScripts.ahk复制或者链接到以下目录：

```txt
C:\Users\<你的用户名>\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
```

我的AHK文件的快捷键配置如下：

* Caps Lock + p: 解析汉王N10笔记，生成markdown和html

  会弹出一个文件选择框，选择你的摘抄文件，如果有手写笔记的导出文本文件，也一并选上
  
  **注： 图片文件不需要选，会自动扫描摘抄文件所在文件夹里的png图片文件**

## 关于markdown

使用markdown有以下优点:

* markdown语法简单，使得你可以在阅读器上就预先对笔记进行**简单**的处理，用于突出一些重点、保留一些文本格式等
* 作为一个中间格式，markdown能很方便地转换为其他格式，方便导入到某他软件

程序使用了符合Commonmark的markdown标准，下面的链接里有简单的介绍

<https://commonmark.org/help/>

此外还支持以下扩展：

* github风格的markdown表格
  * 表格单元中支持多行文本，语法在后面说明
* katex数学公式

### 表格单元多行文本支持

示例：

```markdown
| Item | Description | Price|
|--- | --- | ---: |
| Phone | Includes:{nl}* Holographic display{nl}* Telepathic UI|1,000.00|
| Case| Shock resistant hard shell|19.00|
```

渲染结果如下

![x](./img/multiline_table_cell.png)

语法很简单： 虽然table单元格只能有一行文本，但可以使用`{nl}`来表示换行，如上面的例子，写成多行是下面这样的：

```markdown
Includes:
* Holographic display
* Telepathic UI
```

你只需要把你的多行markdown中的换行替换成`{nl}`就行了

这个语法和theBrain的语法是一致的，方便你将markdown表格拷贝到theBrain中

### markdown辅助功能

* **Caps Lock + o**: 将md文件渲染成html，放入剪贴板。
  * 会弹出一个文件选择框，选择需要处理的md文件即可。
  * 如果你是导入到onenote，并且你的markdown中有本地图片，onenote是无法获取到这些图片的，因此程序会自动开启一个http服务器，方便onenote获取markdown中的图片。完事后，记得将http服务器的命行窗口手动关闭
* **Caps Lock + m**: 将剪贴板里的markdown渲染成html，并重新放入剪贴板

### 数学公式支持

如果需要Latex数学公式支持，你还需要安装Node.js, npm和Katex，方法如下:

* 到Node.js官网<https://nodejs.org/en/download/>下载最新的node.js安装包
* Node.js的安装包也会安装npm，因此不需要单独安装npm
* 安装完Node.js后，执行`npm install -g katex`安装katex

### OneNote、supermemo、theBrain等应用的数学公式问题

* OneNote对数学公式的支持不是**标准**的Latex形式，OneNote有Latex模式，但有些latex语法不支持，你可以选择在将markdown导入onenote时，将latex公式替换为图片
* supermemo不支持数学公式
* theBrain13之前不支持数学公式，theBrain13也只支持一个子集

程序本身不支持直接将latex公式转换为图片，因为太麻烦了，要支持好基本都需要安装Latex，这可是好几个GB的安装呀，划不来。

程序采用的方案是分三步走：

1. **Caps Lock + l**: 从md文件中将latex公式提取出来，并生成一个hash码，所有的公式放入一个latex_equations.txt文件中，并且是将inline和block的公式分开存放的，这是因为OneNote不支持在文字间inline图片，因此对于inline的latex公式，不能替换为图片。因为inline的公式一般都很简单，OneNote本身的Latex公式渲染器一般都能搞定
   * 同一个公式如果同时出现在Inline和block中，得到的hash码是不一样的，因此你不用担心会弄混
2. 第二步，打开生成的latex_equations.txt文件，到一些在线的latex公式编辑器里转换化图片，比如[Apose](https://products.aspose.app/tex/equation-editor/png)。保存图片的时候，使用第一步生成的hash码作为文件名
3. 第三步，转换为特写程序的格式并导入
   1. OneNote: **Caps Lock + o**选择md文件，此时就会将latex公式替换为图片了
   2. supermemo及theBrain13以前的版本: **Caps Lock + u**: 发送到supermemo，inline和block的公式都会使用你准备好的图片替代，并且还会针对supermemo分辨率的问题调整图片的大小
   3. theBrain13: 本身支持latex，不需要替换为图片

## 关于supermemo

### supermemo图片相关

supermemo对内联图片的支持乱七八糟，因此在将markdown转为supermemo适用的格式的时候，可以指定一个特定的目录webroot，统一将图片放到这个目录下，这样可以避免supermemo的很多图片问题

要支持这个功能，需要在脚本所在的src目录下放置一个配置文件: settings.json，内容如下，其中的目录可以根据你的需要进行设置：

```json
{
    "webroot" : "D:\\Data\\supermemo\\collections\\webroot"
}
```

有了这个目录后，网页中的本地图片都会**拷贝**到这个目录里，放在一个唯一的UUID目录下，生成的HTML中的图片路径都会指向这个路径，暂时不支持从internet上直接下载图片。

要注意的是，生成的HTML中的路径是诸如`http:localhost:9999/xxx.png` 这样的形式的，并不是写死的windows路径，因此都开启supermemo的时候也需要同时开启一个http server，虽然有点不方便，但通过AHK可以同时启动这supermemo和http server，所以问题不大:

* **Caps Lock + s**: 启动supermemo，然后再启动一个以指定的webroot目录为根目录的python http server

因为脚本中的可执行文件路径是写死的，因此你如果也使用supermemo，需要修改MyHotScripts.ahk中的RunSupermemo实现，将里面的路径改为你的路径

### supermemo Q&A支持

可以将文本文件转为supermemo Q&A，代替supermemo的extract功能

* 使用`---`来分隔item
* 可以使用markdown语法
* 可以显式指定q和a，但格式不必像supermemo Q&A的格式那样严格(参见下面示例中的`q:`和`a:`)
* 使用`{{xxx}}`来表示一个extract，如果有多个`{{xxx}}`，则一个item分生成多个supermemo Q&A item
* 可以为extract指定hint，语法为`{{xxx}}(hint)`这样的形式，这样的hint只在xxx被extract的时候才会显示
* 相关快捷键: **CapsLock & q**，选择一个文本文件，转换并生成一个supermemo q&a文件

示例:

```text
# 标题

**emotion** is a complex reaction pattern, by which an individual attempts to deal with a {{**personally significant**}} matter or event.

---

q: what's the difference between emotion and mood? (hint: contingency between responses and events, duration, intensity)

a: the differences are:

* emotions are **specific** responses to **specific** events——in that sense, emotions are typically relatively **short** lived and relatively **intense**.
* By contrast, moods are often **less intense** and may **last several days**. There's often a **weaker** connection between moods and triggering events. You might be in a good or bad mood **without** knowing exactly why.

---

people who are in **positive** moods may find it {{harder}}(easier or harder?) to ignore {{irrelevant}} information
```

### 其他快捷键

* **CapsLock & u**: 将markdown转为适合supermemo的html，并放入剪贴板

## 关于theBrain

theBrain的markdown标准不符合commmark

* **CapsLock & b**:: 将剪贴板中的内容转换为theBrain能接受的形式再进行粘贴
