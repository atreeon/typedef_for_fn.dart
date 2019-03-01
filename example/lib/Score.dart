import 'package:adi_helpers/toAlias.dart';
import 'package:example/TestType.dart';

class ScoreRandom = Score with ToAlias;
class ScoreStaged = Score with ToAlias;

class Score {
  final TestType testType;
  final int score;
  final int max;

  const Score(this.testType, this.score, this.max);

  List<int> toArray() {
    return [testType.index, score, max];
  }
}
