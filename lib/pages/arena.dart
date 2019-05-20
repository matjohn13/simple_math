import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../model/MainModel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_admob/firebase_admob.dart';

MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  keywords: <String>['flutterio', 'beautiful apps'],
  contentUrl: 'https://flutter.io',
  birthday: DateTime.now(),
  childDirected: false,
  designedForFamilies: false,
  gender:
      MobileAdGender.male, // or MobileAdGender.female, MobileAdGender.unknown
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

class Arena extends StatelessWidget {
  Widget _buildQuestionTextField(MainModel model) {
    return Text(
      model.question + ' = ?',
      style: model.helper.getQuestionTextStyles(),
    );
  }

  Widget _buildAnswerTextField(MainModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          FlatButton(
              color: model.selectedOption == 1 ? Colors.blue : Colors.white10,
              onPressed: () {
                model.setSelectedOption(1);
              },
              child: Text('A. ' + model.answerList[0].toString(),
                  style: model.helper.getAnswerTextStyles())),
          FlatButton(
              color: model.selectedOption == 2 ? Colors.blue : Colors.white10,
              onPressed: () {
                model.setSelectedOption(2);
              },
              child: Text('B. ' + model.answerList[1].toString(),
                  style: model.helper.getAnswerTextStyles())),
          FlatButton(
              color: model.selectedOption == 3 ? Colors.blue : Colors.white10,
              onPressed: () {
                model.setSelectedOption(3);
              },
              child: Text('C. ' + model.answerList[2].toString(),
                  style: model.helper.getAnswerTextStyles())),
          FlatButton(
              color: model.selectedOption == 4 ? Colors.blue : Colors.white10,
              onPressed: () {
                model.setSelectedOption(4);
              },
              child: Text('D. ' + model.answerList[3].toString(),
                  style: model.helper.getAnswerTextStyles())),
        ]),
        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: <Widget>[
        //     FlatButton(
        //         color: model.selectedOption == 3 ? Colors.blue : Colors.white10,
        //         onPressed: () {
        //           model.setSelectedOption(3);
        //         },
        //         child: Text('C. ' + model.answerList[2].toString(),
        //             style: model.helper.getAnswerTextStyles())),
        //     FlatButton(
        //         color: model.selectedOption == 4 ? Colors.blue : Colors.white10,
        //         onPressed: () {
        //           model.setSelectedOption(4);
        //         },
        //         child: Text('D. ' + model.answerList[3].toString(),
        //             style: model.helper.getAnswerTextStyles())),
        //   ],
        // )
      ],
    );
  }

  Widget _buildControlButton(MainModel model, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        // RaisedButton(
        //   onPressed: () => {Navigator.pushReplacementNamed(context, '/')},
        //   child: Text(
        //     "Quit",
        //     style: model.helper.getButtonTextStyles(),
        //   ),
        // ),
        ButtonTheme(
            minWidth: MediaQuery.of(context).size.width * 0.9,
            height: 100,
            child: RaisedButton(
              color: Colors.teal,
              onPressed: () {
                if (model.selectedOption != 0) {
                  model.validateAnswer();
                  model.setSelectedOption(0);
                  model.generateQuestion(false);
                } else {
                  Fluttertoast.showToast(
                      msg: "Select your answer before proceed..",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIos: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
                if (model.testEnd) {
                  model
                      .fetchRanking(true, model.wizardLevel, model.mode)
                      .then((onValue) {
                    model.saveHistory().then((value) => {
                          model.updatePersonalBest().then((value) {
                            model.checkGlobalRanking();

                            String temp = '';
                            if (model.newBest && model.updateRanking) {
                              temp =
                                  'Congratulation! New personal best and global ranking entry!';
                            } else if (model.newBest) {
                              temp = 'Congratulation! New personal best!';
                            } else if (model.updateRanking) {
                              temp =
                                  'Congratulation! New global ranking entry!!';
                            }

                            showDialog<bool>(
                                context: context,
                                builder: (BuildContext context) {
                                  return SimpleDialog(
                                    title: Text('Your marks is ' +
                                        model.userTestData['testPercent'] +
                                        ' in ' +
                                        model.userTestData['testTime'] +
                                        '\n' +
                                        temp),
                                    children: <Widget>[
                                      SimpleDialogOption(
                                        onPressed: () {
                                          Navigator.pop(context, true);
                                        },
                                        child: const Text(
                                          'OK',
                                          style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.redAccent),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  );
                                }).then((bool) async {
                              if (model.updateRanking) {
                                await _showRankingDialog(context, model);
                                model.updateGlobalRanking();
                                model.updateRanking = false;
                                Navigator.pushReplacementNamed(context, '/');
                              } else {
                                myInterstitial
                                  ..load()
                                  ..show(
                                    anchorType: AnchorType.bottom,
                                    anchorOffset: 0.0,
                                  ).then((value) {
                                    Navigator.pushReplacementNamed(
                                        context, '/');
                                  });
                              }
                            });
                          })
                        });
                  });
                }
              },
              child: Text(
                "Next",
                style: model.helper.getButtonTextStyles(),
              ),
            )),
        RaisedButton(
          color: Colors.grey,
          onPressed: () => {Navigator.pushReplacementNamed(context, '/')},
          child: Text(
            "Quit",
            style: model.helper.getButtonTextStyles(),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    return WillPopScope(
        onWillPop: () {
          Navigator.pushReplacementNamed(context, '/');
          return Future.value(false);
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text('Challange Arena'),
            ),
            body: ScopedModelDescendant<MainModel>(
              builder: (context, child, model) {
                return Container(
                  decoration: BoxDecoration(
                    image: model.buildBackGroundImageFlex(),
                  ),
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: SingleChildScrollView(
                          child: Container(
                            width: targetWidth,
                            child: Column(
                              children: <Widget>[
                                _buildQuestionTextField(model),
                                SizedBox(
                                  height: 30.0,
                                ),
                                _buildAnswerTextField(model),
                                SizedBox(
                                  height: 50.0,
                                ),
                                model.isLoading
                                    ? Center(child: CircularProgressIndicator())
                                    : _buildControlButton(model, context),
                                SizedBox(
                                  height: 20.0,
                                ),
                                //Row(
                                //  mainAxisAlignment: MainAxisAlignment.center,
                                //  children: <Widget>[
                                //    Text(
                                //        model.sw.elapsed.inSeconds.toString() +
                                //           ' sec   ',
                                //       style: model.helper.getAnswerTextStyles())
                                // ],
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      model.isLoading
                          ? SizedBox()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                    model.sw.elapsed.inSeconds.toString() +
                                        ' sec   ',
                                    style: model.helper.getAnswerTextStyles())
                              ],
                            ),
                    ],
                  ),
                );
              },
            )));
  }

  Future<String> _showRankingDialog(
      BuildContext context, MainModel model) async {
    String teamName = '';
    model.userTestData['userName'] = 'John Doe';
    model.userTestData['userTweet'] = 'Just a humble genius';
    return showDialog<String>(
      context: context,
      barrierDismissible:
          false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Global Ranking Update'),
          content: new Column(
            children: <Widget>[
              new Expanded(
                  child: new TextField(
                autofocus: true,
                decoration: new InputDecoration(
                    labelText: 'Name', hintText: 'eg. Mat Jenin'),
                onChanged: (value) {
                  if (value.length > 21) {
                    model.userTestData['userName'] = value.substring(0, 21);
                  } else {
                    model.userTestData['userName'] = value;
                  }

                  teamName = value;
                },
              )),
              new Expanded(
                  child: new TextField(
                autofocus: true,
                decoration: new InputDecoration(
                    labelText: 'Remarks', hintText: 'eg. school or location'),
                onChanged: (value) {
                  if (value.length > 41) {
                    model.userTestData['userTweet'] = value.substring(0, 41);
                  } else {
                    model.userTestData['userTweet'] = value;
                  }
                },
              ))
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop(teamName);
              },
            ),
          ],
        );
      },
    );
  }
}
