import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../core/usecases/usecase.dart';
import '../entities/passport_data.dart';
import '../repositories/passport_repository.dart';

// Use case for scanning and processing a passport image into validated passport data
// This orchestrates the complete workflow: OCR → MRZ extraction → parsing → validation
class ScanPassport extends UseCase<PassportData, ScanPassportParams> {
  final PassportRepository repository;

  ScanPassport(this.repository);

  @override
  Future<Either<Failure, PassportData>> call(ScanPassportParams params) async {
    // Use the repository's convenience method that handles the complete workflow
    return await repository.processPassportImage(params.imagePath);
  }
}

// Parameters for the ScanPassport use case
class ScanPassportParams extends Params {
  final String imagePath;

  const ScanPassportParams({
    required this.imagePath,
  });

  @override
  List<Object> get props => [imagePath];
} 