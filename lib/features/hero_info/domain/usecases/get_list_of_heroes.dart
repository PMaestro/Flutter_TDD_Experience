import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tdd_studing/core/error/failures.dart';
import 'package:tdd_studing/core/usecases/usecase.dart';
import 'package:tdd_studing/features/hero_info/domain/entities/hero.dart';
import 'package:tdd_studing/features/hero_info/domain/repositories/hero_info_repository.dart';

class GetRandomHero implements UseCase<Hero, NoParams> {
  final HeroInfoRepository repository;

  //constructor
  GetRandomHero(this.repository);

  @override
  Future<Either<Failure, Hero>> call(NoParams params) async {
    return await repository.getRandomHero();
  }
}

class NoParams extends Equatable {}
