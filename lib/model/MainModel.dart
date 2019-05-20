import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import '../utils/helper.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import './rankingData.dart';

class MainModel extends Model {
  List<String> history = new List<String>();
  List<String> personalBest = new List<String>();

  List<RankingData> rankingAllTimeHardAdd = new List<RankingData>();
  List<RankingData> rankingAllTimeHardSub = new List<RankingData>();
  List<RankingData> rankingAllTimeHardMul = new List<RankingData>();
  List<RankingData> rankingAllTimeHardDiv = new List<RankingData>();

  List<RankingData> rankingAllTimeNormalAdd = new List<RankingData>();
  List<RankingData> rankingAllTimeNormalSub = new List<RankingData>();
  List<RankingData> rankingAllTimeNormalMul = new List<RankingData>();
  List<RankingData> rankingAllTimeNormalDiv = new List<RankingData>();

  bool wizardLevel = false;
  bool updateRanking = false;
  bool isLoading = false;
  bool newBest = false;
  int remainder = 0;
  String answerString = '';
  var userTestData = new Map<String, dynamic>();
  static const int TOTAL_QUESTION = 7;
  int marks = 0;
  double percent = 0;
  bool testEnd = false;
  String _question = 'initial';
  Helper helper = Helper();
  List answerList = new List();
  int answer = 0;
  int _answerIndex = 0;
  int _selectedOption = 0;
  int _a;
  int _b;
  int _counter;
  Stopwatch sw = Stopwatch();

  Modes mode;
  String get question => _question;

  int get selectedOption => _selectedOption;

  void setSelectedOption(int value) {
    _selectedOption = value;
    notifyListeners();
  }

  void generateQuestion(bool startTimer) {
    if (startTimer) {
      sw.reset();
      sw.start();
    }

    if (_counter == TOTAL_QUESTION) {
      testEnd = true;
      sw.stop();
      userTestData['testTime'] =
          (sw.elapsedMilliseconds / 1000).toStringAsFixed(2) + 's';
      percent = (marks / TOTAL_QUESTION) * 100;
      userTestData['testMarks'] =
          (marks.toString() + ' out of ' + TOTAL_QUESTION.toString());
      userTestData['testPercent'] = percent.toStringAsFixed(2) + ' %';
      return;
    }

    answerList.clear();
    Random rand = Random();

    switch (mode) {
      case Modes.add:
        if (wizardLevel) {
          _a = 100 + rand.nextInt(5000);
          _b = 100 + rand.nextInt(5000);
        } else {
          _a = 10 + rand.nextInt(100);
          _b = 10 + rand.nextInt(50);
        }
        _question = _a.toString() + ' + ' + _b.toString();
        answer = _a + _b;
        break;
      case Modes.sub:
        if (wizardLevel) {
          _b = 100 + rand.nextInt(1000);
          _a = _b + rand.nextInt(5000);
        } else {
          _b = 10 + rand.nextInt(100);
          _a = _b + rand.nextInt(100);
        }
        _question = _a.toString() + ' - ' + _b.toString();
        answer = _a - _b;
        break;
      case Modes.mul:
        if (wizardLevel) {
          _a = 12 + rand.nextInt(20);
          _b = 12 + rand.nextInt(20);
        } else {
          _a = rand.nextInt(13);
          _b = 1 + rand.nextInt(12);
        }
        _question = _a.toString() + ' x ' + _b.toString();
        answer = _a * _b;
        break;
      case Modes.div:
        if (wizardLevel) {
          _a = 12 + rand.nextInt(20);
          _b = 12 + rand.nextInt(20);
        } else {
          _a = 1 + rand.nextInt(12);
          _b = 1 + rand.nextInt(12);
        }

        int temp = _a * _b;
        answer = _a;
        _a = temp;
        remainder = rand.nextInt(_b);
        _a = _a + remainder;
        answerString = answer.toString() + ' R' + remainder.toString();
        _question = _a.toString() + ' ÷ ' + _b.toString();

        break;
      default:
    }
    _generateOption();
    _setCorrectAnswer();
    notifyListeners();
  }

  void _setCorrectAnswer() {
    Random rand = Random();
    int index = rand.nextInt(4);
    _answerIndex = ++index;

    switch (index) {
      case 1:
        answerList[0] = mode == Modes.div ? answerString : answer;
        break;
      case 2:
        answerList[1] = mode == Modes.div ? answerString : answer;
        break;
      case 3:
        answerList[2] = mode == Modes.div ? answerString : answer;
        break;
      case 4:
        answerList[3] = mode == Modes.div ? answerString : answer;
        break;
      default:
    }
  }

