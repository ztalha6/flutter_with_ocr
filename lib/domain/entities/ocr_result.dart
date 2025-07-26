import 'package:equatable/equatable.dart';

// Domain entity representing the result of OCR text recognition
// Contains raw text, confidence metrics, and processing metadata
class OCRResult extends Equatable {
  final String rawText; // Complete raw text from OCR
  final double confidence; // Overall confidence score (0.0 to 1.0)
  final List<TextBlock> textBlocks; // Individual text blocks with positions
  final DateTime processedAt; // When the OCR was processed
  final String? imagePath; // Path to the processed image (optional)

  const OCRResult({
    required this.rawText,
    required this.confidence,
    required this.textBlocks,
    required this.processedAt,
    this.imagePath,
  });

  @override
  List<Object?> get props => [
    rawText,
    confidence,
    textBlocks,
    processedAt,
    imagePath,
  ];

  // Validation and utility methods

  /// Checks if OCR result has sufficient confidence
  bool get hasHighConfidence {
    return confidence >= 0.8; // 80% confidence threshold
  }

  /// Checks if OCR result has acceptable confidence
  bool get hasAcceptableConfidence {
    return confidence >= 0.6; // 60% confidence threshold
  }

  /// Checks if any text was found
  bool get hasText {
    return rawText.trim().isNotEmpty;
  }

  /// Gets normalized raw text (removes extra whitespace, normalizes line breaks)
  String get normalizedText {
    return rawText
        .replaceAll(RegExp(r'\s+'), ' ')
        .replaceAll(RegExp(r'\n+'), '\n')
        .trim();
  }

  /// Extracts potential MRZ lines from raw text
  /// MRZ lines are typically at the bottom and have specific patterns
  List<String> get potentialMRZLines {
    final lines = rawText.split('\n');
    final mrzLines = <String>[];

    for (final line in lines) {
      final cleanLine = line.trim();
      // MRZ lines typically contain < characters and are longer
      if (cleanLine.length >= 30 && cleanLine.contains('<')) {
        mrzLines.add(cleanLine);
      }
    }

    return mrzLines;
  }

  /// Gets text blocks sorted by confidence (highest first)
  List<TextBlock> get textBlocksByConfidence {
    final blocks = List<TextBlock>.from(textBlocks);
    blocks.sort((a, b) => b.confidence.compareTo(a.confidence));
    return blocks;
  }

  /// Gets text blocks that likely contain MRZ data
  List<TextBlock> get mrzCandidateBlocks {
    return textBlocks.where((block) {
      final text = block.text.trim();
      return text.length >= 30 && text.contains('<') && block.confidence >= 0.5;
    }).toList();
  }

  /// Creates a copy with updated values
  OCRResult copyWith({
    String? rawText,
    double? confidence,
    List<TextBlock>? textBlocks,
    DateTime? processedAt,
    String? imagePath,
  }) {
    return OCRResult(
      rawText: rawText ?? this.rawText,
      confidence: confidence ?? this.confidence,
      textBlocks: textBlocks ?? this.textBlocks,
      processedAt: processedAt ?? this.processedAt,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  @override
  String toString() {
    return 'OCRResult('
        'confidence: ${(confidence * 100).toStringAsFixed(1)}%, '
        'textBlocks: ${textBlocks.length}, '
        'hasText: $hasText, '
        'processedAt: $processedAt'
        ')';
  }
}

// Represents an individual text block detected by OCR
class TextBlock extends Equatable {
  final String text;
  final double confidence; // Confidence for this specific block
  final BoundingBox? boundingBox; // Position information (optional)

  const TextBlock({
    required this.text,
    required this.confidence,
    this.boundingBox,
  });

  @override
  List<Object?> get props => [text, confidence, boundingBox];

  /// Checks if this block has high confidence
  bool get hasHighConfidence => confidence >= 0.8;

  /// Gets normalized text for this block
  String get normalizedText {
    return text.replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  @override
  String toString() {
    return 'TextBlock(text: "$text", confidence: ${(confidence * 100).toStringAsFixed(1)}%)';
  }
}

// Represents the bounding box/position of detected text
class BoundingBox extends Equatable {
  final double left;
  final double top;
  final double right;
  final double bottom;

  const BoundingBox({
    required this.left,
    required this.top,
    required this.right,
    required this.bottom,
  });

  @override
  List<Object> get props => [left, top, right, bottom];

  /// Gets the width of the bounding box
  double get width => right - left;

  /// Gets the height of the bounding box
  double get height => bottom - top;

  /// Gets the area of the bounding box
  double get area => width * height;

  @override
  String toString() {
    return 'BoundingBox(left: $left, top: $top, right: $right, bottom: $bottom)';
  }
}
