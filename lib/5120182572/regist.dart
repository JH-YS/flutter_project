import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp1/5120182572/index.dart';
import 'package:flutterapp1/_user/index.dart';

class regist extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => registState();
}

class registState extends State<regist> {
  TextEditingController nickNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController passCheckController = TextEditingController();
  TextEditingController questionController = TextEditingController();
  TextEditingController answerController = TextEditingController();
  GlobalKey<FormState> registFormKey = new GlobalKey<FormState>();

  void initState() {
    super.initState();
  }

  var passwordVisible = false; //设置初始状态
  var passwordCheckVisible = false; //设置初始状态
  var flag = false;
  RegExp nickNameExp = RegExp(r'^[\u4E00-\u9FA5\uF900-\uFA2D|\w]{2,16}$');
  RegExp phoneExp =
      RegExp(r'^1[34578]\d{9}$|^1((99)|(66)|(98)|(91)|(65))\d{8}$');
  RegExp passwordExp = RegExp(r'^(?:\d|[a-zA-Z]|[.!@#$%^&*]){6,18}$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('注册页面/5120182572朱俊翰'),
        ),
        body: Stack(
          children: [
            Container(
              child: Padding(
                padding: EdgeInsets.all(30),
                child: Form(
                    key: registFormKey,
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
                            controller: nickNameController,
                            keyboardType: TextInputType.text,
                            maxLength: 16,
                            onChanged: (e) {
                              registFormKey.currentState.validate();
                            },
                            validator: (value) {
                              bool nickNameMatched =
                                  nickNameExp.hasMatch(value);
                              if (value.length == 0) {
                                setState(() {
                                  flag = false;
                                });
                                return '用户名不可为空';
                              } else if (!nickNameMatched) {
                                setState(() {
                                  flag = false;
                                });
                                return '请正确输入用户名，用户名可以为中文，英文字母，数字及下划线组成，长度2-16位';
                              } else {
                                setState(() {
                                  flag = true;
                                });
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10.0),
                              icon: Icon(Icons.drive_file_rename_outline),
                              labelText: '输入用户名',
                            )),
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
                              bool passwordMatched =
                                  passwordExp.hasMatch(value);
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
                                    passwordCheckVisible =
                                        !passwordCheckVisible;
                                  });
                                },
                              ),
                            ),
                            obscureText: !passwordCheckVisible),
                        TextFormField(
                            controller: questionController,
                            keyboardType: TextInputType.text,
                            maxLength: 20,
                            onChanged: (e) {
                              registFormKey.currentState.validate();
                            },
                            validator: (value) {
                              if (value.length == 0) {
                                setState(() {
                                  flag = false;
                                });
                                return '密保问题不可为空';
                              } else {
                                setState(() {
                                  flag = true;
                                });
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10.0),
                              icon: Icon(Icons.verified_user),
                              labelText: '设置密保问题',
                            )),
                        TextFormField(
                            controller: answerController,
                            keyboardType: TextInputType.text,
                            maxLength: 20,
                            onChanged: (e) {
                              registFormKey.currentState.validate();
                            },
                            validator: (value) {
                              if (value.length == 0) {
                                setState(() {
                                  flag = false;
                                });
                                return '密保答案不可为空';
                              } else {
                                setState(() {
                                  flag = true;
                                });
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10.0),
                              icon: Icon(Icons.question_answer_outlined),
                              labelText: '设置密保答案',
                            )),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                          child: RaisedButton(
                            disabledColor: Colors.grey,
                            shape: CircleBorder(
                                side: BorderSide(color: Colors.transparent)),
                            color: Colors.black,
                            elevation: 5,
                            onPressed: flag ? _regist : null,
                            child: Center(
                              child: Icon(
                                Icons.login,
                                color: flag ? Colors.orange : Colors.white,
                              ),
                            ),
                          ),
                          width: 65,
                          height: 65,
                        ),
                      ],
                    )),
              ),
            )
          ],
        ));
  }

  void _regist() async {
    var data = {
      "nickName": nickNameController.text,
      "phone": phoneController.text,
      "password": passController.text,
      "question": questionController.text,
      "answer": answerController.text
    };
    var user = new User(data);
    if (await user.add(context)) {
      user.login(context);
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return new AlertDialog(
              title: new Text('提示'),
              content: new SingleChildScrollView(
                child: new ListBody(
                  children: <Widget>[
                    new Text('该账号已存在，请勿重复注册'),
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
}
