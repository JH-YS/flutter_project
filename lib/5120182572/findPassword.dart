import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp1/5120182572/_login_001.dart';
import 'package:flutterapp1/5120182572/index.dart';
import 'package:flutterapp1/_user/index.dart';

class findPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => findPasswordState();
}

class findPasswordState extends State<findPassword> {
  //手机号的控制器
  TextEditingController phoneController = TextEditingController();
  TextEditingController questionController = TextEditingController();
  TextEditingController answerController = TextEditingController();
  GlobalKey<FormState> findPasswordFormKey = new GlobalKey<FormState>();

  void initState() {
    super.initState();
  }

  var passwordVisible = true; //设置初始状态
  var passwordCheckVisible = true; //设置初始状态
  var formCheckFlag = false;
  var questionVisible = false;
  RegExp phoneExp =
      RegExp(r'^1[34578]\d{9}$|^1((99)|(66)|(98)|(91)|(65))\d{8}$');
  RegExp passwordExp = RegExp(r'^(?:\d|[a-zA-Z]|[.!@#$%^&*]){6,18}$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('找回密码/5120182572朱俊翰'),
        ),
        body: Stack(
          children: [
            Container(
                child: Padding(
              padding: EdgeInsets.all(30),
              child: Form(
                  key: findPasswordFormKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        //设置容器大小
                        width: double.maxFinite,
                        height: 100,
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
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
                        onChanged: (value) {
                          bool phoneMatched = phoneExp.hasMatch(value);
                          findPasswordFormKey.currentState.validate();
                          if (!phoneMatched) {
                            setState(() {
                              questionVisible = false;
                              formCheckFlag = false;
                            });
                          }
                        },
                        validator: (value) {
                          bool phoneMatched = phoneExp.hasMatch(value);
                          if (value.length == 0) {
                            setState(() {
                              formCheckFlag = false;
                            });
                            return '手机号不可为空';
                          } else if (!phoneMatched) {
                            setState(() {
                              formCheckFlag = false;
                            });
                            return '请正确输入手机号(11位)';
                          } else {
                            setState(() {
                              formCheckFlag = true;
                            });
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          icon: Icon(Icons.phone),
                          labelText: '请输入手机号码以供查询',
                        ),
                        autofocus: false,
                      ),
                      Visibility(
                          visible: questionVisible,
                          child: Column(
                            children: [
                              TextFormField(
                                  controller: questionController,
                                  keyboardType: TextInputType.text,
                                  maxLength: 20,
                                  onChanged: (e) {
                                    findPasswordFormKey.currentState.validate();
                                  },
                                  validator: (value) {
                                    if (value.length == 0) {
                                      setState(() {
                                        formCheckFlag = false;
                                      });
                                      return '密保问题不可为空';
                                    } else {
                                      setState(() {
                                        formCheckFlag = true;
                                      });
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10.0),
                                    icon: Icon(Icons.verified_user),
                                    labelText: '密保问题',
                                  )),
                              TextFormField(
                                  controller: answerController,
                                  keyboardType: TextInputType.text,
                                  maxLength: 20,
                                  onChanged: (e) {
                                    findPasswordFormKey.currentState.validate();
                                  },
                                  validator: (value) {
                                    if (value.length == 0) {
                                      setState(() {
                                        formCheckFlag = false;
                                      });
                                      return '密保答案不可为空';
                                    } else {
                                      setState(() {
                                        formCheckFlag = true;
                                      });
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10.0),
                                    icon: Icon(Icons.question_answer_outlined),
                                    labelText: '密保答案',
                                  )),
                            ],
                          )),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 70, 0, 0),
                        child: RaisedButton(
                          disabledColor: Colors.grey,
                          shape: CircleBorder(
                              side: BorderSide(color: Colors.transparent)),
                          color: Colors.black,
                          elevation: 5,
                          onPressed: formCheckFlag ? _findPassword : null,
                          child: Center(
                            child: Icon(
                              questionVisible
                                  ? Icons.send_rounded
                                  : Icons.search_rounded,
                              color:
                                  formCheckFlag ? Colors.orange : Colors.white,
                            ),
                          ),
                        ),
                        width: 65,
                        height: 65,
                      ),
                    ],
                  )),
            ))
          ],
        ));
  }

  void _checkUser() async {
    var data = {"phone": phoneController.text};
    var user = new User(data);
    var checkUserFlag = await user.checkUser();
    if (checkUserFlag) {
      var userInfo = await user.getInfo();
      setState(() {
        questionVisible = true;
        formCheckFlag = false;
        questionController.text = userInfo["question"];
      });
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return new AlertDialog(
              title: new Text('提示'),
              content: new SingleChildScrollView(
                child: new ListBody(
                  children: <Widget>[
                    new Text('账号不存在'),
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

  _findPassword() async {
    if (!questionVisible) {
      _checkUser();
      return;
    }

    var data = {
      "phone": phoneController.text,
      "question": questionController.text,
      "answer": answerController.text
    };
    var user = new User(data);
    //判断密保正误,对了就初始化密码，并提示密码已被初始化，点击确定跳转到登陆页面
    if (await user.checkQuestionAnswer()) {
      user.passwordInit();
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return new AlertDialog(
              title: new Text('提示'),
              content: new SingleChildScrollView(
                child: new ListBody(
                  children: <Widget>[
                    new Text('密保答案正确，密码已被初始化为123456，请立即登陆'),
                  ],
                ),
              ),
              actions: <Widget>[
                new FlatButton(
                  child: new Text('确定'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => login001()));
                  },
                ),
              ],
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return new AlertDialog(
              title: new Text('提示'),
              content: new SingleChildScrollView(
                child: new ListBody(
                  children: <Widget>[
                    new Text('密保答案不正常，请重试'),
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
