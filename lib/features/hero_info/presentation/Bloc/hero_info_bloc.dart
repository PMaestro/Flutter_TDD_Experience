import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tdd_studing/core/error/failures.dart';
import 'package:tdd_studing/core/util/input_converter.dart';
import 'package:tdd_studing/features/hero_info/domain/usecases/get_hero.dart';
import 'package:tdd_studing/features/hero_info/domain/usecases/get_list_of_heroes.dart';

import './bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure!';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - the nunmber must be a possitive interger above zero';

class HeroInfoBloc extends Bloc<HeroInfoEvent, HeroInfoState> {
  final GetHeroById getHeroById;
  final GetRandomHero getRandomHero;
  final InputConverter inputConverter;

  HeroInfoBloc({
    @required GetHeroById byId,
    @required GetRandomHero randomHero,
    @required this.inputConverter,
  })  : assert(
          byId != null,
          randomHero != null,
        ),
        getHeroById = byId,
        getRandomHero = randomHero;

  @override
  HeroInfoState get initialState => Empty();

  @override
  Stream<HeroInfoState> mapEventToState(
    HeroInfoEvent event,
  ) async* {
    if (event is GetHeroForExplicitId) {
      final inputEither =
          inputConverter.stringToUnsignedInterger(event.stringId);

      yield* inputEither.fold((failure) async* {
        yield Error(
          message: INVALID_INPUT_FAILURE_MESSAGE,
        );
      }, (integer) async* {
        yield Loading();
        final failureOrHero =
            await getHeroById(Params(heroId: integer.toString()));
        yield failureOrHero.fold(
          (failure) => Error(message: _mapFailureToMessage(failure)),
          (hero) => Loaded(hero: hero),
        );
      });
    } else if (event is GetHeroForRandomId) {
      yield Loading();
      final failureOrHero = await getRandomHero(NoParams());
      yield failureOrHero.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (hero) => Loaded(hero: hero),
      );
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
