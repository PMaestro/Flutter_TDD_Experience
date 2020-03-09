import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure([List properties = const <dynamic>[]]) : super(properties);
}

class ServerFailure extends Failure {
  @override
  // TODO: implement props
  List get props => null;
}

class CacheFailure extends Failure {
  @override
  // TODO: implement props
  List get props => null;
}
