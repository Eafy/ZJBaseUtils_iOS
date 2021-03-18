# ZJBaseUtils

`ZJBaseUtils`是iOS平台obj-C语言的工具集，提供通用、高集成的扩展接口、功能组件及UI组件；

## API扩展

### 基础类型扩展

- NSObject：运行时Runtime扩展接口；
- NSString
  - 字符串扩展：邮箱、手机号、中文、数字、Emoji、全英文、大小、转换、颜色等；
  - Json：转字段、数组；
  - 编码：MD5、RSA、SHA、AES、DES；
  - UIImage：字符串转Image；
- NSMutableAttributedString：添加、移除特殊颜色；
- NSDate：时间格式化、UTC、本地时间获取及互转、单获取时间相关接口；
- NSData
  - 转换：转十六进制、转Base64；
  - 编码：RSA、AES、DES；
- NSDictionary：转Json；
- NSArray：转Json、数组集操作（交集、差集、并集、反序）；
- NSFileManager
  - 文档、沙盒路径
  - 文件操作：创建、删除、一定、拷贝、查找、遍历；
  - 系统容量大小及缓存清除；
  - 文件类型；
- NSThread：休眠、唤醒、信号量；
- CAAnimation：动画集合（抖动、透明过渡、缩放、旋转）；

### UI类型扩展

- UIColor：颜色快捷API、字符串转颜色、颜色操作；
- UIImage
  - 基础API：保存、取颜色点、改变颜色、缩放、截取、角度操作、颜色转图片；
  - 渐变色：多形式生成渐变色图片；
  - 二维码：黑白二维码、颜色二维码；
- UISearchBar：属性操作（字体、文字颜色、取消按钮）；
- UIView
  - 基础API：转图片、边框线条、离屏圆角、阴影；
  - Frame：坐标体系快速API；
  - 渐变色；
  - 动画；
  - 手势：单击、双击、多次点击、长按、左滑、右滑；
- UIButton：文字和图片布局操作、渐变色；
- UIImageView：图片位置操作；
- UIViewController
  - 当前控制器
  - 查找控制器；
  - 退出至某个控制器；
  - 退出所有控制器；
  - 弹框快捷API；

## 功能组件

- ZJScreen：屏幕Frame及适配相关；
  - 各类Frame快捷API；
  - 屏幕自适应缩放API；
  - 当前窗口Window；

- ZJSystem
  - 项目App属性API；
  - 设备UUID操作；
  - 系统语言；
  - 系统权限操作；
  - URL跳转操作；
  - WiFi及IP获取；
- ZJLocalization：自适应的本地化语言工具类，单一快捷适配语言；
- 基类控制器模板：涵盖大部分的属性快捷操作、集成API，以下基类控制器一起使用可产生高效的联动属性；
  - 基类控制器：ZJBaseViewController；
  - 基类图表控制器：ZJBaseTableViewController；
  - 基类底部导航控制器：ZJBaseTabBarController；
  - 基类导航控制器：ZJBaseNavigationController；
- ZJPhoto：系统相册操作工具类；
  - 获取最后一张图片、一个视频；
  - 删除最后一张图片、一个视频；
  - 获取相册文件信息、首帧图片等；
  - 相册文件操作：保存、删除、移动、拷贝等；
- ZJModel：建议的Json转Model类（自嘲写的比较另类）；
- ZJBundleRes：UIBundle资源加载及读取器；

## UI组件

- 表单模板：支持大部分设置类型功能的表单样式，仅针对填入对应的数据，即可展示；

  <img src="https://raw.githubusercontent.com/Eafy/ZJBaseUtils_iOS/master/SampleImgRes//image-20210318142809207.png" alt="image-20210318142809207" style="zoom:50%;" />

- ZJCalendar：日历模块，支持单选、多选、区域选择；

  <img src="https://raw.githubusercontent.com/Eafy/ZJBaseUtils_iOS/master/SampleImgRes/image-20210318141235436.png" alt="image-20210318141235436" style="zoom:50%;" />

- ZJSlider：滑块选择模块，支持单点、区间、固定点样式；

![image-20210318143244179](/Users/lzj/Library/Application Support/typora-user-images/image-20210318143244179.png)

- ZJNotifyHUD：类告警提示的Hub提示弹框，支持多动画、悬停、右键操作、内容分类；

![image-20210318143348472](/Users/lzj/Library/Application Support/typora-user-images/image-20210318143348472.png)

- ZJAlertView：弹框提示器，可根据不同场景自行搭配多种样式；

![image-20210318143749772](/Users/lzj/Library/Application Support/typora-user-images/image-20210318143749772.png)![image-20210318143759396](/Users/lzj/Library/Application Support/typora-user-images/image-20210318143759396.png)

![image-20210318143825829](/Users/lzj/Library/Application Support/typora-user-images/image-20210318143825829.png)

- ZJSheetView：底部弹框选择器，支持内容自由搭配；

![image-20210318144007849](/Users/lzj/Library/Application Support/typora-user-images/image-20210318144007849.png)

- ZJStepBar：步骤条模块；

![image-20210318144232503](/Users/lzj/Library/Application Support/typora-user-images/image-20210318144232503.png)

- ZJSegmentedControl：标签选择器，支持固定、滑动、图形文字混合；

  ![image-20210318144257440](/Users/lzj/Library/Application Support/typora-user-images/image-20210318144257440.png)

- ZJPickerView：选择器，支持多列、时间、联动模式；

  

![image-20210318144803808](/Users/lzj/Library/Application Support/typora-user-images/image-20210318144803808.png)![image-20210318144813701](/Users/lzj/Library/Application Support/typora-user-images/image-20210318144813701.png)