  void setArenaMode(Modes mode) {
    this.mode = mode;
  }

  void _generateOption() {
    Random rand = Random();
    for (int x = 0; x < 4; x++) {
      int key = rand.nextInt(5);
      var value = helper.getWrongAnswerModes(key, answer, _a, _b, mode);
      String tempOption = value.toString();
      if (mode == Modes.div) {
        int temp = rand.nextInt(_b);
        tempOption = tempOption + ' R' + temp.toString();
      }
      if (answerList.contains(tempOption)) {
        x--;
      } else {
        answerList.add(tempOption);
      }
    }
  }

  void validateAnswer() {
    //print('selected = ' + _selectedOption.toString());
    //print('ans = ' + _answerIndex.toString());
    if (_selectedOption == _answerIndex) {
      _answerIndex = 0;
      marks++;
    }
    _counter++;
  }

  void reset() {
    testEnd = false;
    _counter = 0;
    marks = 0;
    _selectedOption = 0;
  }

  Future<Null> saveHistory() async {
    if (history.length >= 10) {
      history.removeAt(0);
    }

    userTestData['timestamp'] =
        new DateTime.now().toString().split('.').elementAt(0);

    history.add(mode.toString().replaceAll('Modes.', '') +
        '&' +
        userTestData['testMarks'] +
        '&' +
        userTestData['testTime'] +
        '&' +
        userTestData['testPercent'] +
        '&' +
        userTestData['timestamp'] +
        '&' +
        wizardLevel.toString() +
        '&');
    //print('save - ' + history.length.toString());
    //print(history.elementAt(0));
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('simple_math_history');
    prefs.setStringList('simple_math_history', history).then((bool) => {});
    notifyListeners();
  }

  void loadHistory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Enable to reset history
    //prefs.remove('simple_math_history');
    List<String> temp = prefs.getStringList('simple_math_history');

    history.clear();
    for (int i = 0; i < 10; i++) {
      history.add('');
    }

    if (temp != null) {
      //print('temp_hist! = null');
      int j = 1;
      for (int i = 9; i >= 0; i--) {
        if (temp.length - j >= 0) {
          //print('temp_elem:' + temp.elementAt(temp.length - j));
          history[i] = temp.elementAt(temp.length - j);
          j++;
        } else {
          break;
        }
      }
    }

    // if (temp == null) {
    //   print('temp_hist = null');
    //   history.clear();
    //   for (int i = 0; i < 10; i++) {
    //     history.add('');
    //   }
    // } else {
    //   print('temp_hist != null');
    //   print('i=' + temp.length.toString());
    //   history.clear();
    //   history = temp;
    // }

