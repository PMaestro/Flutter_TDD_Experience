import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_studing/core/error/exceptions.dart';
import 'package:tdd_studing/core/error/failures.dart';
import 'package:tdd_studing/core/network/network_info.dart';
import 'package:tdd_studing/features/hero_info/data/datasources/hero_info_local_data_source.dart';
import 'package:tdd_studing/features/hero_info/data/datasources/hero_info_remote_data_source.dart';
import 'package:tdd_studing/features/hero_info/data/models/appearance_model.dart';
import 'package:tdd_studing/features/hero_info/data/models/hero_model.dart';
import 'package:tdd_studing/features/hero_info/data/models/power_stats_model.dart';
import 'package:tdd_studing/features/hero_info/data/repositories/hero_info_repository_imp.dart';
import 'package:tdd_studing/features/hero_info/domain/entities/hero.dart';

class MockRemoteDataSource extends Mock implements HeroInfoRemoteDataSource {}

class MockLocalDataSource extends Mock implements HeroInfoLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  HeroInfoRepositoryImpl repository;

  MockRemoteDataSource mockRemoteDataSource;

  MockLocalDataSource mockLocalDataSource;

  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = HeroInfoRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  group('getHeroInfo', () {
    final tId = '70';

    final tHeroModel = HeroModel(
      response: 'success',
      id: '70',
      name: 'Batman',
      imageUrl:
          'httpss://www.superherodb.com/pictures2/portraits/10/100/639.jpg',
      appearance: AppearanceModel(
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
      powerStats: PowerStatsModel(
        intelligence: '100',
        power: '47',
        speed: '27',
        strength: '26',
        combat: '100',
        durability: '50',
      ),
    );

    final Hero tHero = tHeroModel;

    runTestOnline(() {
      test(
          'should return remote data when the call to remote data source is successeful',
          () async {
        //arrange
        when(mockRemoteDataSource.getHero(any))
            .thenAnswer((_) async => tHeroModel);
        //act
        final result = await repository.getHero(tId);

        //assert
        verify(mockRemoteDataSource.getHero(tId));
        expect(result, equals(Right(tHero)));
      });

      test(
          'should cache the data localy when the call to remote data source is successeful',
          () async {
        //arrange
        when(mockRemoteDataSource.getHero(any))
            .thenAnswer((_) async => tHeroModel);
        //act
        final result = await repository.getHero(tId);

        //assert
        verify(mockRemoteDataSource.getHero(tId));
        verify(mockLocalDataSource.cacheHero(tHeroModel));
      });

      test(
          'should return server Failure when the call to remote data source is unsuccesseful',
          () async {
        //arrange
        when(mockRemoteDataSource.getHero(any)).thenThrow(
            ServerException('Error during comunication with server'));
        //act
        final result = await repository.getHero(tId);

        //assert
        verify(mockRemoteDataSource.getHero(tId));
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestOffline(() {
      test(
          'should return last locally cached data when the cached data is presented',
          () async {
        //arrange
        when(mockLocalDataSource.getLastHero())
            .thenAnswer((_) async => tHeroModel);
        //act
        final result = await repository.getHero(tId);
        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastHero());
        expect(result, equals(Right(tHeroModel)));
      }); //locally cached

      test('should return CacheFailure when there is no chached data present',
          () async {
        //arrange
        when(mockLocalDataSource.getLastHero())
            .thenThrow(CacheException('No data cached'));
        //act
        final result = await repository.getHero(tId);
        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastHero());
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });

  group('getRandomHeroInfo', () {
    final tHeroModel = HeroModel(
      response: 'success',
      id: '100',
      name: 'Black Flash',
      imageUrl:
          'httpss://www.superherodb.com/pictures2/portraits/10/100/639.jpg',
      appearance: AppearanceModel(
          eyeColor: "-",
          hairColor: "-",
          race: 'God \/ Eternal',
          gender: 'Male',
          height: ["-", "0 cm"],
          weight: ["- lb", "0 kg"]),
      powerStats: PowerStatsModel(
        intelligence: '44',
        power: '100',
        speed: '100',
        strength: '10',
        combat: '30',
        durability: '80',
      ),
    );

    final Hero tHero = tHeroModel;

    runTestOnline(() {
      test(
          'should return remote data when the call to remote data source is successeful',
          () async {
        //arrange
        when(mockRemoteDataSource.getRandomHero())
            .thenAnswer((_) async => tHeroModel);
        //act
        final result = await repository.getRandomHero();

        //assert
        verify(mockRemoteDataSource.getRandomHero());
        expect(result, equals(Right(tHero)));
      });

      test(
          'should cache the data localy when the call to remote data source is successeful',
          () async {
        //arrange
        when(mockRemoteDataSource.getRandomHero())
            .thenAnswer((_) async => tHeroModel);
        //act
        final result = await repository.getRandomHero();

        //assert
        verify(mockRemoteDataSource.getRandomHero());
        verify(mockLocalDataSource.cacheHero(tHeroModel));
      });

      test(
          'should return server Failure when the call to remote data source is unsuccesseful',
          () async {
        //arrange
        when(mockRemoteDataSource.getRandomHero()).thenThrow(
            ServerException('Error during comunication with server'));
        //act
        final result = await repository.getRandomHero();

        //assert
        verify(mockRemoteDataSource.getRandomHero());
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestOffline(() {
      test(
          'should return last locally cached data when the cached data is presented',
          () async {
        //arrange
        when(mockLocalDataSource.getLastHero())
            .thenAnswer((_) async => tHeroModel);
        //act
        final result = await repository.getRandomHero();
        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastHero());
        expect(result, equals(Right(tHeroModel)));
      }); //locally cached

      test('should return CacheFailure when there is no chached data present',
          () async {
        //arrange
        when(mockLocalDataSource.getLastHero())
            .thenThrow(CacheException('No data cached'));
        //act
        final result = await repository.getRandomHero();
        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastHero());
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });
}
