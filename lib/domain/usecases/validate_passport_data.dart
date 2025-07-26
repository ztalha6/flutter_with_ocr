import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../core/usecases/usecase.dart';
import '../entities/passport_data.dart';
import '../repositories/passport_repository.dart';

// Use case for validating passport data against business rules
// Ensures data meets Pakistani passport requirements and logical constraints
class ValidatePassportData extends UseCase<bool, ValidatePassportDataParams> {
  final PassportRepository repository;

  ValidatePassportData(this.repository);

  @override
  Future<Either<Failure, bool>> call(ValidatePassportDataParams params) async {
    return await repository.validatePassportData(params.passportData);
  }
}

// Parameters for the ValidatePassportData use case
class ValidatePassportDataParams extends Params {
  final PassportData passportData;

  const ValidatePassportDataParams({
    required this.passportData,
  });

  @override
  List<Object> get props => [passportData];
} 