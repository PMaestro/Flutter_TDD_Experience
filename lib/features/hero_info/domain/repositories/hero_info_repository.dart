import 'package:dartz/dartz.dart';
import 'package:tdd_studing/core/error/failures.dart';
import 'package:tdd_studing/features/hero_info/domain/entities/hero.dart';

abstract class HeroInfoRepository {
  Future<Either<Failure, Hero>> getHero(String id);
  Future<Either<Failure, Hero>> getRandomHero();
}
