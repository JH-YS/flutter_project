import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp1/5120182572/findPassword.dart';
import 'package:flutterapp1/5120182572/index.dart';
import 'package:flutterapp1/5120182572/regist.dart';
import 'package:flutterapp1/_user/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class login001 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => login001State();
}

class login001State extends State<login001> {
  //手机号的控制器
  TextEditingController phoneController = TextEditingController();

  //密码的控制器
  TextEditingController passController = TextEditingController();
  GlobalKey<FormState> loginFormKey = new GlobalKey<FormState>();

  void initState() {
    super.initState();
  }

  var passwordVisible = false; //设置初始状态
  var flag = false;
  RegExp phoneExp =
      RegExp(r'^1[34578]\d{9}$|^1((99)|(66)|(98)|(91)|(65))\d{8}$');
  RegExp passwordExp = RegExp(r'^(?:\d|[a-zA-Z]|[.!@#$%^&*]){6,18}$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('登陆/5120182572朱俊翰'),
        ),
        body: Stack(
          children: [
            Container(
              child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Form(
                    key: loginFormKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          //设置容器大小
                          width: double.maxFinite,
                          height: 100,
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                          decoration: (BoxDecoration(
                              shape: BoxShape.rectangle,
                              //可以设置角度，BoxShape.circle直接圆形
                              borderRadius: BorderRadius.circular(4),
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(
                                  "images/logo.png",
                                ),
                              ))),
                          child: Text(''),
                        ),
                        TextFormField(
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          maxLength: 11,
                          controller: phoneController,
                          keyboardType: TextInputType.number,
                          onChanged: (e) {
                            loginFormKey.currentState.validate();
                          },
                          validator: (value) {
                            bool phoneMatched = phoneExp.hasMatch(value);
                            if (value.length == 0) {
                              setState(() {
                                flag = false;
                              });
                              return '手机号不可为空';
                            } else if (!phoneMatched) {
                              setState(() {
                                flag = false;
                              });
                              return '请正确输入手机号(11位)';
                            } else {
                              setState(() {
                                flag = true;
                              });
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            icon: Icon(Icons.phone),
                            labelText: '请输入手机号码',
                          ),
                          autofocus: false,
                        ),
                        TextFormField(
                            controller: passController,
                            keyboardType: TextInputType.text,
                            maxLength: 16,
                            onChanged: (e) {
                              loginFormKey.currentState.validate();
                            },
                            validator: (value) {
                              bool passwordMatched =
                                  passwordExp.hasMatch(value);
                              if (value.length == 0) {
                                setState(() {
                                  flag = false;
                                });
                                return '密码不可为空';
                              } else if (value.length < 6) {
                                setState(() {
                                  flag = false;
                                });
                                return '密码长度不得低于6位';
                              } else if (!passwordMatched) {
                                setState(() {
                                  flag = false;
                                });
                                return '请正确输入密码，密码由6-18位数字、英文或特殊字符(.!@#\$%^&*)组成!';
                              } else {
                                setState(() {
                                  flag = true;
                                });
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10.0),
                              icon: Icon(Icons.lock),
                              labelText: '请输入密码',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  //根据passwordVisible状态显示不同的图标
                                  passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                                onPressed: () {
                                  //更新状态控制密码显示或隐藏
                                  setState(() {
                                    passwordVisible = !passwordVisible;
                                  });
                                },
                              ),
                            ),
                            obscureText: !passwordVisible),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 80, 0, 0),
                          child: RaisedButton(
                            disabledColor: Colors.grey,
                            shape: CircleBorder(
                                side: BorderSide(color: Colors.transparent)),
                            color: Colors.black,
                            elevation: 5,
                            onPressed: flag ? _login : null,
                            child: Center(
                              child: Icon(
                                Icons.arrow_right_alt_outlined,
                                color: flag ? Colors.orange : Colors.white,
                              ),
                            ),
                          ),
                          width: 65,
                          height: 65,
                        ),
                      ],
                    ),
                  )),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 25,
              child: Center(
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  FlatButton(
                    onPressed: () => {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => regist()))
                    },
                    child: Text(
                      '注册',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Text('|'),
                  FlatButton(
                    onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => findPassword()))
                    },
                    child: Text('  找回密码',
                        style: TextStyle(
                          fontSize: 12,
                        )),
                  ),
                ]),
              ),
            )
          ],
        ));
  }

  void _login() async {
    var data = {"phone": phoneController.text, "password": passController.text};
    var user = new User(data);
    user.login(context);
  }

  void onTextClear() {
    setState(() {
      phoneController.clear();
      passController.clear();
    });
  }
}
