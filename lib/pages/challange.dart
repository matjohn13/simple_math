import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../model/MainModel.dart';
import '../utils/helper.dart';
import '../widgets/sideDrawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_admob/firebase_admob.dart';

const appId = 'ca-app-pub-9771899800673369~6694006608';

MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  keywords: <String>['flutterio', 'beautiful apps'],
  contentUrl: 'https://flutter.io',
  birthday: DateTime.now(),
  childDirected: false,
  designedForFamilies: false,
  gender: MobileAdGender
      .unknown, // or MobileAdGender.female, MobileAdGender.unknown
  testDevices: <String>[], // Android emulators are considered test devices
);

BannerAd myBanner = BannerAd(
  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  adUnitId: 'ca-app-pub-9771899800673369/8512029890', //BannerAd.testAdUnitId,
  size: AdSize.smartBanner,
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("BannerAd event is $event");
  },
);

InterstitialAd myInterstitial = InterstitialAd(
  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  adUnitId: 'ca-app-pub-9771899800673369/8581146805',
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("InterstitialAd event is $event");
  },
);

class Challange extends StatefulWidget {
  final String title;
  Challange(this.title);
  @override
  _ChallangeState createState() => _ChallangeState();
}

class _ChallangeState extends State<Challange> {
  @override
  void initState() {
    FirebaseAdMob.instance.initialize(appId: appId);
    super.initState();
  }

  void _goToArena(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/arena');
  }

  Widget _buildChallangeImage(
      MainModel model, BuildContext context, Modes mode, String path) {
    return GestureDetector(
      onTap: () {
        showDialog<bool>(
            context: context,
            builder: (BuildContext context) {
              return SimpleDialog(
                title: Text('Timer starts after go is pressed..All the best.'),
                children: <Widget>[
                  SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: Text(
                      'GO!',
                      style: TextStyle(fontSize: 30, color: Colors.redAccent),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              );
            }).then((bool) {
          model.setArenaMode(mode);
          model.reset();
          model.generateQuestion(true);
          _goToArena(context);
        });
      },
      child: Image.asset(path),
    );
  }

  Widget _buildChallangeButton(
      MainModel model, BuildContext context, Modes mode) {
    return ButtonTheme(
      minWidth: 200.0,
      child: RaisedButton(
        onPressed: () {
          showDialog<bool>(
              context: context,
              builder: (BuildContext context) {
                return SimpleDialog(
                  title: Text('Timer start after ok is pressed..Good luck!'),
                  children: <Widget>[
                    SimpleDialogOption(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      child: Text(
                        'OK',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                );
              }).then((bool) {
            model.setArenaMode(mode);
            model.reset();
            model.generateQuestion(true);
            _goToArena(context);
          });
        },
        textColor: Colors.white,
        child: Text(mode.toString()),
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    myBanner
      // typically this happens well before the ad is shown
      ..load()
      ..show(
        // Positions the banner ad 60 pixels from the bottom of the screen
        anchorOffset: 0.0,
        // Banner Position
        anchorType: AnchorType.bottom,
      );

    return Scaffold(
      drawer: SideDrawer(),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ScopedModelDescendant<MainModel>(builder: (context, child, model) {
        return Container(
            decoration: BoxDecoration(image: model.buildBackGroundImageFlex()),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _buildChallangeImage(
                          model, context, Modes.add, 'assets/add2.png'),
                      _buildChallangeImage(
                          model, context, Modes.sub, 'assets/sub2.png'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _buildChallangeImage(
                          model, context, Modes.mul, 'assets/mul2.png'),
                      _buildChallangeImage(
                          model, context, Modes.div, 'assets/div2.png'),
                    ],
                  ),
                ],
              ),
            ));
      }),
      // Use the ScopedModelDescendant again in order to use the increment
      // method from the CounterModel
      floatingActionButton: ScopedModelDescendant<MainModel>(
        builder: (context, child, model) {
          return FloatingActionButton(
            onPressed: () {
              model.wizardLevel = model.wizardLevel ? false : true;

              if (model.wizardLevel) {
                Fluttertoast.showToast(
                    msg: "You just switch to WIZARD level ...Good Luck!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIos: 1,
                    backgroundColor: Colors.black,
                    textColor: Colors.red,
                    fontSize: 16.0);
              } else {
                Fluttertoast.showToast(
                    msg: "You just switch to APPRENTICE level ...Good Luck!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIos: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            },
            child: Icon(Icons.all_inclusive),
          );
        },
      ),
    );
  }
}
