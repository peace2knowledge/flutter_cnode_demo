import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_html_textview/flutter_html_textview.dart';
import 'package:flutter_html_view/flutter_html_view.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: MyHomePage(title: "CNode 社区"),
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
  List<dynamic> topics;

  @override
  void initState() {
    super.initState();
    fetchTopics();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: topics != null
          ? new Center(
              child: new ListView.builder(
                padding: new EdgeInsets.all(15.0),
                itemExtent: 320.0,
                itemBuilder: (BuildContext context, int index) {
                  return ListItem(topics[index]);
                },
              ),
            )
          : new Center(
              child: Text("加载中"),
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
  Future<List<dynamic>> fetchTopics() async {
    final response = await http.get('https://cnodejs.org/api/v1/topics?page=1');
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      List<dynamic> cc = json.decode(response.body)["data"];

      setState(() {
        topics = cc;
      });
//      for (final kk in cc) {
//        Map o = kk as Map;
//        print(o);
//      }

      return cc;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }
}

class ListItem extends StatelessWidget {
  final Map itmeInfo;

  ListItem(this.itmeInfo);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            FirstLine,
            Padding(padding: EdgeInsets.only(left: 0.0),child: Text(itmeInfo["title"],style: TextStyle(fontSize: 15.0),),),
//            HtmlTextView(
//                data:),
            new HtmlTextView(data: itmeInfo["content"]),
            Divider(
              color: Colors.grey,
            ),
            ThirdLine
          ],
        ),
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
                backgroundImage: new NetworkImage(itmeInfo["author"]["avatar_url"]),
              ),
            ),
            Text(itmeInfo["author"]["loginname"]),
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

class ListViewHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("ListView Demo"),
        ),
        body: new ListView.builder(
          padding: new EdgeInsets.all(15.0),
          itemExtent: 30.0,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                leading: const Icon(Icons.person), title: Text("这是第$index"));
          },
        ));
  }
}
