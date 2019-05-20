import 'package:flutter/material.dart';
import '../model/MainModel.dart';
import '../widgets/sideDrawer.dart';
import '../pages/personalBestTab.dart';

class PersonalBest extends StatelessWidget {
  final MainModel model;

  PersonalBest(this.model);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.pushReplacementNamed(context, '/');
          return Future.value(false);
        },
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            drawer: SideDrawer(),
            appBar: AppBar(
              title: Text('Personal Best'),
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(
                    icon: Icon(Icons.apps),
                    text: 'Apprentice',
                  ),
                  Tab(
                    icon: Icon(Icons.blur_circular),
                    text: 'Wizard',
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[PersonalBestTab(false), PersonalBestTab(true)],
            ),
          ),
        ));
  }
}
