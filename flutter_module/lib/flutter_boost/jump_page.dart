import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
class JumpPage extends StatefulWidget {
  @override
  _JumpPageState createState() => _JumpPageState();
}

class _JumpPageState extends State<JumpPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('通过原生控制打开页面'),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              FlutterBoost.singleton.closeCurrent();
            }),
      ),
      body: GestureDetector(
        child:  Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.green,
        ),
        onTap: () {
        },
      )


    );
  }
}