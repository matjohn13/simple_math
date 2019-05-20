import 'package:flutter/material.dart';
import '../model/MainModel.dart';
import '../widgets/sideDrawer.dart';
import '../utils/helper.dart';
import 'package:scoped_model/scoped_model.dart';
import '../utils/personalBestParser.dart';

// class PersonalBestTab extends StatefulWidget {
//   final bool titanLevel;
//   //final MainModel model;

//   PersonalBestTab(this.titanLevel);

//   @override
//   State<StatefulWidget> createState() {
//     return _PersonalBestTab();
//   }
// }

// class _PersonalBestTab extends State<PersonalBestTab> {
//   @override
//   initState() {
//     super.initState();
//   }

class PersonalBestTab extends StatelessWidget {
  final bool titanLevel;
//   //final MainModel model;

  PersonalBestTab(this.titanLevel);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SideDrawer(),
        body:
            ScopedModelDescendant<MainModel>(builder: (context, child, model) {
          return Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.7), BlendMode.dstATop),
                image: AssetImage('assets/personal_best.png'),
              )),
              child: Center(
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(model.helper
                            .getSymbolAssetPath(titanLevel, Modes.add)),
                      ),
                      title: Text(PersonalBestParser(
                              model.getPersonalBest(Modes.add, titanLevel))
                          .getPesonalBestTitle()),
                      subtitle: Text(
                        PersonalBestParser(
                                model.getPersonalBest(Modes.add, titanLevel))
                            .getPesonalBestSubtitle(),
                        style: TextStyle(color: Colors.red),
                      ),
                      trailing: Text(PersonalBestParser(
                              model.getPersonalBest(Modes.add, titanLevel))
                          .getPesonalBestTrailing()),
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(model.helper
                            .getSymbolAssetPath(titanLevel, Modes.sub)),
                      ),
                      title: Text(PersonalBestParser(
                              model.getPersonalBest(Modes.sub, titanLevel))
                          .getPesonalBestTitle()),
                      subtitle: Text(
                          PersonalBestParser(
                                  model.getPersonalBest(Modes.sub, titanLevel))
                              .getPesonalBestSubtitle(),
                          style: TextStyle(color: Colors.red)),
                      trailing: Text(PersonalBestParser(
                              model.getPersonalBest(Modes.sub, titanLevel))
                          .getPesonalBestTrailing()),
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(model.helper
                            .getSymbolAssetPath(titanLevel, Modes.mul)),
                      ),
                      title: Text(PersonalBestParser(
                              model.getPersonalBest(Modes.mul, titanLevel))
                          .getPesonalBestTitle()),
                      subtitle: Text(
                          PersonalBestParser(
                                  model.getPersonalBest(Modes.mul, titanLevel))
                              .getPesonalBestSubtitle(),
                          style: TextStyle(color: Colors.red)),
                      trailing: Text(PersonalBestParser(
                              model.getPersonalBest(Modes.mul, titanLevel))
                          .getPesonalBestTrailing()),
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(model.helper
                            .getSymbolAssetPath(titanLevel, Modes.div)),
                      ),
                      title: Text(PersonalBestParser(
                              model.getPersonalBest(Modes.div, titanLevel))
                          .getPesonalBestTitle()),
                      subtitle: Text(
                          PersonalBestParser(
                                  model.getPersonalBest(Modes.div, titanLevel))
                              .getPesonalBestSubtitle(),
                          style: TextStyle(color: Colors.red)),
                      trailing: Text(PersonalBestParser(
                              model.getPersonalBest(Modes.div, titanLevel))
                          .getPesonalBestTrailing()),
                    ),
                  ],
                ),
              ));
        }));
  }
}
