import 'package:dartz/dartz.dart';
import 'package:tdd_studing/core/error/failures.dart';

// Parameters have to be put into a container object so that they can be
// included in this abstract base class method definition.
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params) {
    print(params);
  }
}
