class HistoryParser {
  String modes = '';
  String marks = '';
  String time = '';
  String percent = '';
  String ts = '';
  String level = '';

  String title;
  String subtitle;
  String trailing;

  HistoryParser(String input) {
    if (input.endsWith('&')) {
      List<String> temp = input.split('&');
      modes = temp.elementAt(0);
      marks = temp.elementAt(1);
      time = temp.elementAt(2);
      percent = temp.elementAt(3);
      ts = temp.elementAt(4);
      level = temp.elementAt(5);
    }

    String levelString = level.endsWith('true') ? 'wizard' : 'apprentice';
    title =
        (modes.isEmpty) ? 'no data' : modes.toUpperCase() + ': ' + levelString;
    subtitle = marks.isEmpty ? marks : percent + ' in ' + time;
    trailing = ts;
  }

  String getHistoryModes() {
    return modes;
  }

  String getHistoryMarks() {
    return marks;
  }

  String getHistoryTime() {
    return time;
  }

  String getHistoryPercent() {
    return percent;
  }

  String getHistoryTs() {
    return ts;
  }

  String getHistoryTitle() {
    return title;
  }

  String getHistorySubtitle() {
    return subtitle;
  }

  String getHistoryTrailing() {
    return trailing;
  }

  String getSymbolAssetPath() {
    if (level.endsWith('true')) {
      switch (modes) {
        case 'add':
          return 'assets/add_h.png';
          break;

        case 'sub':
          return 'assets/sub_h.png';
          break;

        case 'mul':
          return 'assets/mul_h.png';
          break;

        case 'div':
          return 'assets/div_h.png';
          break;
      }
    } else {
      switch (modes) {
        case 'add':
          return 'assets/add_s.png';
          break;

        case 'sub':
          return 'assets/sub_s.png';
          break;

        case 'mul':
          return 'assets/mul_s.png';
          break;

        case 'div':
          return 'assets/div_s.png';
          break;
      }
    }

    return 'assets/default.png';
  }
}
