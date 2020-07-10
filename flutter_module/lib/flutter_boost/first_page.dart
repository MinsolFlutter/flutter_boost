import 'package:flutter/material.dart';
import 'package:flutter_module/flutter_boost/second_page.dart';
import './jump_page.dart';
import 'package:flutter_boost/flutter_boost.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
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
          title: Text('第一个页面'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              FlutterBoost.singleton.closeCurrent();
            }),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.red,
          child: Center(
            child: GestureDetector(
              child: Container(
                width: 100,
                height: 100,
                color:  Colors.black,
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return SecondPage();
                }));
              },
            ),
          ),
        )
        );
  }
}
