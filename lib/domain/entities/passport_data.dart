import 'package:equatable/equatable.dart';

// Domain entity representing passport data extracted from MRZ
// Contains all the essential information from a Pakistani passport
class PassportData extends Equatable {
  final String fullName;
  final String passportNumber;
  final String nationality;
  final DateTime dateOfBirth;
  final DateTime expiryDate;
  final String? sex; // Optional field (M/F/<)

  const PassportData({
    required this.fullName,
    required this.passportNumber,
    required this.nationality,
    required this.dateOfBirth,
    required this.expiryDate,
    this.sex,
  });

  @override
  List<Object?> get props => [
    fullName,
    passportNumber,
    nationality,
    dateOfBirth,
    expiryDate,
    sex,
  ];

  // Validation methods

  /// Validates if all required fields are present and valid
  bool get isValid {
    return isPassportNumberValid &&
        isNationalityValid &&
        isDateRangeValid &&
        isFullNameValid;
  }

  /// Validates Pakistani passport number format
  /// Format: Usually 8-9 alphanumeric characters
  bool get isPassportNumberValid {
    if (passportNumber.isEmpty) return false;

    // Pakistani passport number pattern: typically 2 letters followed by 7 digits
    // Example: AB1234567 or similar variations
    final passportRegex = RegExp(r'^[A-Z]{2}[0-9]{7}$');
    return passportRegex.hasMatch(passportNumber.toUpperCase());
  }

  /// Validates nationality is Pakistani (PAK)
  bool get isNationalityValid {
    return nationality.toUpperCase() == 'PAK';
  }

  /// Validates date range logic (DOB should be before expiry)
  bool get isDateRangeValid {
    if (dateOfBirth.isAfter(DateTime.now())) return false;
    if (expiryDate.isBefore(DateTime.now())) return false;
    return dateOfBirth.isBefore(expiryDate);
  }

  /// Validates full name format
  bool get isFullNameValid {
    if (fullName.isEmpty) return false;

    // Name should contain only letters, spaces, and common punctuation
    // Remove multiple spaces and MRZ padding characters (<)
    final cleanName = fullName.replaceAll(RegExp(r'<+'), ' ').trim();
    if (cleanName.isEmpty) return false;

    // Should contain at least one letter
    return RegExp(r'[A-Za-z]').hasMatch(cleanName);
  }

  /// Checks if passport is expired
  bool get isExpired {
    return expiryDate.isBefore(DateTime.now());
  }

  /// Checks if passport will expire within the given number of months
  bool willExpireWithin(int months) {
    final futureDate = DateTime.now().add(Duration(days: months * 30));
    return expiryDate.isBefore(futureDate);
  }

  /// Gets formatted full name (removes MRZ padding and extra spaces)
  String get formattedFullName {
    return fullName
        .replaceAll(RegExp(r'<+'), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  /// Gets passport number in uppercase format
  String get formattedPassportNumber {
    return passportNumber.toUpperCase();
  }

  /// Creates a copy of this passport data with updated values
  PassportData copyWith({
    String? fullName,
    String? passportNumber,
    String? nationality,
    DateTime? dateOfBirth,
    DateTime? expiryDate,
    String? sex,
  }) {
    return PassportData(
      fullName: fullName ?? this.fullName,
      passportNumber: passportNumber ?? this.passportNumber,
      nationality: nationality ?? this.nationality,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      expiryDate: expiryDate ?? this.expiryDate,
      sex: sex ?? this.sex,
    );
  }

  /// Converts to a string representation for debugging
  @override
  String toString() {
    return 'PassportData('
        'fullName: $fullName, '
        'passportNumber: $passportNumber, '
        'nationality: $nationality, '
        'dateOfBirth: $dateOfBirth, '
        'expiryDate: $expiryDate, '
        'sex: $sex'
        ')';
  }
}
