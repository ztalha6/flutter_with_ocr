import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failures.dart';

// Base class for all use cases in the domain layer
// Type represents the return type, Params represents the input parameters
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

// Base class for use cases that don't require parameters
abstract class NoParamsUseCase<Type> {
  Future<Either<Failure, Type>> call();
}

// Base class for parameters that can be passed to use cases
abstract class Params extends Equatable {
  const Params();
}

// For use cases that don't need any parameters
class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object> get props => [];
}
