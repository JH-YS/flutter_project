import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp1/5120182572/_login_001.dart';
import 'package:flutterapp1/_user/index.dart';

import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

class indexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => indexPageState();
}

class indexPageState extends State<indexPage> {
  var userInfo = '';

  void initState() {
    super.initState();
    _validateLogin();
  }

  Future _validateLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final phone = prefs.getString('phone');
    final password = prefs.getString('password');
    var data = {"phone": phone, "password": password};
    var user = new User(data);
    var loginCheckFlag = await user.loginCheck();
    print('-----------------');
    print('首页登陆有效性检验');
    print(loginCheckFlag);
    print('-----------------');
    if (!loginCheckFlag) {
      user.logOut(context);
    } else {
      var result = await user.getInfo();
      setState((){
        userInfo = result.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('首页/5120182572朱俊翰'),
        ),
        body: Center(
            child: Column(
          children: [
            Text("个人信息：\n$userInfo"),
            RaisedButton(
              child: Text('注销'),
              onPressed: () {
                var user = new User({});
                user.logOut(context);
              },
            ),
          ],
        )));
  }
}
