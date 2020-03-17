import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_studing/core/error/failures.dart';
import 'package:tdd_studing/core/util/input_converter.dart';
import 'package:tdd_studing/features/hero_info/domain/entities/appearance.dart';
import 'package:tdd_studing/features/hero_info/domain/entities/hero.dart';
import 'package:tdd_studing/features/hero_info/domain/entities/power_stats.dart';
import 'package:tdd_studing/features/hero_info/domain/usecases/get_hero.dart';
import 'package:tdd_studing/features/hero_info/domain/usecases/get_list_of_heroes.dart';
import 'package:tdd_studing/features/hero_info/presentation/Bloc/bloc.dart';

class MockGetHeroInfo extends Mock implements GetHeroById {}

class MockGetRandomHero extends Mock implements GetRandomHero {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  HeroInfoBloc bloc;
  MockGetHeroInfo mockGetHeroInfo;
  MockGetRandomHero mockGetRandomHero;
  MockInputConverter mockInputConverter;

  setUp(() {
    mockGetHeroInfo = MockGetHeroInfo();
    mockGetRandomHero = MockGetRandomHero();
    mockInputConverter = MockInputConverter();

    bloc = HeroInfoBloc(
        byId: mockGetHeroInfo,
        randomHero: mockGetRandomHero,
        inputConverter: mockInputConverter);
  });

  test('initialState should be Empty', () {
    expect(bloc.initialState, equals(Empty()));
  });

  group('GetHeroById', () {
    final tIdString = '70';
    final tNumberParsed = int.parse(tIdString);
    final tHero = Hero(
      response: 'success',
      id: '70',
      name: 'Batman',
      imageUrl:
          'httpss://www.superherodb.com/pictures2/portraits/10/100/639.jpg',
      appearance: Appearance(
          eyeColor: 'blue',
          hairColor: 'black',
          race: 'Human',
          gender: 'Male',
          height: [
            "210 lb",
            "95 kg",
          ],
          weight: [
            "6'2",
            "188 cm",
          ]),
      powerStats: PowerStats(
        intelligence: '100',
        power: '47',
        speed: '27',
        strength: '26',
        combat: '100',
        durability: '50',
      ),
    );

    void setUpMockInputConverterSuccess() {
      when(mockInputConverter.stringToUnsignedInterger(any))
          .thenReturn(Right(tNumberParsed));
    }

    test(
        'should call the inputConverted to validade and convert the string to a unsigned interger',
        () async {
      //arrange
      setUpMockInputConverterSuccess();
      //act
      bloc.dispatch(GetHeroForExplicitId(tIdString));
      await untilCalled(mockInputConverter.stringToUnsignedInterger((any)));
      //assert
      verify(mockInputConverter.stringToUnsignedInterger((tIdString)));
    });

    test('should emit [Error] when the input is invalid', () async {
      //arrange
      when(mockInputConverter.stringToUnsignedInterger(any))
          .thenReturn(Left(InvalidInputFailure()));
      //assert later
      final expected = [
        Empty(),
        Error(message: INVALID_INPUT_FAILURE_MESSAGE),
      ];
      expectLater(bloc.state, emitsInOrder(expected));

      //act
      bloc.dispatch(GetHeroForExplicitId(tIdString));
    });

    test('should get data from the concrete use case', () async {
      //arrange
      setUpMockInputConverterSuccess();
      when(mockGetHeroInfo(any)).thenAnswer((_) async => Right(tHero));
      //act
      bloc.dispatch(GetHeroForExplicitId(tIdString));
      await untilCalled(mockGetHeroInfo(any));
      //assert
      verify(mockGetHeroInfo(Params(heroId: tNumberParsed.toString())));
    });

    test('should emit [loading, loaded] when data is gotten successfully ',
        () async {
      //arrange
      setUpMockInputConverterSuccess();
      when(mockGetHeroInfo(any)).thenAnswer((_) async => Right(tHero));
      //assert later
      final expected = [
        Empty(),
        Loading(),
        Loaded(hero: tHero),
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      //act
      bloc.dispatch(GetHeroForExplicitId(tIdString));
    });

    test('should emit [loading, Error] when getting data fails ', () async {
      //arrange
      setUpMockInputConverterSuccess();
      when(mockGetHeroInfo(any)).thenAnswer((_) async => Left(ServerFailure()));
      //assert later
      final expected = [
        Empty(),
        Loading(),
        Error(message: SERVER_FAILURE_MESSAGE),
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      //act
      bloc.dispatch(GetHeroForExplicitId(tIdString));
    });

    test(
        'should emit [loading, Error] with a proper message for the error when '
        'getting data fails', () async {
      //arrange
      setUpMockInputConverterSuccess();
      when(mockGetHeroInfo(any)).thenAnswer((_) async => Left(CacheFailure()));
      //assert later
      final expected = [
        Empty(),
        Loading(),
        Error(message: CACHE_FAILURE_MESSAGE),
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      //act
      bloc.dispatch(GetHeroForExplicitId(tIdString));
    });
  });

  group('GetRandomHero', () {
    final tHero = Hero(
      response: 'success',
      id: '70',
      name: 'Batman',
      imageUrl:
          'httpss://www.superherodb.com/pictures2/portraits/10/100/639.jpg',
      appearance: Appearance(
          eyeColor: 'blue',
          hairColor: 'black',
          race: 'Human',
          gender: 'Male',
          height: [
            "210 lb",
            "95 kg",
          ],
          weight: [
            "6'2",
            "188 cm",
          ]),
      powerStats: PowerStats(
        intelligence: '100',
        power: '47',
        speed: '27',
        strength: '26',
        combat: '100',
        durability: '50',
      ),
    );

    test('should get data from the random usecase', () async {
      //arrange

      when(mockGetRandomHero(any)).thenAnswer((_) async => Right(tHero));
      //act
      bloc.dispatch(GetHeroForRandomId());
      await untilCalled(mockGetRandomHero(any));
      //assert
      verify(mockGetRandomHero(NoParams()));
    });

    test('should emit [loading, loaded] when data is gotten successfully ',
        () async {
      //arrange
      when(mockGetRandomHero(any)).thenAnswer((_) async => Right(tHero));
      //assert later
      final expected = [
        Empty(),
        Loading(),
        Loaded(hero: tHero),
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      //act
      bloc.dispatch(GetHeroForRandomId());
    });

    test('should emit [loading, Error] when getting data fails ', () async {
      //arrange

      when(mockGetRandomHero(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      //assert later
      final expected = [
        Empty(),
        Loading(),
        Error(message: SERVER_FAILURE_MESSAGE),
      ];
      expectLater(bloc.state, emitsInOrder(expected));
      //act
      bloc.dispatch(GetHeroForRandomId());
    });

    test(
        'should emit [loading, Error] with a proper message for the error when '
        'getting data fails', () async {
      //arrange

      when(mockGetRandomHero(any))
          .thenAnswer((_) async => Left(CacheFailure()));
      //assert later
      final expected = [
        Empty(),
        Loading(),
        Error(message: CACHE_FAILURE_MESSAGE),
      ];
      bloc.dispatch(GetHeroForRandomId());
      expectLater(bloc.state, emitsInOrder(expected));
      //act
    });
  });
}
