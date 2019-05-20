import 'package:flutter/material.dart';
import '../model/MainModel.dart';
import '../widgets/sideDrawer.dart';
import './rankingTab.dart';
import '../utils/helper.dart';

// class Ranking extends StatefulWidget {
//   final MainModel model;

//   Ranking(this.model);

//   @override
//   State<StatefulWidget> createState() {
//     return _Ranking();
//   }
// }

// class _Ranking extends State<Ranking> {
//   @override
//   initState() {
//     widget.model.fetchRanking(true, true, Modes.add);
//     widget.model.fetchRanking(true, true, Modes.sub);
//     widget.model.fetchRanking(true, true, Modes.mul);
//     widget.model.fetchRanking(true, true, Modes.div);
//     widget.model.fetchRanking(true, false, Modes.add);
//     widget.model.fetchRanking(true, false, Modes.sub);
//     widget.model.fetchRanking(true, false, Modes.mul);
//     widget.model.fetchRanking(true, false, Modes.div);
//     //widget.model.sortRanking();
//     super.initState();
//   }

class Ranking extends StatelessWidget {
  final MainModel model;

  Ranking(this.model);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.pushReplacementNamed(context, '/');
          return Future.value(false);
        },
        child: DefaultTabController(
          length: 8,
          child: Scaffold(
            drawer: SideDrawer(),
            appBar: AppBar(
              title: Text('Global Ranking'),
              bottom: TabBar(
                tabs: <Widget>[
                  // Tab(
                  //   icon: Icon(Icons.create),
                  //   text: 'Apprentice - Monthly',
                  // ),
                  // Tab(
                  //   icon: Icon(Icons.list),
                  //   text: 'Wizard - Monthly',
                  // ),
                  Tab(
                    icon: Icon(Icons.apps),
                    text: '+',
                  ),
                  Tab(
                    icon: Icon(Icons.apps),
                    text: '-',
                  ),
                  Tab(
                    icon: Icon(Icons.apps),
                    text: 'x',
                  ),
                  Tab(
                    icon: Icon(Icons.apps),
                    text: '÷',
                  ),
                  Tab(
                    icon: Icon(Icons.blur_circular),
                    text: '+',
                  ),
                  Tab(
                    icon: Icon(Icons.blur_circular),
                    text: '-',
                  ),
                  Tab(
                    icon: Icon(Icons.blur_circular),
                    text: 'x',
                  ),
                  Tab(
                    icon: Icon(Icons.blur_circular),
                    text: '÷',
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                // PersonalBestTab(false),
                // PersonalBestTab(true),
                RankingTab(false, 'Apprentice ranking - Add', Modes.add, model),
                RankingTab(false, 'Apprentice ranking - Sub', Modes.sub, model),
                RankingTab(false, 'Apprentice ranking - Mul', Modes.mul, model),
                RankingTab(false, 'Apprentice ranking - Div', Modes.div, model),
                RankingTab(true, 'Wizard ranking - Add', Modes.add, model),
                RankingTab(true, 'Wizard ranking - Sub', Modes.sub, model),
                RankingTab(true, 'Wizard ranking - Mul', Modes.mul, model),
                RankingTab(true, 'Wizard ranking - Div', Modes.div, model),
              ],
            ),
          ),
        ));
  }
}
