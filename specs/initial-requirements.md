# Project: Passport OCR Flutter App

## 1. Objective

Build a Flutter app for Android (APK) that:

- Scans a Pakistani Machine Readable Passport (MRZ)
- Extracts key fields: Name, Passport Number, Nationality, Date of Birth, Expiry
- Displays results in an editable UI before submission
- Performs fully offline OCR (no AI-cloud APIs)

## 2. Constraints

- **DO NOT** use any AI-based external models or APIs (OpenAI, Gemini, Azure AI, etc.)
- OCR must run **totally on‑device**, with no data sent externally
- Use clean architecture and reusable UI components

## 3. Evaluation Criteria

- Modular, clean Flutter/Dart code
- Effective OCR integration and parsing logic
- Input validation and error handling (e.g. partial scans, misreads)
- UI/UX smoothness and performance

## 4. Recommended OCR Package

- **google_mlkit_text_recognition** (ML Kit Text Recognition) (https://pub.dev/packages/google_mlkit_text_recognition)
  - Works **100% offline**, runs on-device
  - Recognized by Flutter community as accurate and fast for MRZ text
- For better control over scan area (only MRZ zone), use wrapper package:
  - **flutter_scalable_ocr** around ML Kit with bounded camera overlay (https://pub.dev/packages/flutter_scalable_ocr)

### Why this choice?

- No external network dependency; privacy-compliant.
- Community-tested reliability; "mlkit was better … more accurate" for MRZ cases :contentReference[oaicite:4]{index=4}.
- `flutter_scalable_ocr` helps crop only the MRZ area (passport zone) to boost precision.

## 5. OCR Integration & Parsing Logic

1. Use **flutter_scalable_ocr** to capture only MRZ lines.
2. Feed captured image region into **google_mlkit_text_recognition**
3. Parse raw text for MRZ lines, extract fields using known MRZ format regex:
   - Line 1: Paysy code, passport no, nationality
   - Line 2: Name and DOB/expiry codes
4. Map extracted data into `PassportData` model

## 6. Input Validation

- Ensure extracted `passportNumber` matches expected format (digits plus checksum)
- Nationality must be “PAK”
- Ensure DOB and expiry dates parse to valid `DateTime`
- If parsing fails or missing fields, prompt user to retake capture or manual input

## 7. Performance & UX

- Minimal UI latency; show loading indicator during OCR
- Camera overlay guides user to align passport MRZ
- Allow manual edit correction before submission
- Use lightweight packages (ML Kit only, no heavy TFLite inclusion)

## 8. Submission Deliverables

- The code and commenting should not look like it's genrated by AI.
- Clean, commented code, logical directory structure

### Code Style

- Ensure proper separation of concerns by using Clean Architecture and BloC.
- Prefer small composable widgets over large ones
- Prefer using flex values over hardcoded sizes when creating widgets inside rows/columns, ensuring the UI adapts to various screen sizes
- Use `log` from `dart:developer` rather than `print` or `debugPrint` for logging