    //print('0_hist=' + history.elementAt(0));
    //print('_hist_length=' + history.length.toString());
    notifyListeners();
  }

  void loadPersonalBest() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> temp = prefs.getStringList('simple_math_personal_best');

    if (temp == null) {
      //print('temp = null');
    } else {
      //print('temp != null');
      //print('i=' + temp.length.toString());
      personalBest = temp;
    }
    notifyListeners();
  }

  DecorationImage buildBackGroundImageFlex() {
    notifyListeners();
    return helper.buildBackgroundImageFlex(wizardLevel);
  }

  Future<Null> updatePersonalBest() async {
    newBest = false;
    notifyListeners();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool newEntry = false;
    String identifier = mode.toString() + '&' + wizardLevel.toString() + '#';
    String result = userTestData['timestamp'] +
        '&' +
        identifier +
        userTestData['testPercent'] +
        '@' +
        userTestData['testTime'];
    int indexFocus = -1;
    if (personalBest.length == 0) {
      personalBest.add(result);
    }

    for (String element in personalBest) {
      if (element.contains(identifier)) {
        String percentString = helper.getPersonalBestPercent(element);
        String timeString = helper.getPersonalBestTime(element);

        double percentDouble =
            double.parse(percentString.replaceAll('%', '').trim());

        double currentpercentDouble = double.parse(
            userTestData['testPercent'].replaceAll('%', '').trim());

        if (percentDouble > currentpercentDouble) {
          return;
        } else if (percentDouble < currentpercentDouble) {
          indexFocus = personalBest.indexOf(element);
          break;
        } else {
          double timeDouble =
              double.parse(timeString.replaceAll('s', '').trim());
          double currentTimeDouble =
              double.parse(userTestData['testTime'].replaceAll('s', '').trim());
          if (timeDouble < currentTimeDouble) {
            return;
          } else {
            indexFocus = personalBest.indexOf(element);
            break;
          }
        }
      } else {
        newEntry = true;
      }
    }

    if (indexFocus != -1) {
      personalBest.removeAt(indexFocus);
      personalBest.add(result);
      newBest = true;
      notifyListeners();
    }

    if (newEntry) {
      personalBest.add(result);
      newBest = true;
      notifyListeners();
    }

    prefs.remove('simple_math_personal_best');
    prefs
        .setStringList('simple_math_personal_best', personalBest)
        .then((bool) => {});
  }

  String getPersonalBest(Modes pMode, bool pLevel) {
    for (String element in personalBest) {
      if (element.contains(pMode.toString() + '&' + pLevel.toString() + '#')) {
        return element;
      }
    }
    return '';
  }

  RankingData getRankingEntry(bool wizardLevel, int index, Modes mode) {
    try {
      if (wizardLevel) {
        switch (mode) {
          case Modes.add:
            return rankingAllTimeHardAdd.elementAt(index);

          case Modes.sub:
            return rankingAllTimeHardSub.elementAt(index);

          case Modes.mul:
            return rankingAllTimeHardMul.elementAt(index);

          case Modes.div:
            return rankingAllTimeHardDiv.elementAt(index);
        }
      } else {
        switch (mode) {
          case Modes.add:
            return rankingAllTimeNormalAdd.elementAt(index);

          case Modes.sub:
            return rankingAllTimeNormalSub.elementAt(index);

          case Modes.mul:
            return rankingAllTimeNormalMul.elementAt(index);

          case Modes.div:
            return rankingAllTimeNormalDiv.elementAt(index);
        }
      }
    } catch (error) {
      return RankingData(
          id: '',
          percent: '',
          time: '',
          timestamp: '',
          userName: '',
          userTweet: '');
    }
  }

  void checkGlobalRanking() {
    if (_validateCurrentResult(wizardLevel)) {
      updateRanking = true;
      notifyListeners();
    } else {
      updateRanking = false;
      notifyListeners();
    }
  }

  void updateGlobalRanking() async {
    final Map<String, dynamic> rd = {
      'percent': userTestData['testPercent'],
      'time': userTestData['testTime'],
      'timestamp': userTestData['timestamp'],
      'userName': userTestData['userName'],
      'userTweet': userTestData['userTweet']
    };

    try {
      http.Response response;
      if (wizardLevel) {
        switch (mode) {
          case Modes.add:
            response = await http.post(
                'https://simple-math-86325.firebaseio.com/rankingAllTimeHardAdd.json',
                body: json.encode(rd));
            break;

          case Modes.sub:
            response = await http.post(
                'https://simple-math-86325.firebaseio.com/rankingAllTimeHardSub.json',
                body: json.encode(rd));
            break;

          case Modes.mul:
            response = await http.post(
                'https://simple-math-86325.firebaseio.com/rankingAllTimeHardMul.json',
                body: json.encode(rd));
            break;

          case Modes.div:
            response = await http.post(
                'https://simple-math-86325.firebaseio.com/rankingAllTimeHardDiv.json',
                body: json.encode(rd));
            break;
        }
      } else {
        switch (mode) {
          case Modes.add:
            response = await http.post(
                'https://simple-math-86325.firebaseio.com/rankingAllTimeNormalAdd.json',
                body: json.encode(rd));
            break;

          case Modes.sub:
            response = await http.post(
                'https://simple-math-86325.firebaseio.com/rankingAllTimeNormalSub.json',
                body: json.encode(rd));
            break;

          case Modes.mul:
            response = await http.post(
                'https://simple-math-86325.firebaseio.com/rankingAllTimeNormalMul.json',
                body: json.encode(rd));
            break;

          case Modes.div:
            response = await http.post(
                'https://simple-math-86325.firebaseio.com/rankingAllTimeNormalDiv.json',
                body: json.encode(rd));
            break;
        }
      }

      if (response.statusCode != 200 && response.statusCode != 201) {
        isLoading = false;
        notifyListeners();
      }

      isLoading = false;
      notifyListeners();
    } catch (error) {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> _deleteRanking(String rankingRepo, String rankId) {
    isLoading = true;
    notifyListeners();

    return http
        .delete(
            'https://simple-math-86325.firebaseio.com/${rankingRepo}/${rankId}.json')
        .then((http.Response response) {
      isLoading = false;
      notifyListeners();
      return true;
    }).catchError((error) {
      isLoading = false;
      notifyListeners();
      return false;
    });
  }

  Future<Null> fetchRanking(bool allTime, bool hardLevel, Modes mode) {
    String dir;

    isLoading = true;
    notifyListeners();

    if (allTime) {
      if (hardLevel) {
        switch (mode) {
          case Modes.add:
            dir = 'rankingAllTimeHardAdd';
            break;

          case Modes.sub:
            dir = 'rankingAllTimeHardSub';
            break;

          case Modes.mul:
            dir = 'rankingAllTimeHardMul';
            break;

          case Modes.div:
            dir = 'rankingAllTimeHardDiv';
            break;
        }
      } else {
        switch (mode) {
          case Modes.add:
            dir = 'rankingAllTimeNormalAdd';
            break;

          case Modes.sub:
            dir = 'rankingAllTimeNormalSub';
            break;

          case Modes.mul:
            dir = 'rankingAllTimeNormalMul';
            break;

          case Modes.div:
            dir = 'rankingAllTimeNormalDiv';
            break;
        }
      }

      return http
          .get('https://simple-math-86325.firebaseio.com/${dir}.json')
          .then<Null>((http.Response response) {
        final List<RankingData> fetchedRankingList = [];
        final Map<String, dynamic> rankingData = json.decode(response.body);
        if (rankingData == null) {
          isLoading = false;
          notifyListeners();
          return;
        }
        rankingData.forEach((String rankingId, dynamic rankingData) {
          final RankingData rd = RankingData(
            id: rankingId,
            percent: rankingData['percent'],
            time: rankingData['time'],
            timestamp: rankingData['timestamp'],
            userName: rankingData['userName'],
            userTweet: rankingData['userTweet'],
          );
          fetchedRankingList.add(rd);
        });

        _sortRanking(fetchedRankingList, dir);

        if (allTime) {
          if (hardLevel) {
            switch (mode) {
              case Modes.add:
                rankingAllTimeHardAdd = fetchedRankingList;
                break;

              case Modes.sub:
                rankingAllTimeHardSub = fetchedRankingList;
                break;

              case Modes.mul:
                rankingAllTimeHardMul = fetchedRankingList;
                break;

              case Modes.div:
                rankingAllTimeHardDiv = fetchedRankingList;
                break;
            }
          } else {
            switch (mode) {
              case Modes.add:
                rankingAllTimeNormalAdd = fetchedRankingList;
                break;

              case Modes.sub:
                rankingAllTimeNormalSub = fetchedRankingList;
                break;

              case Modes.mul:
                rankingAllTimeNormalMul = fetchedRankingList;
                break;

              case Modes.div:
                rankingAllTimeNormalDiv = fetchedRankingList;
                break;
            }
          }
        }

        isLoading = false;
        notifyListeners();
      }).catchError((error) {
        isLoading = false;
        notifyListeners();
        return;
      });
    }
  }

  bool _validateCurrentResult(bool titanLevel) {
    double currentpercentDouble =
        double.parse(userTestData['testPercent'].replaceAll('%', '').trim());
    double currentTimeDouble =
        double.parse(userTestData['testTime'].replaceAll('s', '').trim());

    if (currentpercentDouble < 100.0) {
      return false;
    }

    List<RankingData> focusRank;
    if (titanLevel) {
      switch (mode) {
        case Modes.add:
          focusRank = rankingAllTimeHardAdd;
          break;

        case Modes.sub:
          focusRank = rankingAllTimeHardSub;
          break;

        case Modes.mul:
          focusRank = rankingAllTimeHardMul;
          break;

        case Modes.div:
          focusRank = rankingAllTimeHardDiv;
          break;
      }
    } else {
      switch (mode) {
        case Modes.add:
          focusRank = rankingAllTimeNormalAdd;
          break;

        case Modes.sub:
          focusRank = rankingAllTimeNormalSub;
          break;

        case Modes.mul:
          focusRank = rankingAllTimeNormalMul;
          break;

        case Modes.div:
          focusRank = rankingAllTimeNormalDiv;
          break;
      }
    }

    if (focusRank.length < 5) {
      return true;
    } else {
      double lastRankTime =
          double.parse(focusRank.elementAt(4).time.replaceAll('s', ''));

      if (currentTimeDouble < lastRankTime) {
        return true;
      }
    }

    return false;
  }

  void _sortRanking(List<RankingData> rd, String rankingRepo) {
    rd.sort((a, b) {
      return double.parse(a.time.replaceAll('s', ''))
          .compareTo(double.parse(b.time.replaceAll('s', '')));
    });

    if (rd.length > 5) {
      _deleteRanking(rankingRepo, rd.elementAt(5).id);
    }
  }
}
