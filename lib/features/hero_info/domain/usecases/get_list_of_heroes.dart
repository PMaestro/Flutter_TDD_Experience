import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tdd_studing/core/error/failures.dart';
import 'package:tdd_studing/core/usecases/usecase.dart';
import 'package:tdd_studing/features/hero_info/domain/entities/hero.dart';
import 'package:tdd_studing/features/hero_info/domain/repositories/hero_info_repository.dart';

class GetListOfHeroes implements UseCase<List<Hero>, NoParams> {
  final HeroInfoRepository repository;

  //constructor
  GetListOfHeroes(this.repository);

  @override
  Future<Either<Failure, List<Hero>>> call(NoParams params) async {
    return await repository.listHeroes();
  }
}

class NoParams extends Equatable {}
