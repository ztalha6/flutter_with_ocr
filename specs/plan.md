# Implementation Plan: Passport OCR Flutter App

## Clean Architecture + BLoC + Dartz

### Overview

Build a Flutter app for Pakistani passport OCR using clean architecture principles, BLoC state management, and dartz for functional programming. Each phase is designed to be manually testable.

---

## 🏗️ **Phase 1: Clean Architecture Foundation**

### 1.1 Project Structure Setup ✅

- [x] Create clean architecture folder structure
  - `lib/core/` (constants, error, theme, utils, usecases)
  - `lib/domain/` (entities, repositories, usecases)
  - `lib/data/` (datasources, models, repositories)
  - `lib/presentation/` (bloc, pages, widgets)
- [x] Set up dependency injection structure
- [x] Create base usecase abstract class

### 1.2 Dependencies Configuration ✅

- [x] Add flutter_bloc for state management
- [x] Add dartz for functional programming
- [x] Add get_it and injectable for dependency injection
- [x] Add google_mlkit_text_recognition for OCR
- [x] Add flutter_scalable_ocr for camera overlay
- [x] Add camera package for image capture
- [x] Add equatable for value equality
- [x] Configure dev dependencies (injectable_generator, build_runner)

**Manual Test Checkpoint:** Run `flutter pub get` and verify no dependency conflicts

---

## 🎯 **Phase 2: Domain Layer (Core Business Logic)**

### 2.1 Domain Entities ✅

- [x] Create `PassportData` entity with validation methods
  - fullName, passportNumber, nationality, dateOfBirth, expiryDate
  - Validation logic for Pakistani passport format
  - Equatable implementation
- [x] Create `OCRResult` entity
  - rawText, confidence, processedData
  - Validation and parsing helpers
- [x] Create `MRZData` entity for raw MRZ line data

### 2.2 Failure Classes (Dartz Integration) ✅

- [x] Create abstract `Failure` base class
- [x] Implement specific failure types:
  - `OCRFailure` - OCR processing errors
  - `CameraFailure` - Camera access/capture errors
  - `ValidationFailure` - Data validation errors
  - `ParsingFailure` - MRZ parsing errors
  - `PermissionFailure` - Permission denied errors

### 2.3 Repository Interfaces

- [ ] Create `PassportRepository` abstract class
  - `scanPassport(String imagePath)` → `Either<Failure, OCRResult>`
  - `parsePassportData(String mrzText)` → `Either<Failure, PassportData>`
  - `validatePassportData(PassportData data)` → `Either<Failure, bool>`
- [ ] Create `CameraRepository` abstract class
  - `captureImage()` → `Either<Failure, String>`
  - `checkPermissions()` → `Either<Failure, bool>`

### 2.4 Use Cases

- [ ] Create base `UseCase<Type, Params>` abstract class
- [ ] Implement `ScanPassport` use case
- [ ] Implement `ParseMRZ` use case
- [ ] Implement `ValidatePassportData` use case
- [ ] Implement `CapturePassportImage` use case
- [ ] Create parameter classes for each use case

**Manual Test Checkpoint:** Create mock implementations and verify interface contracts

---

## 🎨 **Phase 3: Presentation Layer (BLoC + UI Foundation)**

### 3.1 Design System Components

- [ ] Create `AppColors` class with consistent color palette
- [ ] Create `AppTextStyles` with typography hierarchy
- [ ] Build reusable UI components:
  - `AppButton` (primary, secondary, icon variants)
  - `AppInputField` with validation styling
  - `AppCard` for displaying passport data
  - `AppLoadingIndicator` with custom styling
  - `AppErrorWidget` for error states
- [ ] Create spacing and sizing constants
- [ ] Build widget catalog screen for manual testing

### 3.2 BLoC Architecture Setup

- [ ] Create `CameraBloc` with events and states:
  - Events: `StartCamera`, `TakePhoto`, `ProcessImage`, `ResetCamera`
  - States: `Initial`, `CameraReady`, `Capturing`, `Processing`, `Success`, `Error`
- [ ] Create `PassportBloc` with events and states:
  - Events: `LoadPassportData`, `UpdateField`, `ValidateData`, `SubmitData`, `ResetData`
  - States: `Initial`, `Loading`, `Loaded`, `Editing`, `ValidationError`, `Submitted`
