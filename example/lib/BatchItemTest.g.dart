// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BatchItemTest.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_catches_without_on_clauses
// ignore_for_file: avoid_returning_this
// ignore_for_file: lines_longer_than_80_chars
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first
// ignore_for_file: unnecessary_const
// ignore_for_file: unnecessary_new
// ignore_for_file: test_types_in_equals

class _$BatchItemTest extends BatchItemTest {
  @override
  final List<int> lectureIds;
  @override
  final int orderId;
  @override
  final bool isStageTest;
  @override
  final Score score;
  @override
  final int incorrectCount;
  @override
  final bool isComplete;

  factory _$BatchItemTest([void updates(BatchItemTestBuilder b)]) =>
      (new BatchItemTestBuilder()..update(updates)).build();

  _$BatchItemTest._(
      {this.lectureIds,
      this.orderId,
      this.isStageTest,
      this.score,
      this.incorrectCount,
      this.isComplete})
      : super._() {
    if (lectureIds == null) {
      throw new BuiltValueNullFieldError('BatchItemTest', 'lectureIds');
    }
    if (orderId == null) {
      throw new BuiltValueNullFieldError('BatchItemTest', 'orderId');
    }
    if (isStageTest == null) {
      throw new BuiltValueNullFieldError('BatchItemTest', 'isStageTest');
    }
    if (score == null) {
      throw new BuiltValueNullFieldError('BatchItemTest', 'score');
    }
    if (incorrectCount == null) {
      throw new BuiltValueNullFieldError('BatchItemTest', 'incorrectCount');
    }
    if (isComplete == null) {
      throw new BuiltValueNullFieldError('BatchItemTest', 'isComplete');
    }
  }

  @override
  BatchItemTest rebuild(void updates(BatchItemTestBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  BatchItemTestBuilder toBuilder() => new BatchItemTestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BatchItemTest &&
        lectureIds == other.lectureIds &&
        orderId == other.orderId &&
        isStageTest == other.isStageTest &&
        score == other.score &&
        incorrectCount == other.incorrectCount &&
        isComplete == other.isComplete;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, lectureIds.hashCode), orderId.hashCode),
                    isStageTest.hashCode),
                score.hashCode),
            incorrectCount.hashCode),
        isComplete.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BatchItemTest')
          ..add('lectureIds', lectureIds)
          ..add('orderId', orderId)
          ..add('isStageTest', isStageTest)
          ..add('score', score)
          ..add('incorrectCount', incorrectCount)
          ..add('isComplete', isComplete))
        .toString();
  }
}

class BatchItemTestBuilder
    implements Builder<BatchItemTest, BatchItemTestBuilder> {
  _$BatchItemTest _$v;

  List<int> _lectureIds;
  List<int> get lectureIds => _$this._lectureIds;
  set lectureIds(List<int> lectureIds) => _$this._lectureIds = lectureIds;

  int _orderId;
  int get orderId => _$this._orderId;
  set orderId(int orderId) => _$this._orderId = orderId;

  bool _isStageTest;
  bool get isStageTest => _$this._isStageTest;
  set isStageTest(bool isStageTest) => _$this._isStageTest = isStageTest;

  Score _score;
  Score get score => _$this._score;
  set score(Score score) => _$this._score = score;

  int _incorrectCount;
  int get incorrectCount => _$this._incorrectCount;
  set incorrectCount(int incorrectCount) =>
      _$this._incorrectCount = incorrectCount;

  bool _isComplete;
  bool get isComplete => _$this._isComplete;
  set isComplete(bool isComplete) => _$this._isComplete = isComplete;

  BatchItemTestBuilder();

  BatchItemTestBuilder get _$this {
    if (_$v != null) {
      _lectureIds = _$v.lectureIds;
      _orderId = _$v.orderId;
      _isStageTest = _$v.isStageTest;
      _score = _$v.score;
      _incorrectCount = _$v.incorrectCount;
      _isComplete = _$v.isComplete;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BatchItemTest other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$BatchItemTest;
  }

  @override
  void update(void updates(BatchItemTestBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$BatchItemTest build() {
    final _$result = _$v ??
        new _$BatchItemTest._(
            lectureIds: lectureIds,
            orderId: orderId,
            isStageTest: isStageTest,
            score: score,
            incorrectCount: incorrectCount,
            isComplete: isComplete);
    replace(_$result);
    return _$result;
  }
}
