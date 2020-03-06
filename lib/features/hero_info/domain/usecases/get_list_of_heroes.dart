import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:tdd_studing/core/error/failures.dart';
import 'package:tdd_studing/features/hero_info/domain/entities/hero.dart';
import 'package:tdd_studing/features/hero_info/domain/repositories/hero_info_repository.dart';

class GetListOfHeroes {
  final HeroInfoRepository repository;

  GetListOfHeroes(this.repository);

  Future<Either<Failure, Hero>> execute({@required int heroId}) async {
    return await repository.getHero(heroId);
  }
}
