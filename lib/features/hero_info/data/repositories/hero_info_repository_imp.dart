import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:tdd_studing/core/error/exceptions.dart';
import 'package:tdd_studing/core/error/failures.dart';
import 'package:tdd_studing/core/platform/network_info.dart';
import 'package:tdd_studing/features/hero_info/data/datasources/hero_info_local_data_source.dart';
import 'package:tdd_studing/features/hero_info/data/datasources/hero_info_remote_data_source.dart';
import 'package:tdd_studing/features/hero_info/data/models/hero_model.dart';
import 'package:tdd_studing/features/hero_info/domain/entities/hero.dart';
import 'package:tdd_studing/features/hero_info/domain/repositories/hero_info_repository.dart';

//define a type to concreteOrdandomChooser function of Future<HeroModel>
typedef Future<HeroModel> _ConcreteOrRandomChooser();

class HeroInfoRepositoryImpl implements HeroInfoRepository {
  final HeroInfoRemoteDataSource remoteDataSource;
  final HeroInfoLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  HeroInfoRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, Hero>> getHero(String id) async {
    return await _getTrivia(() {
      //the method that will be used on remoteDataSource
      return remoteDataSource.getHero(id);
    });
  }

  @override
  Future<Either<Failure, Hero>> getRandomHero() async {
    return await _getTrivia(() {
      //the method that will be used on remoteDataSource
      return remoteDataSource.getRandomHero();
    });
  }

  //recieve a function as parameter that contains what kind of method will be used
  Future<Either<Failure, Hero>> _getTrivia(
      _ConcreteOrRandomChooser getHeroInfoOrRandom) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteHero = await getHeroInfoOrRandom();
        localDataSource.cacheHero(remoteHero);
        return Right(remoteHero);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localHero = await localDataSource.getLastHero();
        return Right(localHero);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
