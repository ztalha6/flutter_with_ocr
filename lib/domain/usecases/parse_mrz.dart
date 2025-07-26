import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../core/usecases/usecase.dart';
import '../entities/mrz_data.dart';
import '../entities/passport_data.dart';
import '../repositories/passport_repository.dart';

// Use case for parsing MRZ data into structured passport information
// Converts raw MRZ lines into PassportData with proper field extraction
class ParseMRZ extends UseCase<PassportData, ParseMRZParams> {
  final PassportRepository repository;

  ParseMRZ(this.repository);

  @override
  Future<Either<Failure, PassportData>> call(ParseMRZParams params) async {
    return await repository.parsePassportData(params.mrzData);
  }
}

// Parameters for the ParseMRZ use case
class ParseMRZParams extends Params {
  final MRZData mrzData;

  const ParseMRZParams({
    required this.mrzData,
  });

  @override
  List<Object> get props => [mrzData];
} 