import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp1/5120182572/index.dart';

class regist extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => registState();
}

class registState extends State<regist> {
  //手机号的控制器
  TextEditingController phoneController = TextEditingController();

  //新密码的控制器
  TextEditingController passController = TextEditingController();
  TextEditingController passCheckController = TextEditingController();
  GlobalKey<FormState> registFormKey = new GlobalKey<FormState>();

  void initState() {
    super.initState();
  }

  var passwordVisible = true; //设置初始状态
  var passwordCheckVisible = true; //设置初始状态
  var flag = false;
  RegExp phoneExp = RegExp(r'^1[34578]\d{9}$|^1((99)|(66)|(98)|(91)|(65))\d{8}$');
  RegExp passwordExp = RegExp(r'^(?:\d|[a-zA-Z]|[.!@#$%^&*]){6,18}$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('regist页面/5120182572朱俊翰'),
        ),
        body: Stack(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(25, 70, 25, 0),
              child:  Form(
                  key: registFormKey,
                  child:Column(
                    children: <Widget>[
                      Container(
                        color: Colors.grey,
                        child: Text('app logo'),
                      ),
                      TextFormField(
                        inputFormatters: [
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        maxLength: 11,
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        onChanged: (e) {
                          registFormKey.currentState.validate();
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
                            registFormKey.currentState.validate();
                          },
                          validator: (value) {
                            bool passwordMatched = passwordExp.hasMatch(value);
                            if (value.length == 0) {
                              setState(() {
                                flag = false;
                              });
                              return '新密码不可为空';
                            } else if (value.length < 6) {
                              setState(() {
                                flag = false;
                              });
                              return '新密码长度不得低于6位';
                            } else if (!passwordMatched) {
                              setState(() {
                                flag = false;
                              });
                              return '请正确设置新密码，新密码由6-18位数字、英文或特殊字符(.!@#\$%^&*)组成!';
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
                            labelText: '请设置新密码',
                            suffixIcon: IconButton(
                              icon: Icon(
                                //根据passwordVisible状态显示不同的图标
                                passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              onPressed: () {
                                //更新状态控制新密码显示或隐藏
                                setState(() {
                                  passwordVisible = !passwordVisible;
                                });
                              },
                            ),
                          ),
                          obscureText: !passwordVisible),
                      TextFormField(
                          controller: passCheckController,
                          keyboardType: TextInputType.text,
                          maxLength: 16,
                          onChanged: (e) {
                            registFormKey.currentState.validate();
                          },
                          validator: (value) {
                            if (value.length == 0) {
                              setState(() {
                                flag = false;
                              });
                              return '新密码不可为空';
                            } else if (value != passController.text) {
                              setState(() {
                                flag = false;
                              });
                              return '与所设新密码不一致';
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
                            labelText: '再次输入新密码',
                            suffixIcon: IconButton(
                              icon: Icon(
                                //根据passwordVisible状态显示不同的图标
                                passwordCheckVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              onPressed: () {
                                //更新状态控制新密码显示或隐藏
                                setState(() {
                                  passwordCheckVisible = !passwordCheckVisible;
                                });
                              },
                            ),
                          ),
                          obscureText: !passwordCheckVisible),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                        child: RaisedButton(
                          disabledColor: Colors.grey,
                          shape: CircleBorder(
                              side: BorderSide(color: Colors.transparent)),
                          color: Colors.blueAccent,
                          elevation: 5,
                          onPressed: flag ? null : _regist,
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
                  )
              ),
            )
          ],
        ));
  }

  void _regist() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => indexPage()));
  }
}
