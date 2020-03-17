import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_studing/core/util/input_converter.dart';

void main() {
  InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group('stringToUnsignedInt', () {
    test(
        'should return an interger when the string represents an unsigned interger',
        () async {
      //arrange
      final str = '70';
      //act
      final result = inputConverter.stringToUnsignedInterger(str);
      //assert
      expect(result, Right(70));
    });

    test('should return fail when the string isnt a interger', () async {
      //arrange
      final str = 'aa0';
      //act
      final result = inputConverter.stringToUnsignedInterger(str);
      //assert
      expect(result, Left(InvalidInputFailure()));
    });

    test('should return fail when the string is a negative interger', () async {
      //arrange
      final str = '-70';
      //act
      final result = inputConverter.stringToUnsignedInterger(str);
      //assert
      expect(result, Left(InvalidInputFailure()));
    });
  });
}
