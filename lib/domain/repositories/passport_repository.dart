import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/mrz_data.dart';
import '../entities/ocr_result.dart';
import '../entities/passport_data.dart';

// Abstract repository interface for passport-related operations
// Defines contracts for OCR scanning, MRZ parsing, and data validation
// All methods return Either<Failure, T> for functional error handling
abstract class PassportRepository {
  /// Scans an image and extracts text using OCR
  ///
  /// [imagePath] - Path to the captured passport image
  /// Returns OCRResult containing raw text and confidence scores
  ///
  /// Possible failures:
  /// - OCRFailure.processingFailed() - OCR engine failed to process image
  /// - OCRFailure.noTextFound() - No text detected in image
  /// - OCRFailure.lowConfidence() - OCR confidence below threshold
  Future<Either<Failure, OCRResult>> scanPassport(String imagePath);

  /// Extracts MRZ data from OCR result
  ///
  /// [ocrResult] - The result from OCR text recognition
  /// Returns MRZData containing the two MRZ lines with confidence
  ///
  /// Possible failures:
  /// - ParsingFailure.invalidMRZFormat() - No valid MRZ lines found
  /// - ParsingFailure.corruptedMRZData() - MRZ data incomplete or corrupted
  /// - ParsingFailure.unsupportedPassportType() - Not a Pakistani passport
  Future<Either<Failure, MRZData>> extractMRZData(OCRResult ocrResult);

  /// Parses MRZ data into structured passport information
  ///
  /// [mrzData] - Raw MRZ lines extracted from OCR
  /// Returns PassportData with parsed fields (name, number, dates, etc.)
  ///
  /// Possible failures:
  /// - ParsingFailure.invalidMRZFormat() - MRZ format doesn't match Pakistani standard
  /// - ParsingFailure.checksumValidationFailed() - MRZ checksum digits invalid
  /// - ValidationFailure.invalidDate() - Date parsing failed or invalid range
  /// - ValidationFailure.invalidPassportNumber() - Passport number format invalid
  Future<Either<Failure, PassportData>> parsePassportData(MRZData mrzData);

  /// Validates complete passport data for consistency and business rules
  ///
  /// [passportData] - Parsed passport information to validate
  /// Returns true if all validation passes
  ///
  /// Possible failures:
  /// - ValidationFailure.invalidNationality() - Must be PAK for Pakistani passport
  /// - ValidationFailure.dateLogicError() - DOB after expiry or future dates
  /// - ValidationFailure.missingRequiredField() - Required field empty or null
  /// - ValidationFailure.invalidPassportNumber() - Format doesn't match standard
  Future<Either<Failure, bool>> validatePassportData(PassportData passportData);

  /// Complete workflow: processes image through OCR, MRZ extraction, parsing, and validation
  ///
  /// [imagePath] - Path to captured passport image
  /// Returns fully validated PassportData ready for use
  ///
  /// This is a convenience method that combines all the above operations
  /// Will fail fast at any step and return the appropriate failure
  Future<Either<Failure, PassportData>> processPassportImage(String imagePath);

  /// Validates individual passport fields without full processing
  ///
  /// [field] - Field name to validate ('passportNumber', 'nationality', etc.)
  /// [value] - Field value to validate
  /// Returns true if field passes validation rules
  ///
  /// Useful for real-time validation during manual input/editing
  Either<Failure, bool> validateField(String field, dynamic value);
}
