import 'package:flutter/material.dart';
import '../model/MainModel.dart';
import '../widgets/sideDrawer.dart';

class About extends StatefulWidget {
  final MainModel model;

  About(this.model);

  @override
  State<StatefulWidget> createState() {
    return _About();
  }
}

class _About extends State<About> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SideDrawer(),
        appBar: AppBar(
          title: Text('About'),
        ),
        body: Container(
            decoration: BoxDecoration(),
            child: Center(
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('assets/add2.png'),
                    ),
                    title: Text('test'),
                    subtitle: Text('test sub'),
                    trailing: Text('test trail'),
                  ),
                ],
              ),
            )));
  }
}