- [ ] Create `AppBloc` for global app state
- [ ] Set up BLoC observers for debugging

### 3.3 Dependency Injection Setup

- [ ] Configure `@InjectableInit()` in main injection file
- [ ] Create `AppModule` with repository registrations
- [ ] Set up lazy singletons for services
- [ ] Create factory methods for BLoCs
- [ ] Configure mock vs production implementations

**Manual Test Checkpoint:** Create BLoC test screen with buttons to trigger events and display states

---

## 📱 **Phase 4: UI Implementation (Core Screens)**

### 4.1 Main/Home Screen

- [ ] Create welcome screen layout with app branding
- [ ] Add navigation to camera screen
- [ ] Integrate with AppBloc for global state
- [ ] Implement loading states during app initialization

### 4.2 Camera Screen (Mock Implementation First)

- [ ] Create camera preview UI layout
- [ ] Design MRZ overlay guide (rectangular frame)
- [ ] Add capture button with visual feedback
- [ ] Implement flash toggle functionality
- [ ] Add back navigation
- [ ] Integrate CameraBloc for state management
- [ ] Create mock camera implementation for testing
- [ ] Add loading indicator during OCR processing

### 4.3 Results Editing Screen

- [ ] Design form layout for passport data fields
- [ ] Create editable input fields with validation
- [ ] Add date picker for DOB and expiry dates
- [ ] Implement nationality dropdown/readonly field
- [ ] Add save/submit button with loading states
- [ ] Include "Retake Photo" navigation option
- [ ] Integrate PassportBloc for data management
- [ ] Add real-time validation feedback

### 4.4 Error Handling UI

- [ ] Create error dialog components
- [ ] Design error state screens for different failure types
- [ ] Implement retry mechanisms with clear CTAs
- [ ] Add snackbar notifications for quick feedback
- [ ] Create empty state illustrations
- [ ] Add manual input fallback option

**Manual Test Checkpoint:** Complete app navigation flow with mock data works end-to-end

---

## 🔍 **Phase 5: Data Layer Implementation**

### 5.1 Data Sources (with Mock Alternatives)

- [ ] Create `CameraDataSource` abstract interface
- [ ] Implement `CameraDataSourceImpl` for real camera operations
- [ ] Create `MockCameraDataSource` for testing
- [ ] Create `OCRDataSource` abstract interface
- [ ] Implement `OCRDataSourceImpl` using ML Kit
- [ ] Create `MockOCRDataSource` with sample data
- [ ] Add proper error handling in all implementations

### 5.2 Data Models

- [ ] Create `PassportDataModel` extending `PassportData`
  - JSON serialization/deserialization
  - Conversion methods to/from domain entities
  - Validation helpers
- [ ] Create `OCRResultModel` extending `OCRResult`
- [ ] Create `MRZDataModel` for raw MRZ parsing
- [ ] Add JSON fixtures for testing
- [ ] Implement proper null safety handling

### 5.3 Repository Implementations

- [ ] Implement `PassportRepositoryImpl`
  - OCR processing logic
  - MRZ parsing integration
  - Data validation
  - Error handling with dartz Either
- [ ] Implement `CameraRepositoryImpl`
  - Camera initialization and capture
  - Permission handling
  - Image preprocessing
- [ ] Create comprehensive error mapping
- [ ] Add logging for debugging

**Manual Test Checkpoint:** Switch between mock and real implementations via dependency injection

---

## 🚀 **Phase 6: OCR Integration**

### 6.1 OCR Service Implementation

- [ ] Integrate ML Kit text recognition
- [ ] Implement image preprocessing (contrast, rotation)
- [ ] Add confidence score handling
- [ ] Create text region detection
- [ ] Optimize for MRZ text characteristics
- [ ] Add OCR result validation

### 6.2 MRZ Parser Implementation

- [ ] Research Pakistani passport MRZ format specification
- [ ] Implement regex patterns for MRZ lines:
  - Line 1: `P<PAK[NAME]<<<<<<<<<<<<<<<<<<<<<<<`
  - Line 2: `[PASSPORT_NO][CHECK][NATIONALITY][DOB][SEX][EXPIRY][CHECK]`
