import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
import './first_page.dart';
import './second_page.dart';
import './jump_page.dart';

class NewApp extends StatefulWidget {
  @override
  _NewAppState createState() => _NewAppState();
}

class _NewAppState extends State<NewApp> {
  @override
  void initState() {
    super.initState();
    FlutterBoost.singleton.registerPageBuilders({
      '/first': (pageName, params, _) => FirstPage(),
      '/second': (pageName, params, _) => SecondPage(),
      '/jumpPage': (pageName, params, _) => JumpPage()
    });

    FlutterBoost.singleton.addBoostNavigatorObserver(TestBoostNavigatorObserver());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: FlutterBoost.init(postPush: _onRoutePushed),
        home: Container(color: Colors.white));
  }

  void _onRoutePushed(String pageName, String uniqueId, Map params, Route route, Future _) {}
}


class TestBoostNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    print('flutterboost#didPush');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    print('flutterboost#didPop');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic> previousRoute) {
    print('flutterboost#didRemove');
  }

  @override
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    print('flutterboost#didReplace');
  }
}
