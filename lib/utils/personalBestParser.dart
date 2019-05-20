class PersonalBestParser {
  String modes = '';
  String time = '';
  String percent = '';
  String ts = '';

  String title;
  String subtitle;
  String trailing;

  PersonalBestParser(String input) {
    if (input.endsWith('s')) {
      List<String> temp = input.split('#');
      List<String> temp2 = temp.elementAt(0).split('&');
      modes = temp2.elementAt(1);
      time = temp.elementAt(1).split('@').elementAt(1);
      percent = temp.elementAt(1).split('@').elementAt(0);
      ts = temp2.elementAt(0);
    }

    title = modes.replaceAll('Modes.', '').toUpperCase();
    subtitle = (percent.isEmpty) ? percent : percent + ' in ' + time;
    trailing = (ts.isEmpty) ? '-' : ts;
  }

  String getPesonalBestTitle() {
    return title;
  }

  String getPesonalBestSubtitle() {
    return subtitle;
  }

  String getPesonalBestTrailing() {
    return trailing;
  }
}
