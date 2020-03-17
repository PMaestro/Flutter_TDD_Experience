import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tdd_studing/features/hero_info/domain/entities/hero.dart';

abstract class HeroInfoState extends Equatable {
  HeroInfoState([List props = const <dynamic>[]]) : super(props);
}

class InitialHeroInfoState extends HeroInfoState {
  @override
  List<Object> get props => [];
}

class Empty extends HeroInfoState {}

class Loading extends HeroInfoState {
  @override
  List<Object> get props => [];
}

class Loaded extends HeroInfoState {
  final Hero hero;
  @override
  List<Object> get props => [];

  Loaded({@required this.hero}) : super([hero]);
}

class Error extends HeroInfoState {
  final String message;

  Error({@required this.message}) : super([message]);
}
