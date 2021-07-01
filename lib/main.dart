import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:new_app/response.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Articles> articlesList =[];

  void getdata() async {
    var url = Uri.parse(
        'https://newsapi.org/v2/everything?q=dogecoin&apiKey=62635c7880c54e13a76303a91ccce4ee');

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      NewResponse newsResp = NewResponse.fromJson(jsonResponse);
     List<Articles> list = newsResp.articlesList;
     articlesList =list;
   setState(() {
     getdata();
   });

    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text("News"),
              onPressed: () async {
               getdata();
                setState(() {
                 getdata();
                });
              },
            ),
             Expanded(
               child: ListView.builder(
                  itemCount: articlesList.length,
                  itemBuilder: (context, index) {
                    Articles articlesInfo = articlesList[index];
                    return getInfoWidget(articlesInfo);
                  }),
             ),
          ],
        ),

      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  Widget getInfoWidget(Articles articlesInfo) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: [
          Text(
            "Title = ${articlesInfo.title}",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18.0,
              color: Colors.blue,
            ),
          ),
          Text(
            "Description = ${articlesInfo.description}",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18.0,
              color: Colors.blue,
            ),
          ),

        ],
      ),
    );
  }

}

