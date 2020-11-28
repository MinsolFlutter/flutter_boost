import 'dart:async';
import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './flutter_boost/flutter_boost_app.dart';

//void main() => runApp(MyApp(initParams: window.defaultRouteName,));
//void main() => runApp(_widgetForRoute(window.defaultRouteName));

///通过flutter_boost创建  版本不支持
void main() => runApp(NewApp());



///通过初始化参数创建
Widget _widgetForRoute(String url) {
  print('flutter接受到的初始化参数'+url);
  // route名称
  String route = url.indexOf('?') == -1 ? url : url.substring(0, url.indexOf('?'));
// 参数Json字符串
  String paramsJson = url.indexOf('?') == -1 ? '{}' : url.substring(url.indexOf('?') + 1);
  Map<String, dynamic> mapJson = json.decode(paramsJson);
  String message = mapJson["message"];

// 解析参数
  switch (route) {
    case 'route1':
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Flutter页面'),
          ),
          body: Center(child: Text(message),)
        ),
      );
      break;
    case 'root':
      return MyApp(initParams:url);
      break;
    default:
      break;
  }

}

class MyApp extends StatelessWidget {
  final String initParams;

  const MyApp({Key key, this.initParams}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter 混合开发',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'Flutter 混合开发',
        initParams: initParams,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.initParams}) : super(key: key);

  final String title;
  final String initParams;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const EventChannel _eventChannelPlugin =
      EventChannel('EventChannelPlugin');
  String showMessage = "";

  static const MethodChannel _methodChannelPlugin =
      const MethodChannel('MethodChannelPlugin');

  static const BasicMessageChannel<String> _basicMessageChannel =
      const BasicMessageChannel('BasicMessageChannelPlugin', StringCodec());

  bool _isMethodChannelPlugin = false;
  StreamSubscription _streamSubscription;

  @override
  void initState() {
    _streamSubscription = _eventChannelPlugin
        .receiveBroadcastStream('123')
        .listen(_onToDart, onError: _onToDartError);
    ///使用BasicMessageChannel接受来自Native的消息，并向Native回复
    _basicMessageChannel
        .setMessageHandler((String message) => Future<String>(() {
              setState(() {
                showMessage = 'BasicMessageChannel:'+message;
              });
              return "收到Native的消息：" + message;
            }));

    ///使用MethodChannel接受来自Native的消息，并向Native回复
    Future<dynamic> handler(MethodCall call) async{
      switch (call.method){
        case 'onActivityResult':
          print('MethodChannel 接受来自Native的消息，并向Native回复'+call.arguments['message']);
          setState(() {
            showMessage = 'MethodChannel:'+call.arguments['message'];
          });
          final String result = await _methodChannelPlugin.invokeMethod('send','flutter传参给原生'+call.arguments['message']);
          print('这是在flutter中打印的'+ result);
          break;
      }
    }
    _methodChannelPlugin.setMethodCallHandler(handler);
    super.initState();
  }

  @override
  void dispose() {
    if (_streamSubscription != null) {
      _streamSubscription.cancel();
      _streamSubscription = null;
    }
    super.dispose();
  }

  void _onToDart(message) {
    setState(() {
      showMessage = 'EventChannel:'+message;
    });
  }

  void _onToDartError(error) {
    print(error);
  }

  void _onTextChange(value) async {
    String response;
    try {
      if (_isMethodChannelPlugin) {
        //使用BasicMessageChannel向Native发送消息，并接受Native的回复
        response = await _methodChannelPlugin.invokeMethod('send', value);
      } else {
        response = await _basicMessageChannel.send(value);
      }
    } on PlatformException catch (e) {
      print(e);
    }
    setState(() {
      showMessage = response ?? "";
    });
  }

  void _onChanelChanged(bool value) =>
      setState(() => _isMethodChannelPlugin = value);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(fontSize: 20);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        alignment: Alignment.topLeft,
        decoration: BoxDecoration(color: Colors.lightBlueAccent),
        margin: EdgeInsets.only(top: 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SwitchListTile(
              value: _isMethodChannelPlugin,
              onChanged: _onChanelChanged,
              title: Text(_isMethodChannelPlugin
                  ? "MethodChannelPlugin"
                  : "BasicMessageChannelPlugin"),
            ),
            TextField(
              onChanged: _onTextChange,
              decoration: InputDecoration(
                fillColor: Colors.blue.shade100, filled: true, labelText: '输入参数传递给原生-iOS',
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white))),
            ),
            Text(
              '收到初始参数initParams:${widget.initParams}',
              style: textStyle,
            ),
            Text(
              'Native传来的数据：' + showMessage,
              style: textStyle,
            )
          ],
        ),
      ),
    );
  }
}
