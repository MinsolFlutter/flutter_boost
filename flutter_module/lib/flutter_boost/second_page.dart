import 'package:flutter/material.dart';
import './jump_page.dart';
import 'package:flutter_boost/flutter_boost.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}



class _SecondPageState extends State<SecondPage> {
  @override
  void initState() {
    super.initState();
    //flutter部分接收数据，dart代码
    FlutterBoost.singleton.channel.addEventListener('iOSToFlutterBoost',
            (name, arguments){
          print('iOSToFlutterBoost' + name+arguments.toString());
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return JumpPage();
          }));
          return;
        });
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
          title: Text('第二个页面'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.blue,
          child: Center(
            child: GestureDetector(
              child: Container(
                width: 100,
                height: 100,
                color: Colors.black,
              ),
              onTap: () {
                /*
                flutter如何传递数据给native
                  */
                //flutter代码，ChannelName是通道名称与native部分一致即可，tmp是map类型的参数
                Map<String,dynamic> tmp = Map<String,dynamic>();
                tmp['name'] = 'hello';
                try{
                  FlutterBoost.singleton.channel.sendEvent("FlutterBoostToiOS", tmp);
                }catch(e){
                }
              },
            ),
          ),
        ));
  }
}