- [ ] Add checksum digit validation
- [ ] Handle partial or corrupted MRZ data
- [ ] Create comprehensive test cases with real MRZ samples
- [ ] Add fallback parsing for common OCR errors

### 6.3 Camera Integration

- [ ] Implement real camera functionality
- [ ] Add MRZ area detection and cropping
- [ ] Optimize camera settings for document scanning
- [ ] Handle different device orientations
- [ ] Add autofocus and image stabilization
- [ ] Implement proper image quality checks

**Manual Test Checkpoint:** OCR accuracy testing with sample passport images

---

## 🧪 **Phase 7: Testing & Quality Assurance**

### 7.1 Unit Testing

- [ ] Test domain entities validation logic
- [ ] Test use cases with mock repositories
- [ ] Test MRZ parsing with various input formats
- [ ] Test data model serialization/deserialization
- [ ] Test BLoC state transitions
- [ ] Test error handling scenarios

### 7.2 Widget Testing

- [ ] Test reusable UI components
- [ ] Test form validation UI feedback
- [ ] Test navigation flows
- [ ] Test error state displays
- [ ] Test loading state indicators

### 7.3 Integration Testing

- [ ] Test complete OCR workflow
- [ ] Test camera to results flow
- [ ] Test error recovery scenarios
- [ ] Test manual input fallback
- [ ] Test data persistence (if added)

### 7.4 Manual Testing Strategy

- [ ] Create testing screens for debugging:
  - BLoC state viewer
  - Dependency inspector
  - OCR accuracy tester
  - Error simulator
- [ ] Test with various passport samples
- [ ] Test on different Android devices
- [ ] Performance testing (memory, processing time)
- [ ] User experience testing

---

## 🎯 **Phase 8: Performance & Polish**

### 8.1 Performance Optimization

- [ ] Optimize OCR processing pipeline
- [ ] Implement proper memory management for camera
- [ ] Add image compression before OCR
- [ ] Optimize BLoC state updates
- [ ] Minimize widget rebuilds
- [ ] Add performance monitoring

### 8.2 User Experience Enhancements

- [ ] Add smooth animations and transitions
- [ ] Implement haptic feedback for actions
- [ ] Add sound feedback for successful captures
- [ ] Create onboarding/tutorial flow
- [ ] Add accessibility support
- [ ] Implement dark mode support

### 8.3 Error Handling & Edge Cases

- [ ] Handle low-light camera conditions
- [ ] Manage network connectivity issues (if any)
- [ ] Handle device rotation during capture
- [ ] Manage app lifecycle (pause/resume)
- [ ] Add crash reporting and analytics
- [ ] Implement proper app state recovery

---

## 📋 **Delivery Checklist**

### Code Quality

- [ ] Clean, commented code following Flutter best practices
- [ ] Proper separation of concerns across architecture layers
- [ ] Small, composable widgets over large monolithic ones
- [ ] Flexible layouts using flex values instead of hardcoded sizes
- [ ] Use `log` from `dart:developer` for logging
- [ ] Comprehensive error handling with user-friendly messages

### Documentation

- [ ] README with setup and build instructions
- [ ] Code documentation for complex logic
- [ ] Architecture decision records
- [ ] Testing documentation
- [ ] Known issues and limitations

### Final Testing

- [ ] End-to-end manual testing on physical devices
- [ ] APK build and installation testing
- [ ] Performance validation on various Android versions
- [ ] Accessibility testing
- [ ] Security review (no data leakage)

---

## Manual Testing Checkpoints Summary

1. **Phase 1:** Dependencies resolve and compile successfully
2. **Phase 2:** Domain logic works with mocked data
3. **Phase 3:** UI responds correctly to BLoC state changes
4. **Phase 4:** Complete app flow with mocked services
5. **Phase 5:** Real data sources work independently
6. **Phase 6:** OCR integration produces accurate results
7. **Phase 7:** Comprehensive testing coverage
8. **Phase 8:** Optimized, polished, production-ready app

Each phase builds upon the previous, ensuring the app remains manually testable throughout development while maintaining clean architecture principles.
