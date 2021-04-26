import 'package:flutter/material.dart';
import 'package:flutterapp1/5120182572/index.dart';
import '5120182572/_login_001.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  //原有android项目集成flutter运行报错MissingPluginException(No implementation found for method getAll on channel
  //在使用网上的方法后，错误为MissingPluginException(No implementation found for method getAll on channel
  SharedPreferences.setMockInitialValues({});
  runApp(myApp());
}

class myApp extends StatelessWidget{
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title:'移动互联网实验1',
      home: Scaffold(
        appBar: AppBar(
          title: Text('第8组移动互联网实验'),
        ),
        body: MyWidget(),
      ),
        theme: ThemeData(
            primarySwatch: Colors.orange
        )
    );
  }
}

class MyWidget extends StatelessWidget{
  Widget build(BuildContext context){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RaisedButton(
            child: Text('5120182572朱俊翰'),
            onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context)=> indexPage())
              );
            },
          )
        ],
      ),
    );
  }
}