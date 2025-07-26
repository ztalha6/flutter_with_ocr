import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../core/usecases/usecase.dart';
import '../repositories/passport_repository.dart';

// Use case for validating individual passport fields
// Useful for real-time validation during form input and editing
class ValidateField extends UseCase<bool, ValidateFieldParams> {
  final PassportRepository repository;

  ValidateField(this.repository);

  @override
  Future<Either<Failure, bool>> call(ValidateFieldParams params) async {
    // This is a synchronous operation, so we wrap it in a Future
    return Future.value(
      repository.validateField(params.fieldName, params.fieldValue),
    );
  }
}

// Parameters for the ValidateField use case
class ValidateFieldParams extends Params {
  final String fieldName;
  final dynamic fieldValue;

  const ValidateFieldParams({
    required this.fieldName,
    required this.fieldValue,
  });

  @override
  List<Object?> get props => [fieldName, fieldValue];
}

// Enum for supported field names to ensure type safety
enum PassportField {
  fullName,
  passportNumber,
  nationality,
  dateOfBirth,
  expiryDate,
  sex;

  // Convert enum to string for repository call
  String get fieldName {
    switch (this) {
      case PassportField.fullName:
        return 'fullName';
      case PassportField.passportNumber:
        return 'passportNumber';
      case PassportField.nationality:
        return 'nationality';
      case PassportField.dateOfBirth:
        return 'dateOfBirth';
      case PassportField.expiryDate:
        return 'expiryDate';
      case PassportField.sex:
        return 'sex';
    }
  }

  // Create ValidateFieldParams from enum
  ValidateFieldParams createParams(dynamic value) {
    return ValidateFieldParams(
      fieldName: fieldName,
      fieldValue: value,
    );
  }
} 