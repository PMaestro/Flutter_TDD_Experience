import 'package:equatable/equatable.dart';

//whem a user does any action on the screen
abstract class HeroInfoEvent extends Equatable {
  HeroInfoEvent([List props = const <dynamic>[]]) : super(props);
}

class GetHeroForExplicitId extends HeroInfoEvent {
  final String stringId;

  GetHeroForExplicitId(this.stringId) : super([stringId]);
}

class GetHeroForRandomId extends HeroInfoEvent {}
