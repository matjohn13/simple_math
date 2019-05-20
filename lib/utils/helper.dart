import 'package:flutter/material.dart';
import 'dart:math';

enum Modes { add, sub, mul, div }

class Helper {
  TextStyle getQuestionTextStyles() {
    return TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.deepPurpleAccent,
        fontSize: 45.0);
  }

  TextStyle getAnswerTextStyles() {
    return TextStyle(
        fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 25.0);
  }

  TextStyle getButtonTextStyles() {
    return TextStyle(
        fontWeight: FontWeight.bold, color: Colors.red, fontSize: 30.0);
  }

  DecorationImage buildBackgroundImage() {
    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
      image: AssetImage('assets/arena_bg_p.png'),
    );
  }

  DecorationImage buildBackgroundImageFlex(bool titanMode) {
    String asset =
        (titanMode) ? 'assets/bg_titan_ver.png' : 'assets/arena_bg_p.png';
    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.dstATop),
      image: AssetImage(asset),
    );
  }

  int getWrongAnswerModes(int key, int answer, int a, int b, Modes mode) {
    if (key == 0) {
      return answer + 1;
    } else if (key == 1) {
      return answer + 10;
    } else if (key == 2) {
      int length = answer.toString().length;
      if (length > 1) {
        return (int.parse(answer.toString().split('').reversed.join())) ==
                answer
            ? answer + 4
            : (int.parse(answer.toString().split('').reversed.join()));
      } else {
        return answer + 5;
      }
    } else if (key == 3) {
      return answer + 2;
    }

    Random rand = new Random();

    switch (mode) {
      case Modes.add:
        return (a + b - (1 + rand.nextInt(b))) == answer
            ? answer + 5
            : (a + b - (1 + rand.nextInt(b)));
        break;

      case Modes.sub:
        return a - (1 + rand.nextInt(a)) == answer
            ? answer + 6
            : a - (1 + rand.nextInt(a));
        break;

      case Modes.mul:
        return (a + 1) * b == answer ? answer + 8 : (a + 1) * b;
        break;

      case Modes.div:
        return answer - 1 == 0 ? (a == answer ? answer + 1 : a) : answer - 1;
        break;
    }
  }

  int getWrongAnswer(int key, int answer, int a, int b, Modes mode) {
    switch (key) {
      case 0:
        //plus 1
        return answer + 1;
        break;
      case 1:
        //plus 2
        return answer + 2;
        break;
      case 2:
        //slight a
        switch (mode) {
          case Modes.add:
            return (a + 3) + b;
            break;
          case Modes.sub:
            return (a - 1) - b;
            break;
          case Modes.mul:
            return (a + 1) * b;
            break;
          case Modes.div:
            return answer + a;
            break;
          default:
        }
        break;
      case 3:
        //flip
        int length = answer.toString().length;
        if (length > 1) {
          return int.parse(answer.toString().split('').reversed.join());
        } else {
          return answer + 5;
        }
        break;
      case 4:
        //random
        Random rand = new Random();
        if (a > b && answer > b) {
          int x = b + rand.nextInt(answer - b);
          return x != answer ? x : x + (answer.isEven ? 2 : 8);
        } else if (b > a && answer > a) {
          int x = a + rand.nextInt(answer - a);
          return x != answer ? x : x + (answer.isEven ? 4 : 10);
        } else {
          int x = rand.nextInt(answer);
          return x != answer ? x : x + (answer.isEven ? 2 : 6);
        }
        break;
      case 5:
        // negiate
        int x = answer.abs().ceil() * 2 - answer;
        return x != answer ? x : x + (answer.isEven ? 2 : a);
        break;
      //modulus
      case 6:
        int x = Random().nextInt(answer + 10);
        return x != answer ? x : x + (answer.isEven ? 2 : a);
        break;
      case 7:
        //plus 10
        return answer + 10;
        break;
      case 8:
        int x = a + a;
        return x != answer ? x : x + (answer.isEven ? 2 : 6);
        break;
      case 9:
        //minus 10
        int x;
        if (answer > 10) {
          x = answer - 10;
        } else {
          x = answer + 9;
        }

        return x != answer ? x : x + (answer.isEven ? 2 : 4);
        break;
      default:
    }
  }

  String getPersonalBestPercent(String input) {
    return input.split('#')[1].split('@')[0];
  }

  String getPersonalBestTime(String input) {
    return input.split('#')[1].split('@')[1];
  }

  String getSymbolAssetPath(bool hard, Modes mode) {
    if (hard) {
      switch (mode) {
        case Modes.add:
          return 'assets/add_h.png';
          break;

        case Modes.sub:
          return 'assets/sub_h.png';
          break;

        case Modes.mul:
          return 'assets/mul_h.png';
          break;

        case Modes.div:
          return 'assets/div_h.png';
          break;
      }
    } else {
      switch (mode) {
        case Modes.add:
          return 'assets/add_s.png';
          break;

        case Modes.sub:
          return 'assets/sub_s.png';
          break;

        case Modes.mul:
          return 'assets/mul_s.png';
          break;

        case Modes.div:
          return 'assets/div_s.png';
          break;
      }
    }
  }
}
