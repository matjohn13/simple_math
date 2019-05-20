import 'package:flutter/material.dart';
import '../model/MainModel.dart';
import '../widgets/sideDrawer.dart';
import '../utils/helper.dart';
import 'package:scoped_model/scoped_model.dart';
import '../utils/rankingParser.dart';

class RankingTab extends StatefulWidget {
  final bool wizardLevel;
  final String title;
  final Modes mode;
  final MainModel model;

  RankingTab(this.wizardLevel, this.title, this.mode, this.model);
  @override
  State<StatefulWidget> createState() {
    return _RankingTab();
  }
}

class _RankingTab extends State<RankingTab> {
  @override
  void initState() {
    widget.model.fetchRanking(true, widget.wizardLevel, widget.mode);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        //drawer: SideDrawer(),
        body:
            ScopedModelDescendant<MainModel>(builder: (context, child, model) {
          return (model.isLoading)
              ? Center(child: CircularProgressIndicator())
              : Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.7), BlendMode.dstATop),
                    image: AssetImage('assets/ranking.png'),
                  )),
                  child: Center(
                    child: ListView(
                      children: <Widget>[
                        SizedBox(
                          height: 20.0,
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(widget.model.helper
                                .getSymbolAssetPath(
                                    widget.wizardLevel, widget.mode)),
                          ),
                          title: Text(
                              RankingParser(model.getRankingEntry(
                                      widget.wizardLevel, 0, widget.mode))
                                  .getRankingTitle(),
                              style: TextStyle(color: Colors.red)),
                          subtitle: Text(RankingParser(model.getRankingEntry(
                                  widget.wizardLevel, 0, widget.mode))
                              .getRankingSubtitle()),
                          trailing: Text(
                              RankingParser(model.getRankingEntry(
                                      widget.wizardLevel, 0, widget.mode))
                                  .getRankingTrailing(),
                              style: TextStyle(fontSize: 10)),
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(widget.model.helper
                                .getSymbolAssetPath(
                                    widget.wizardLevel, widget.mode)),
                          ),
                          title: Text(RankingParser(model.getRankingEntry(
                                  widget.wizardLevel, 1, widget.mode))
                              .getRankingTitle()),
                          subtitle: Text(RankingParser(model.getRankingEntry(
                                  widget.wizardLevel, 1, widget.mode))
                              .getRankingSubtitle()),
                          trailing: Text(
                            RankingParser(model.getRankingEntry(
                                    widget.wizardLevel, 1, widget.mode))
                                .getRankingTrailing(),
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(widget.model.helper
                                .getSymbolAssetPath(
                                    widget.wizardLevel, widget.mode)),
                          ),
                          title: Text(RankingParser(model.getRankingEntry(
                                  widget.wizardLevel, 2, widget.mode))
                              .getRankingTitle()),
                          subtitle: Text(RankingParser(model.getRankingEntry(
                                  widget.wizardLevel, 2, widget.mode))
                              .getRankingSubtitle()),
                          trailing: Text(
                              RankingParser(model.getRankingEntry(
                                      widget.wizardLevel, 2, widget.mode))
                                  .getRankingTrailing(),
                              style: TextStyle(fontSize: 10)),
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(widget.model.helper
                                .getSymbolAssetPath(
                                    widget.wizardLevel, widget.mode)),
                          ),
                          title: Text(RankingParser(model.getRankingEntry(
                                  widget.wizardLevel, 3, widget.mode))
                              .getRankingTitle()),
                          subtitle: Text(RankingParser(model.getRankingEntry(
                                  widget.wizardLevel, 3, widget.mode))
                              .getRankingSubtitle()),
                          trailing: Text(
                              RankingParser(model.getRankingEntry(
                                      widget.wizardLevel, 3, widget.mode))
                                  .getRankingTrailing(),
                              style: TextStyle(fontSize: 10)),
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(widget.model.helper
                                .getSymbolAssetPath(
                                    widget.wizardLevel, widget.mode)),
                          ),
                          title: Text(RankingParser(model.getRankingEntry(
                                  widget.wizardLevel, 4, widget.mode))
                              .getRankingTitle()),
                          subtitle: Text(RankingParser(model.getRankingEntry(
                                  widget.wizardLevel, 4, widget.mode))
                              .getRankingSubtitle()),
                          trailing: Text(
                              RankingParser(model.getRankingEntry(
                                      widget.wizardLevel, 4, widget.mode))
                                  .getRankingTrailing(),
                              style: TextStyle(fontSize: 10)),
                        ),
                      ],
                    ),
                  ));
        }));
  }
}
