# 皮皮仔
一种新的写作方式

[项目传送门](https://github.com/daGaiGuanYu/ppz)

+ [简介](https://dagaiguanyu.github.io/ppz/doc/dist/index/index.html)
+ [使用](https://dagaiguanyu.github.io/ppz/doc/dist/how2use/)

# 为什么需要新的？
一直以来，码者都在用 markdown 写东西，但是 markdown 有一些缺点：
+ 标准不统一，同样的内容在不同编译器、不同网站表现不一样
+ 大多数 markdown 编译器不会生成目录，文章长的时候，来回翻，很痛苦
+ 如果写好几篇文章，，，就没有一个流畅的方式，把这些文章联系在一起（要手动维护链接）

# 现在
现阶段基本实现了 ppz 语法（类似 markdown 语法）到 html 的转化

未实现的 markdown 语法：
+ table
+ 代码高亮
+ 有序列表
+ 下划线、删除线

# 未来
下阶段的工作：
+ （主要）对一个文件夹里的 ```.ppz``` 文件编译，并生成导向各页面的目录
+ 锚点，生成文内某个元素的链接（这样当你分享文章时，就不用告诉对方“要看的内容在第几行”）
+ 标题导航完善，非一级标题下显示上级标题

+ special-block 复制按钮
+ 图片浏览器

+ 命令行参数
+ 各级配置：家目录、各级文件夹、页面
+ ```shebang``` 好像很好玩~ 直接运行 ```.ppz``` 文件
+ layout
+ 主题

+ ......
+ （次要）table、代码高亮、有序列表、下划线、删除线

# 贡献
+ 欢迎同仁贡献代码、找到 bug、提出批评和建议