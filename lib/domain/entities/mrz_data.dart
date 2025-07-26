import 'package:equatable/equatable.dart';

// Domain entity representing raw MRZ (Machine Readable Zone) data
// Contains the two lines typically found at the bottom of passports
class MRZData extends Equatable {
  final String line1; // First MRZ line
  final String line2; // Second MRZ line
  final double confidence; // Overall confidence of MRZ detection
  final DateTime extractedAt; // When the MRZ was extracted

  const MRZData({
    required this.line1,
    required this.line2,
    required this.confidence,
    required this.extractedAt,
  });

  @override
  List<Object> get props => [line1, line2, confidence, extractedAt];

  // Validation methods

  /// Checks if MRZ data appears to be valid format
  bool get isValidFormat {
    return isLine1Valid && isLine2Valid;
  }

  /// Validates first MRZ line format
  /// Expected format: P<PAK[NAME]<<<<<<<<<<<<<<<<<<<<<
  bool get isLine1Valid {
    if (line1.length < 44) return false;

    // Should start with P< for passport
    if (!line1.startsWith('P<')) return false;

    // Should contain Pakistani nationality code
    if (!line1.substring(2, 5).contains('PAK')) return false;

    // Should have proper length (44 characters for passport MRZ)
    return line1.length == 44;
  }

  /// Validates second MRZ line format
  /// Expected format: [PASSPORT_NO][CHECK][NATIONALITY][DOB][SEX][EXPIRY][CHECK]
  bool get isLine2Valid {
    if (line2.length < 44) return false;

    // Should have proper length (44 characters for passport MRZ)
    return line2.length == 44;
  }

  /// Checks if MRZ contains Pakistani nationality
  bool get isPakistaniPassport {
    return line1.contains('PAK') || line2.contains('PAK');
  }

  /// Gets cleaned line 1 (normalized spacing and characters)
  String get cleanLine1 {
    return line1.trim().replaceAll(RegExp(r'\s+'), '');
  }

  /// Gets cleaned line 2 (normalized spacing and characters)
  String get cleanLine2 {
    return line2.trim().replaceAll(RegExp(r'\s+'), '');
  }

  /// Extracts potential name from line 1
  /// Names are after PAK and before padding characters
  String get extractedName {
    try {
      if (!line1.startsWith('P<PAK')) return '';

      // Name starts after P<PAK and goes until padding
      final nameSection = line1.substring(5);
      final nameEnd = nameSection.indexOf('<<');

      if (nameEnd == -1) return nameSection.replaceAll('<', ' ').trim();

      return nameSection
          .substring(0, nameEnd)
          .replaceAll('<', ' ')
          .replaceAll(RegExp(r'\s+'), ' ')
          .trim();
    } catch (e) {
      return '';
    }
  }

  /// Extracts potential passport number from line 2
  /// Passport number is at the beginning of line 2
  String get extractedPassportNumber {
    try {
      if (line2.length < 9) return '';

      // Passport number is typically first 9 characters (or until first <)
      final endIndex = line2.indexOf('<');
      if (endIndex != -1 && endIndex < 10) {
        return line2.substring(0, endIndex);
      }

      return line2.substring(0, 9).replaceAll('<', '');
    } catch (e) {
      return '';
    }
  }

  /// Gets combined MRZ text for processing
  String get combinedMRZ {
    return '$cleanLine1\n$cleanLine2';
  }

  /// Checks if confidence is acceptable for processing
  bool get hasAcceptableConfidence {
    return confidence >= 0.7; // 70% confidence threshold for MRZ
  }

  /// Checks if confidence is high enough for automatic processing
  bool get hasHighConfidence {
    return confidence >= 0.9; // 90% confidence threshold
  }

  /// Creates a copy with updated values
  MRZData copyWith({
    String? line1,
    String? line2,
    double? confidence,
    DateTime? extractedAt,
  }) {
    return MRZData(
      line1: line1 ?? this.line1,
      line2: line2 ?? this.line2,
      confidence: confidence ?? this.confidence,
      extractedAt: extractedAt ?? this.extractedAt,
    );
  }

  @override
  String toString() {
    return 'MRZData('
        'line1: "$line1", '
        'line2: "$line2", '
        'confidence: ${(confidence * 100).toStringAsFixed(1)}%, '
        'isValid: $isValidFormat'
        ')';
  }
}

// Utility class for MRZ validation constants
class MRZConstants {
  static const int passportMRZLength = 44;
  static const String passportPrefix = 'P<';
  static const String pakistaniNationality = 'PAK';
  static const double minimumConfidence = 0.7;
  static const double highConfidence = 0.9;

  // Common MRZ characters
  static const String paddingChar = '<';
  static const String spacePlaceholder = '<';

  // Regex patterns for validation
  static final RegExp passportNumberPattern = RegExp(r'^[A-Z0-9]{7,9}$');
  static final RegExp datePattern = RegExp(r'^\d{6}$'); // YYMMDD format
  static final RegExp namePattern = RegExp(r'^[A-Z<\s]+$');
}
