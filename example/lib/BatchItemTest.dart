import 'package:example/BatchItem.dart';
import 'package:built_value/built_value.dart';
import 'package:example/Score.dart';

part 'BatchItemTest.g.dart';

abstract class BatchItemTest
    implements BatchItem, Built<BatchItemTest, BatchItemTestBuilder> {
  List<int> get lectureIds;
  int get orderId;

  ///We add testsForStages and testsForRandom, ie random ones are the testsForRandom, the testsForStages
  /// are the ones the user must complete to progress to the next level
  bool get isStageTest;

  ///Based on the seconds of the batchtype, for everytime it is answered incorrectly we divide by two & round down
  ///Based on the seconds of the batchtype
  Score get score;

  int get incorrectCount;

  BatchItemTest._();
  factory BatchItemTest(List<int> lectureIds, bool isStageTest, Score score) =>
      _$BatchItemTest._(
        lectureIds: lectureIds,
        isStageTest: isStageTest,
        score: score,
        orderId: 0,
        incorrectCount: 0,
      );

  @override
  List<int> getLectureIds() {
    return lectureIds;
  }
}
