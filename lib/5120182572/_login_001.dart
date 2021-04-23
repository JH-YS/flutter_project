import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp1/5120182572/index.dart';
import 'package:flutterapp1/5120182572/regist.dart';

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
  RegExp phoneExp = RegExp(r'^1[34578]\d{9}$|^1((99)|(66)|(98)|(91)|(65))\d{8}$');
  RegExp passwordExp = RegExp(r'^(?:\d|[a-zA-Z]|[.!@#$%^&*]){6,18}$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('login页面/5120182572朱俊翰'),
        ),
        body: Stack(
          children: [
            Container(
                margin: EdgeInsets.fromLTRB(25, 70, 25, 0),
                child: Form(
                  key: loginFormKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        color: Colors.grey,
                        child: Text('app logo'),
                      ),
                      TextFormField(
                        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
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
                            bool passwordMatched = passwordExp.hasMatch(value);
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
                              return '请正确设置新密码，密码由6-18位数字、英文或特殊字符(.!@#\$%^&*)组成!';
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
                        margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                        child: RaisedButton(
                          disabledColor: Colors.grey,
                          shape: CircleBorder(
                              side: BorderSide(color: Colors.transparent)),
                          color: Colors.blueAccent,
                          elevation: 5,
                          onPressed: flag ? _login : null,
                          child: Center(
                            child: Icon(
                              Icons.arrow_right_alt_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        width: 65,
                        height: 65,
                      ),
                    ],
                  ),
                )),
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
                    onPressed: () => {},
                    child: Text('找回密码',
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

  void _login() {
    print({'phone': phoneController.text, 'password': passController.text});
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => indexPage()));
//      onTextClear();
  }

  void onTextClear() {
    setState(() {
      phoneController.clear();
      passController.clear();
    });
  }
}
