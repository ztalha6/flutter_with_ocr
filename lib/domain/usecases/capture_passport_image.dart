import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../core/usecases/usecase.dart';
import '../repositories/camera_repository.dart';

// Use case for capturing passport images using the device camera
// Handles permissions, camera initialization, and image capture
class CapturePassportImage extends UseCase<String, CapturePassportImageParams> {
  final CameraRepository repository;

  CapturePassportImage(this.repository);

  @override
  Future<Either<Failure, String>> call(CapturePassportImageParams params) async {
    // Check and request permissions if needed
    final permissionResult = await repository.checkCameraPermissions();
    
    return permissionResult.fold(
      (failure) => Left(failure),
      (hasPermission) async {
        if (!hasPermission) {
          // Request permissions
          final requestResult = await repository.requestCameraPermissions();
          return requestResult.fold(
            (failure) => Left(failure),
            (granted) async {
              if (!granted) {
                return const Left(PermissionFailure.cameraPermissionDenied());
              }
              return await _initializeAndCapture();
            },
          );
        }
        return await _initializeAndCapture();
      },
    );
  }

  // Initialize camera and capture image
  Future<Either<Failure, String>> _initializeAndCapture() async {
    // Initialize camera
    final initResult = await repository.initializeCamera();
    
    return initResult.fold(
      (failure) => Left(failure),
      (initialized) async {
        if (!initialized) {
          return const Left(CameraFailure.initializationFailed());
        }
        
        // Capture the image
        return await repository.capturePassportImage();
      },
    );
  }
}

// Parameters for the CapturePassportImage use case
class CapturePassportImageParams extends Params {
  final bool requestPermissionsIfNeeded;
  final bool initializeCameraIfNeeded;

  const CapturePassportImageParams({
    this.requestPermissionsIfNeeded = true,
    this.initializeCameraIfNeeded = true,
  });

  @override
  List<Object> get props => [
    requestPermissionsIfNeeded,
    initializeCameraIfNeeded,
  ];
} 