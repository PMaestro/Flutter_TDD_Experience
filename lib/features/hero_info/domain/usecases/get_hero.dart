import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tdd_studing/core/error/failures.dart';
import 'package:tdd_studing/core/usecases/usecase.dart';
import 'package:tdd_studing/features/hero_info/domain/entities/hero.dart';
import 'package:tdd_studing/features/hero_info/domain/repositories/hero_info_repository.dart';

class GetHeroById implements UseCase<Hero, Params> {
  final HeroInfoRepository repository;

  GetHeroById(this.repository);

  Future<Either<Failure, Hero>> call(Params params) async {
    return await repository.getHero(params.heroId);
  }
}

class Params extends Equatable {
  final int heroId;

  Params({this.heroId}) : super([heroId]);
}
