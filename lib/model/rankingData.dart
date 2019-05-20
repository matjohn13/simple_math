import 'package:flutter/material.dart';

class RankingData {
  final String id;
  final String percent;
  final String time;
  final String timestamp;
  final String userName;
  final String userTweet;

  RankingData(
      {@required this.id,
      @required this.percent,
      @required this.time,
      @required this.timestamp,
      @required this.userName,
      @required this.userTweet});
}
