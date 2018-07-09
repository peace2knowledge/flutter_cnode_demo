import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: new MyHomePage(title: 'CNode 社区'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: ListItem(),
      ),
      floatingActionButton: new FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
        onPressed: fetchTopics,
        tooltip: 'Increment',
        child: new Icon(Icons.edit),
      ),
    );
  }

 // https://cnodejs.org/api
  Future<List<dynamic>> fetchTopics () async {
    final response =
    await http.get('https://cnodejs.org/api/v1/topics?page=1');
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      print(json.decode(response.body));
      return json.decode(response.body)["data"];
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }


}

class ListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          FirstLine,
          Text(
              "最近我的好友在写项目的时候经常会抱怨数据的来源，的确对于一个前端来说，数据接口数据资源永远是Mock。网上看很多大神python，node玩的飞起。但自我感觉，并没有一套好的流程方案可以走进我们开发的流程中。为了帮助我的好友并且需要数据的你来说，可以仔细的看看整套流程。因为我也是个前端，所以知道大家需要的是什么以及处理的方案。那么就跟着我一起学习下吧！"),
          Divider(
            color: Colors.grey,
          ),
          ThirdLine
        ],
      ),
    );
  }

  Row get ThirdLine {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            SizedBox(
              width: 25.0,
                height: 25.0,
                child: new CircleAvatar(
              backgroundImage: new NetworkImage(
                  "https://user-gold-cdn.xitu.io/2018/6/24/16430b934f036086?imageView2/1/w/90/h/90/q/85/format/webp/interlace/1"),
            ),),
            Text("ddddd"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(padding: EdgeInsets.only(right: 5.0), child: Text("创建于:")),
            Padding(
              padding: EdgeInsets.only(right: 5.0),
              child: Text("2018-06-04 16:02:07"),
            )
          ],
        )
      ],
    );
  }

  Row get FirstLine {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Tag(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(padding: EdgeInsets.only(right: 5.0), child: Text("77")),
            Padding(
              padding: EdgeInsets.only(right: 5.0),
              child: Text("/"),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text("12778"),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text("16小时之前"),
            )
          ],
        )
      ],
    );
  }
}

class Tag extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      child: Text("置顶", style: TextStyle(color: Colors.white)),
    );
  }
}

class CImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      child: Text("置顶", style: TextStyle(color: Colors.white)),
    );
  }
}
