import 'package:flutter/material.dart';

import 'models/apps/ifood.dart';

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
    
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Lomy'),
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

  @override
  Widget build(BuildContext context) {
    Ifood ifood = new Ifood();

    ifood.term      = "pastel";
    ifood.latitude  = "-3.809492499999999";
    ifood.longitude = "-38.58727510000001";

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<Map>(
            future: ifood.fetchRestaurants(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {

              if(!snapshot.hasData)
                return Center(child: CircularProgressIndicator(),);
              else {
                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data['merchants']['data'].length,
                  itemBuilder: (context, index) =>
                  InkWell(
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    onTap: () {
                      print(snapshot.data['merchants']['data'][index]['name']);
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: index == 0 ? 15 : 0 , right: 10),
                      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                      decoration: BoxDecoration(
                        color: Color(0xfff2f3f6),
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      ),
                      child: Text(
                        snapshot.data['merchants']['data'][index]['name'],
                        style: TextStyle(
                          color: Color(0xff999aab),  
                          fontSize: 17),
                      ),
                    ),
                  ),
                );
              }
            }
          )
    );
  }
}
