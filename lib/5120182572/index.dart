import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp1/5120182572/_login_001.dart';
import 'package:flutterapp1/_user/index.dart';

class indexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => indexPageState();
}

class indexPageState extends State<indexPage> {
  var userInfo = '';

  void initState(){
    super.initState();
    _validateLogin();
  }

  Future _validateLogin() async{
    Future<dynamic> _checkLocalStorage = Future(()async{
      final prefs = await SharedPreferences.getInstance();
      final phone = prefs.getInt('phone');
      final password = prefs.getInt('password');
      return checkUser({"phone":phone,"password":password});
    });
    _checkLocalStorage.then((val){
      print('-----------------');
      print('首页登陆有效性检验');
      print(val);
      print('-----------------');
      if(val == false){
        Navigator.push(context,MaterialPageRoute(builder: (context) => login001()));
      }
    }).catchError((_){
      print("catchError");
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('首页/5120182572朱俊翰'),
      ),
      body:Center(
        child: Column(
            children: [
              Text(userInfo),
              RaisedButton(
                child: Text('注销'),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => login001()));
                },
              )
            ],
      )
      )
    );
  }
}