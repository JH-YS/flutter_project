import 'dart:convert' as convert;
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp1/5120182572/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutterapp1/5120182572/_login_001.dart';

class User {
  var phone;
  var password;
  var nickName;
  var question;
  var answer;

  User(data) {
    this.phone = data["phone"];
    this.password = data["password"];
    this.nickName = data["nickName"];
    this.question = data["question"];
    this.answer = data["answer"];
  }

  //新增用户
  add(context) async{
    var file = await this.getUserFile();
    var content = file.readAsStringSync();
    var userList = convert.jsonDecode(content);
    var theLastElement;
    var userId = 1;
    if(userList.isNotEmpty){
      var userIsExsist = await this.checkUser();
      // 先判断该手机号是否已经存在
      if(userIsExsist){
        return false;
      }
      theLastElement = userList.last;
      userId = theLastElement["user_id"]+1;
    }
    var userData = {
      "user_id":userId,
      "nickName":this.nickName,
      "phone":this.phone,
      "password":this.password,
      "question":this.question,
      "answer":this.answer
    };
    userList.add(userData);
    var jsonDataEncoded = convert.jsonEncode(userList);
    file.writeAsStringSync("");
    file.writeAsStringSync(jsonDataEncoded);
    return true;
  }

  //获取用户信息
  getInfo() async{
    var file = await this.getUserFile();
    var content = file.readAsStringSync();
    var userList = convert.jsonDecode(content);
    for (var element in userList) {
      if (element["phone"] == this.phone) {
        return element;
      }
    }
  }

  //修改用户信息
  bool edit() {
    return true;
  }

  //删除用户
  bool delete() {
    return true;
  }

  //登陆验证，手机号和密码
  loginCheck() async {
    var file = await this.getUserFile();
    var content = file.readAsStringSync();
    var userList = convert.jsonDecode(content);
    for (var element in userList) {
      if (element["phone"] == this.phone) {
        if (element["password"] == this.password) {
          return true;
        }
      }
    }
    return false;
  }

  //找回密码
  // 检查用户是否存在，手机号是否存在
  checkUser() async {
    var file = await this.getUserFile();
    var content = file.readAsStringSync();
    var userList = convert.jsonDecode(content);
    for (var element in userList) {
      if (element["phone"] == this.phone) {
        return true;
      }
    }
    return false;
  }

  //找回密码
  //比对密保信息
  checkQuestionAnswer() async{
    var file = await this.getUserFile();
    var content = file.readAsStringSync();
    var userList = convert.jsonDecode(content);
    for (var element in userList) {
      if (element["phone"] == this.phone) {
        var info = await this.getInfo();
        if(this.answer == info["answer"]){
          return true;
        }
      }
    }
    return false;
  }

  //密码找回
  //账号密码初始化
  passwordInit() async{
    var file = await this.getUserFile();
    var content = file.readAsStringSync();
    var userList = convert.jsonDecode(content);
    for (var element in userList) {
      if (element["phone"] == this.phone) {
        element["password"] = "123456";
      }
    }
    var jsonDataEncode = convert.jsonEncode(userList);
    file.writeAsStringSync('');
    file.writeAsStringSync(jsonDataEncode);
  }

  //登陆
  login(context) async {
    if (await this.loginCheck()) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('phone', this.phone);
      prefs.setString('password', this.password);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => indexPage()));
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return new AlertDialog(
              title: new Text('提示'),
              content: new SingleChildScrollView(
                child: new ListBody(
                  children: <Widget>[
                    new Text('账号或密码出错，请检查后再登陆'),
                  ],
                ),
              ),
              actions: <Widget>[
                new FlatButton(
                  child: new Text('确定'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    }
  }

  //登出
  void logOut(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => login001()));
  }

  //获取用户列表对应的文件对象
  Future<dynamic> getUserFile() async {
    return await getApplicationDocumentsDirectory().then((value) {
      var directory = Directory("${value.path}/test");
      print("文件夹路径：${directory.path}");
      if (!directory.existsSync()) {
        print("文件夹不存在--->准备创建");
        directory.createSync();
      }
      // 创建文件
      var file = File("${directory.path}/user.txt");
      if (!file.existsSync()) {
        print("文件不存在--->准备创建");
        file.createSync();
      }
      //初始化文件内容
      if(file.readAsStringSync()==null||file.readAsStringSync()==""){
        file.writeAsStringSync("[]");
      }
      return file;
    });
  }
}
