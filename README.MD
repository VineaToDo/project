网上求职招聘系统
==============
|Author|Vinea|
|---|---
|E-mail|1530027668@qq.com

****

### 框架技术选择：
	1. Spring全家桶 - SpringBoot+SpringDataJPA
	2. FreeMarker
	3. Shiro集成简单登录验证,改写了自动登录功能
	4. BootStrap,EasyUI
		
----

### 系统描述：
	系统功能上从三个角色进行划分：`求职者用户`,`企业用户`和`后台管理员`:
	1. 匿名游客
		作为未注册用户，只拥有浏览权限，在系统主界面浏览热门职位，职位分类信息，对应职位列表，职位详情信息等此类公开内容。
	2. 个人注册用户
		简历管理:简历的预览、编辑、导出;
		求职应聘:除了匿名游客的浏览权限外，还能与企业用户产生交互信息，例如对相关职位的投递、收藏和举报等一系列操作。
	3. 企业注册用户
		公司信息管理,职位管理,简历管理
	4. 后台管理员
		用户管理,职位管理,字典管理
