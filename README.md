# 基于HarmonyOS的日程计划清单APP的设计与实现
本应用是基于HarmonyOS 12版本以上进行开发(模拟器)，后端使用SpringBoot+Mybatis Plus框架，数据库采用Mysql数据库；集成开发环境：Intellij IDEA,DevEco Studio<br>
这个项目是我的第一个关于鸿蒙的项目。基本都是跟着<a href="https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/application-dev-guide" rel="nofollow">应用开发文档</a>学了之后敲的，所以功能会比较少。<br>
首先前端运行环境需要先安装<a href="https://developer.huawei.com/consumer/cn/deveco-studio/" rel="nofollow">DevEco Studio</a>。具体安装教程请参考网上教程。<br>
后端需要安装<a href="https://www.jetbrains.com/zh-cn/idea/download/?section=windows" rel="nofollow">IntelliJ IDEA</a>。数据库用到的是<a href="https://www.navicat.com.cn/" rel="nofollow">Navicat</a>进行管理。<br>
其中前端的日历视图引用的是<a href="https://ohpm.openharmony.cn/#/cn/home" rel="nofollow">OpenHarmony三方库中心仓</a>里“尘封Dè眷恋”大佬的<a href="https://ohpm.openharmony.cn/#/cn/detail/cjcalendar" rel="nofollow">cjcalendar</a>，在此非常感谢。具体的日历环境安装请访问链接进行安装。<br>
# 功能
1、注册功能部分：注册需要用户填写账号、用户名、密码。登录功能部分：登录时只需要提供账号（即手机号）和密码即可登录。<br>
2、用户可以在APP上创建、编辑、查看和管理个人日程安排，包括设置任务事项等。<br>
3、日程分类，分为工作、学习、生活、娱乐，方便用户对不同类型的日程进行分类管理和查看。集成日历视图，以直观的日历形式方便用户安排日程，<a style="color:red">用户可以查看特定日期的任务（这一功能尚未实现）</a>。<br>
4、提供提醒功能，根据用户设置的提醒时间，通过系统通知等方式提醒用户到来的日程任务。<a style="color:red">(由于本项目是在本地运行的，所以涉及支付金额等功能都未完善。)</a>提醒功能用到的是官方开发文档中的<a href="https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/notification-enable" rel="nofollow">请求通知授权</a>。在本应用中的用处是当“专注模式”中设置的计时器归零时，调用通知方法，将提醒信息发送到通知栏。<br>
