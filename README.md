# flutter_boost 接入指南
### 官方说明
[flutter_boost github](https://github.com/alibaba/flutter_boost)

[集成相关-暂时只有iOS github](https://github.com/alibaba/flutter_boost/blob/master/INTEGRATION.md)

[FlutterBoost2.0 技术文档](https://www.yuque.com/xytech/flutter/ispa1h)

[FlutterBoost 闲鱼技术](https://mp.weixin.qq.com/s/v-wwruadJntX1n-YuMPC7g)

### 接入指南
#### 工程配置
1. flutter_module  `pub get`
2. flutter-boost-android ``
3. flutter-boost-ios `pod update --no-repo-update`

    
#### 工程目录介绍
```c
.
├── README.md
├── flutter-boost-android /// Android 工程
│   ├── app
│   ├── build
│   ├── build.gradle
│   ├── gradle
│   ├── gradle.properties
│   ├── gradlew
│   ├── gradlew.bat
│   ├── local.properties
│   └── settings.gradle
├── flutter-boost-ios /// iOS 工程
│   ├── Podfile
│   ├── Podfile.lock
│   ├── Pods
│   ├── flutter-boost-ios
│   ├── flutter-boost-ios.xcodeproj
│   └── flutter-boost-ios.xcworkspace
└── flutter_module /// flutter 模块
    ├── README.md
    ├── build.gradle
    ├── build_file.sh
    ├── gradle
    ├── gradlew
    ├── gradlew.bat
    ├── lib
    ├── local.properties
    ├── pubspec.lock
    ├── pubspec.yaml
    └── test
```

#### Flutter Module

##### 添加依赖
```Dart
dependencies:
  flutter:
    sdk: flutter
  flutter_boost: ^1.12.13+1
```

##### 注册路由
```Dart
    FlutterBoost.singleton.registerPageBuilders({
      '/first': (pageName, params, _) => FirstPage(),
      '/second': (pageName, params, _) => SecondPage(),
      '/jumpPage': (pageName, params, _) => JumpPage()
    });
```

##### 关闭 Flutter 页面
```Dart
FlutterBoost.singleton.closeCurrent();
```
1. 给原生发送消息

```
FlutterBoost.singleton.channel.sendEvent("FlutterBoostToiOS", Map);
```
1. 监听原生发来的消息

```Dart
    //flutter部分接收数据，dart代码
    FlutterBoost.singleton.channel.addEventListener('iOSToFlutterBoost',
            (name, arguments){
          print('iOSToFlutterBoost' + name+arguments.toString());
          return;
    });
```

#### Flutter iOS
iOS 使用主要是通过 <FLBPlatform> 协议的形式处理跳转。
##### 集成 Flutter
```c
  #通过官方推荐方法1
  flutter_application_path = '../flutter_module/'
  load File.join(flutter_application_path, '.ios', 'Flutter','podhelper.rb')
  install_all_flutter_pods(flutter_application_path)
```

##### 注册 flutter
主要路由跳转在 `WPFlutterRouter` 里面
```objc
    WPFlutterRouter *router = [WPFlutterRouter new];///遵守 <FLBPlatform> 协议的类
    __weak __typeof(self)weakSelf = self;
    [FlutterBoostPlugin.sharedInstance startFlutterWithPlatform:router onStart:^(FlutterEngine *engine) {
        weakSelf.engine = engine;
    }];
```

##### 打开 flutter 页面
```objc
    [FlutterBoostPlugin open:@"/first" urlParams:@{kPageCallBackId:@"MycallbackId#1"} exts:@{@"animated":@(YES)} onPageFinished:^(NSDictionary *result) {
        NSLog(@"call me when page finished, and your result is:%@", result);
    } completion:^(BOOL f) {
    }];
```

##### 监听 flutter 消息
```objc
    [FlutterBoostPlugin.sharedInstance addEventListener:^(NSString *name, NSDictionary *arguments) {
        NSLog(@"%@-%@",name,arguments);
    } forName:@"FlutterBoostToiOS"];
```

##### 发送消息给 flutter
```objc
FlutterBoostPlugin.sharedInstance sendEvent:@"iOSToFlutterBoost" arguments:@{}];
```

#### Flutter Android
##### 官方集成
```java
///settings.gradle
///
/// Include the host app project. // assumed existing content
setBinding(new Binding([gradle: this]))                                // new
evaluate(new File(                                                     // new
        settingsDir.parentFile,                                              // new
        'flutter_module/.android/include_flutter.groovy'                         // new
))                                                                     // new

include ':flutter_module'
project(':flutter_module').projectDir = new File('../flutter_module')
```
##### 添加依赖
```java
/// build.gradle
///
dependencies {
  implementation project(':flutter')
}
```
#####  新建 MyApplication 注册 FlutterBoost
主要代码在 `BoostHelper` 里面
```java
Platform platform = new FlutterBoost
        .ConfigBuilder(application, router)
        .isDebug(true)
        .whenEngineStart(FlutterBoost.ConfigBuilder.ANY_ACTIVITY_CREATED)
        .renderMode(FlutterView.RenderMode.texture)
        .lifecycleListener(boostLifecycleListener)
        .build();
FlutterBoost.instance().init(platform);
```

##### 打开 flutter 页面
通过 Flutter Engine 创建 Intent
```java
// 跳转flutter界面
Intent intent = BoostFlutterActivity.withNewEngine().url(url).params(params)
        .backgroundMode(BoostFlutterActivity.BackgroundMode.opaque).build(context);
if (context instanceof Activity) {
    Activity activity = (Activity) context;
    activity.startActivityForResult(intent, requestCode);
}
```

##### 监听 flutter 消息
在 FlutterBoost 生命周期 `BoostLifecycleListener` 回调里面，等待 `onEngineCreated` 引擎初始化后
```java
FlutterBoostPlugin.singleton().addEventListener("FlutterBoostToiOS", new FlutterBoostPlugin.EventListener() {
    @Override
    public void onEvent(String name, Map args) {
        
    }
});
```

##### 发送消息给 flutter
```java
FlutterBoostPlugin.singleton().sendEvent();
```