import 'package:equatable/equatable.dart';

// Abstract base class for all failures in the application
// All failures extend this class to maintain consistency
abstract class Failure extends Equatable {
  final String message;
  
  const Failure({required this.message});
  
  @override
  List<Object> get props => [message];
}

// OCR processing related failures
class OCRFailure extends Failure {
  const OCRFailure({required super.message});
  
  // Specific OCR failure types
  const OCRFailure.processingFailed() 
      : super(message: 'Failed to process image for text recognition');
  
  const OCRFailure.noTextFound() 
      : super(message: 'No text found in the captured image');
  
  const OCRFailure.lowConfidence() 
      : super(message: 'Text recognition confidence too low');
}

// Camera access and capture related failures  
class CameraFailure extends Failure {
  const CameraFailure({required super.message});
  
  // Specific camera failure types
  const CameraFailure.accessDenied() 
      : super(message: 'Camera access permission denied');
  
  const CameraFailure.notAvailable() 
      : super(message: 'Camera not available on this device');
  
  const CameraFailure.captureFailed() 
      : super(message: 'Failed to capture image');
  
  const CameraFailure.initializationFailed() 
      : super(message: 'Failed to initialize camera');
}

// Data validation related failures
class ValidationFailure extends Failure {
  const ValidationFailure({required super.message});
  
  // Specific validation failure types
  const ValidationFailure.invalidPassportNumber() 
      : super(message: 'Invalid passport number format');
  
  const ValidationFailure.invalidNationality() 
      : super(message: 'Nationality must be PAK for Pakistani passport');
  
  const ValidationFailure.invalidDate() 
      : super(message: 'Invalid date format or range');
  
  const ValidationFailure.missingRequiredField(String fieldName) 
      : super(message: 'Required field is missing: $fieldName');
  
  const ValidationFailure.dateLogicError() 
      : super(message: 'Date of birth must be before expiry date');
}

// MRZ parsing related failures
class ParsingFailure extends Failure {
  const ParsingFailure({required super.message});
  
  // Specific parsing failure types
  const ParsingFailure.invalidMRZFormat() 
      : super(message: 'Invalid MRZ format - not a valid passport MRZ');
  
  const ParsingFailure.checksumValidationFailed() 
      : super(message: 'MRZ checksum validation failed');
  
  const ParsingFailure.corruptedMRZData() 
      : super(message: 'MRZ data appears corrupted or incomplete');
  
  const ParsingFailure.unsupportedPassportType() 
      : super(message: 'Unsupported passport type - only Pakistani passports supported');
}

// Permission related failures
class PermissionFailure extends Failure {
  const PermissionFailure({required super.message});
  
  // Specific permission failure types
  const PermissionFailure.cameraPermissionDenied() 
      : super(message: 'Camera permission is required to scan passport');
  
  const PermissionFailure.storagePermissionDenied() 
      : super(message: 'Storage permission is required to save images');
}

// Network or connectivity related failures (if needed in future)
class NetworkFailure extends Failure {
  const NetworkFailure({required super.message});
  
  const NetworkFailure.noConnection() 
      : super(message: 'No internet connection available');
  
  const NetworkFailure.timeout() 
      : super(message: 'Network request timed out');
}

// Generic server or unknown failures
class ServerFailure extends Failure {
  const ServerFailure({required super.message});
  
  const ServerFailure.unknown() 
      : super(message: 'An unknown error occurred');
  
  const ServerFailure.internalError() 
      : super(message: 'Internal application error');
} 