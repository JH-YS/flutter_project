import 'dart:convert' as convert;
import 'dart:io';
import 'dart:async';
import 'package:flutterapp1/_user/usersList.json';

var userList = [
  {"user_id":"1","phone":"17378586631","password":"zhujunhan001","question":"我名字是？","answer":"小华"},
  {"user_id":"2","phone":"17378586632","password":"zhujunhan002","question":"我爱好是？","answer":"打羽毛球"},
  {"user_id":"3","phone":"17378586633","password":"zhujunhan003","question":"我最喜欢的颜色是？","answer":"白色"},
  {"user_id":"4","phone":"17378586634","password":"zhujunhan.123","question":"我名字是？","answer":"朱俊翰"}
];

class User{
  var phone;
  var password;

  //新增用户
  User.add(payload){
    this.phone = payload["phone"];
    this.password = payload["password"];
  }
}

//获取用户列表

bool checkUser(payload){
  for(var element in userList){
    if(element["phone"] == payload["phone"]){
      if(element["password"] == payload["password"]){
        return true;
      }
    }
  }
  return false;
}

getUserList(payload){
  for(var element in userList){
    if(element["phone"] == payload["phone"]){
      if(element["password"] == payload["password"]){
        return element;
      }
    }
  }
}


//修改用户信息
void updateUser(payload){
  print(payload);
}

//删除用户
void deleteUser(payload){
  print(payload);
}

