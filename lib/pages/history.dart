import 'package:flutter/material.dart';
import '../model/MainModel.dart';
import '../widgets/sideDrawer.dart';
import '../utils/historyParser.dart';

class History extends StatefulWidget {
  final MainModel model;
  History(this.model);

  @override
  State<StatefulWidget> createState() {
    return _HistoryState();
  }
}

class _HistoryState extends State<History> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.pushReplacementNamed(context, '/');
          return Future.value(false);
        },
        child: Scaffold(
            drawer: SideDrawer(),
            appBar: AppBar(
              title: Text('History'),
            ),
            body: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.7), BlendMode.dstATop),
                  image: AssetImage('assets/history.png'),
                )),
                child: Center(
                  child: ListView(
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(
                              HistoryParser(widget.model.history.elementAt(9))
                                  .getSymbolAssetPath()),
                        ),
                        title: Text(
                            HistoryParser(widget.model.history.elementAt(9))
                                .getHistoryTitle()),
                        subtitle: Text(
                            HistoryParser(widget.model.history.elementAt(9))
                                .getHistorySubtitle(),
                            style: TextStyle(color: Colors.red)),
                        trailing: Text(
                            HistoryParser(widget.model.history.elementAt(9))
                                .getHistoryTrailing()),
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(
                              HistoryParser(widget.model.history.elementAt(8))
                                  .getSymbolAssetPath()),
                        ),
                        title: Text(
                            HistoryParser(widget.model.history.elementAt(8))
                                .getHistoryTitle()),
                        subtitle: Text(
                            HistoryParser(widget.model.history.elementAt(8))
                                .getHistorySubtitle(),
                            style: TextStyle(color: Colors.red)),
                        trailing: Text(
                            HistoryParser(widget.model.history.elementAt(8))
                                .getHistoryTrailing()),
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(
                              HistoryParser(widget.model.history.elementAt(7))
                                  .getSymbolAssetPath()),
                        ),
                        title: Text(
                            HistoryParser(widget.model.history.elementAt(7))
                                .getHistoryTitle()),
                        subtitle: Text(
                            HistoryParser(widget.model.history.elementAt(7))
                                .getHistorySubtitle(),
                            style: TextStyle(color: Colors.red)),
                        trailing: Text(
                            HistoryParser(widget.model.history.elementAt(7))
                                .getHistoryTrailing()),
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(
                              HistoryParser(widget.model.history.elementAt(6))
                                  .getSymbolAssetPath()),
                        ),
                        title: Text(
                            HistoryParser(widget.model.history.elementAt(6))
                                .getHistoryTitle()),
                        subtitle: Text(
                            HistoryParser(widget.model.history.elementAt(6))
                                .getHistorySubtitle(),
                            style: TextStyle(color: Colors.red)),
                        trailing: Text(
                            HistoryParser(widget.model.history.elementAt(6))
                                .getHistoryTrailing()),
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(
                              HistoryParser(widget.model.history.elementAt(5))
                                  .getSymbolAssetPath()),
                        ),
                        title: Text(
                            HistoryParser(widget.model.history.elementAt(5))
                                .getHistoryTitle()),
                        subtitle: Text(
                            HistoryParser(widget.model.history.elementAt(5))
                                .getHistorySubtitle(),
                            style: TextStyle(color: Colors.red)),
                        trailing: Text(
                            HistoryParser(widget.model.history.elementAt(5))
                                .getHistoryTrailing()),
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(
                              HistoryParser(widget.model.history.elementAt(4))
                                  .getSymbolAssetPath()),
                        ),
                        title: Text(
                            HistoryParser(widget.model.history.elementAt(4))
                                .getHistoryTitle()),
                        subtitle: Text(
                            HistoryParser(widget.model.history.elementAt(4))
                                .getHistorySubtitle(),
                            style: TextStyle(color: Colors.red)),
                        trailing: Text(
                            HistoryParser(widget.model.history.elementAt(4))
                                .getHistoryTrailing()),
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(
                              HistoryParser(widget.model.history.elementAt(3))
                                  .getSymbolAssetPath()),
                        ),
                        title: Text(
                            HistoryParser(widget.model.history.elementAt(3))
                                .getHistoryTitle()),
                        subtitle: Text(
                            HistoryParser(widget.model.history.elementAt(3))
                                .getHistorySubtitle(),
                            style: TextStyle(color: Colors.red)),
                        trailing: Text(
                            HistoryParser(widget.model.history.elementAt(3))
                                .getHistoryTrailing()),
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(
                              HistoryParser(widget.model.history.elementAt(2))
                                  .getSymbolAssetPath()),
                        ),
                        title: Text(
                            HistoryParser(widget.model.history.elementAt(2))
                                .getHistoryTitle()),
                        subtitle: Text(
                            HistoryParser(widget.model.history.elementAt(2))
                                .getHistorySubtitle(),
                            style: TextStyle(color: Colors.red)),
                        trailing: Text(
                            HistoryParser(widget.model.history.elementAt(2))
                                .getHistoryTrailing()),
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(
                              HistoryParser(widget.model.history.elementAt(1))
                                  .getSymbolAssetPath()),
                        ),
                        title: Text(
                            HistoryParser(widget.model.history.elementAt(1))
                                .getHistoryTitle()),
                        subtitle: Text(
                            HistoryParser(widget.model.history.elementAt(1))
                                .getHistorySubtitle(),
                            style: TextStyle(color: Colors.red)),
                        trailing: Text(
                            HistoryParser(widget.model.history.elementAt(1))
                                .getHistoryTrailing()),
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(
                              HistoryParser(widget.model.history.elementAt(0))
                                  .getSymbolAssetPath()),
                        ),
                        title: Text(
                            HistoryParser(widget.model.history.elementAt(0))
                                .getHistoryTitle()),
                        subtitle: Text(
                            HistoryParser(widget.model.history.elementAt(0))
                                .getHistorySubtitle(),
                            style: TextStyle(color: Colors.red)),
                        trailing: Text(
                            HistoryParser(widget.model.history.elementAt(0))
                                .getHistoryTrailing()),
                      ),
                    ],
                  ),
                ))));
  }
}
