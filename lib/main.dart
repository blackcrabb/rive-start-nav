import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue),
        home: Scaffold(
          body: Container(
            color: Colors.black,
            child: Center(child: NavBar(),),
          ),
        ),
    );
  }
}

class MenuItem{
  final String name;
  final double x;
  MenuItem({this.name, this.x});
}

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

  List items = [
    MenuItem(x: -1.0,name: 'arrow'),
    MenuItem(x: 0.5,name: 'star')
  ];

  MenuItem active;

  @override
  void initState(){
    super.initState();
    active = items[0];
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Container(
      height: 80,
      color: Colors.black,
      child: Stack(
        children: <Widget>[
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            alignment: Alignment(active.x, -1),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 1000),
              height: 4,
              width: w * 2,
              )
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: items.map((item){
                  return _flare(item);
                }).toList(),
                ),
            )
        ],
      ),
    );
  }

  Widget _flare(MenuItem item){
    return GestureDetector(
      child: AspectRatio(
        aspectRatio: 1,
        child: Padding(
          padding: EdgeInsets.only(top: 20),
          child: FlareActor(
            'assets/${item.name}.flr',
            alignment: Alignment.center,
            fit: BoxFit.contain,
            animation: item.name == active.name ? 'go' : 'idle',
          ),
          ),),
      onTap: (){
        setState(() {
          active = item;
        });
      },
    );
  }
}