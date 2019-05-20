import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import './pages/challange.dart';
import './model/MainModel.dart';
import './pages/arena.dart';
import './pages/history.dart';
import './pages/personalBest.dart';
import './pages/ranking.dart';
import './pages/settings.dart';
import './pages/about.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MyApp(model: MainModel()));
  });
  // runApp(MyApp(
  //   model: MainModel(),
  // ));
}

class MyApp extends StatelessWidget {
  final MainModel model;
  const MyApp({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    model.loadHistory();
    model.loadPersonalBest();
    return ScopedModel<MainModel>(
      model: model,
      child: MaterialApp(
        title: 'Simple Math',
        builder: (BuildContext context, Widget child) {
          return new Padding(
            child: child,
            padding: const EdgeInsets.only(
              bottom: 80.0,
            ),
          );
        },
        theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: Colors.deepOrange,
            accentColor: Colors.deepPurple,
            buttonColor: Colors.deepPurple),
        //home: Challange('Simple Math'),
        routes: {
          '/': (BuildContext context) => Challange('Simple Math'),
          '/arena': (BuildContext context) => Arena(),
          '/history': (BuildContext context) => History(model),
          '/ranking': (BuildContext context) => Ranking(model),
          '/personalBest': (BuildContext context) => PersonalBest(model),
          //'/settings': (BuildContext context) => Settings(model),
          //'/about': (BuildContext context) => About(model),
        },
      ),
    );
  }
}
