import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';

// Abstract repository interface for camera-related operations
// Defines contracts for camera access, permissions, and image capture
// All methods return Either<Failure, T> for functional error handling
abstract class CameraRepository {
  /// Checks if camera permissions are granted
  ///
  /// Returns true if camera access is allowed
  ///
  /// Possible failures:
  /// - PermissionFailure.cameraPermissionDenied() - User denied camera access
  /// - CameraFailure.notAvailable() - Camera not available on device
  Future<Either<Failure, bool>> checkCameraPermissions();

  /// Requests camera permissions from the user
  ///
  /// Returns true if permissions were granted
  ///
  /// Possible failures:
  /// - PermissionFailure.cameraPermissionDenied() - User denied permission request
  /// - CameraFailure.notAvailable() - Camera hardware not available
  Future<Either<Failure, bool>> requestCameraPermissions();

  /// Initializes the camera for passport scanning
  ///
  /// Returns true if camera is ready for use
  ///
  /// Possible failures:
  /// - CameraFailure.initializationFailed() - Failed to initialize camera controller
  /// - CameraFailure.notAvailable() - Camera not available
  /// - PermissionFailure.cameraPermissionDenied() - Missing permissions
  Future<Either<Failure, bool>> initializeCamera();

  /// Captures an image of the passport
  ///
  /// Returns the file path of the captured image
  ///
  /// Possible failures:
  /// - CameraFailure.captureFailed() - Image capture failed
  /// - CameraFailure.initializationFailed() - Camera not initialized
  /// - PermissionFailure.storagePermissionDenied() - Cannot save image
  Future<Either<Failure, String>> capturePassportImage();

  /// Disposes camera resources and cleans up
  ///
  /// Returns true if cleanup was successful
  ///
  /// This should be called when camera is no longer needed
  /// to free up system resources
  Future<Either<Failure, bool>> disposeCamera();

  /// Toggles the camera flash on/off
  ///
  /// [enabled] - Whether flash should be enabled
  /// Returns true if flash setting was applied successfully
  ///
  /// Possible failures:
  /// - CameraFailure.initializationFailed() - Camera not initialized
  /// - CameraFailure.notAvailable() - Flash not available on device
  Future<Either<Failure, bool>> toggleFlash(bool enabled);

  /// Gets the current flash mode status
  ///
  /// Returns true if flash is currently enabled
  ///
  /// Possible failures:
  /// - CameraFailure.initializationFailed() - Camera not initialized
  Future<Either<Failure, bool>> isFlashEnabled();

  /// Focuses the camera on a specific point (if supported)
  ///
  /// [x] - X coordinate (0.0 to 1.0) relative to camera view
  /// [y] - Y coordinate (0.0 to 1.0) relative to camera view
  /// Returns true if focus was set successfully
  ///
  /// Useful for focusing on the MRZ area of the passport
  ///
  /// Possible failures:
  /// - CameraFailure.initializationFailed() - Camera not initialized
  /// - CameraFailure.notAvailable() - Manual focus not supported
  Future<Either<Failure, bool>> focusAt(double x, double y);

  /// Sets the zoom level for the camera
  ///
  /// [zoomLevel] - Zoom level (typically 1.0 to maxZoom)
  /// Returns the actual zoom level that was set
  ///
  /// Possible failures:
  /// - CameraFailure.initializationFailed() - Camera not initialized
  /// - CameraFailure.notAvailable() - Zoom not supported
  Future<Either<Failure, double>> setZoomLevel(double zoomLevel);

  /// Gets the maximum supported zoom level
  ///
  /// Returns the maximum zoom level available
  ///
  /// Possible failures:
  /// - CameraFailure.initializationFailed() - Camera not initialized
  Future<Either<Failure, double>> getMaxZoomLevel();

  /// Checks if the camera is currently initialized and ready
  ///
  /// Returns true if camera is ready for operations
  Either<Failure, bool> isCameraReady();

  /// Gets information about available cameras
  ///
  /// Returns a list of available camera descriptions
  /// Useful for selecting between front/back cameras
  ///
  /// Possible failures:
  /// - CameraFailure.notAvailable() - No cameras available on device
  Future<Either<Failure, List<CameraInfo>>> getAvailableCameras();
}

// Data class representing camera information
class CameraInfo {
  final String id;
  final String name;
  final CameraLensDirection lensDirection;
  final bool hasFlash;

  const CameraInfo({
    required this.id,
    required this.name,
    required this.lensDirection,
    required this.hasFlash,
  });
}

// Enum for camera lens direction
enum CameraLensDirection {
  front,
  back,
  external,
} 