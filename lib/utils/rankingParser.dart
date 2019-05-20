import '../model/rankingData.dart';

class RankingParser {
  RankingData rd;
  String title;
  String subtitle;
  String trailing;

  RankingParser(this.rd);

  String getRankingTitle() {
    String title = rd.userName +
        ' : ' +
        rd.percent.toString() +
        ' in ' +
        rd.time.toString();
    return (title.trim().length == 5) ? '-empty slot-' : title;
  }

  String getRankingSubtitle() {
    return rd.userTweet;
  }

  String getRankingTrailing() {
    return rd.timestamp;
  }
}
