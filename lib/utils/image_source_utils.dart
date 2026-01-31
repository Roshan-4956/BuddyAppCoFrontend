import 'dart:typed_data';

import 'package:flutter/painting.dart';

class ImageData {
  const ImageData({required this.bytes, required this.mimeType});

  final Uint8List bytes;
  final String mimeType;
}

class ImageSourceUtils {
  ImageSourceUtils._();

  static ImageProvider resolveProvider(
    String? source, {
    required ImageProvider fallback,
  }) {
    return resolveProviderOrNull(source) ?? fallback;
  }

  static ImageProvider? resolveProviderOrNull(String? source) {
    final trimmed = source?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      return null;
    }

    final data = imageDataFromUri(trimmed);
    if (data != null && data.mimeType != 'image/svg+xml') {
      return MemoryImage(data.bytes);
    }

    if (trimmed.startsWith('http://') || trimmed.startsWith('https://')) {
      return NetworkImage(trimmed);
    }

    if (trimmed.startsWith('assets/')) {
      return AssetImage(trimmed);
    }

    return null;
  }

  static UriData? dataUri(String source) {
    if (!source.startsWith('data:')) {
      return null;
    }
    try {
      return Uri.parse(source).data;
    } catch (_) {
      return null;
    }
  }

  static ImageData? imageDataFromUri(String source) {
    final data = dataUri(source);
    if (data == null) {
      return null;
    }
    final mimeType = data.mimeType;
    if (!mimeType.startsWith('image/')) {
      return null;
    }
    final bytes = data.contentAsBytes();
    if (bytes.isEmpty) {
      return null;
    }
    if (!_isSupportedImageBytes(bytes, mimeType)) {
      return null;
    }
    return ImageData(bytes: bytes, mimeType: mimeType);
  }

  static bool _isSupportedImageBytes(Uint8List bytes, String mimeType) {
    if (mimeType == 'image/svg+xml') {
      final snippet = String.fromCharCodes(bytes.take(100));
      return snippet.contains('<svg');
    }
    if (bytes.length < 4) {
      return false;
    }
    // PNG
    if (bytes.length >= 8 &&
        bytes[0] == 0x89 &&
        bytes[1] == 0x50 &&
        bytes[2] == 0x4E &&
        bytes[3] == 0x47 &&
        bytes[4] == 0x0D &&
        bytes[5] == 0x0A &&
        bytes[6] == 0x1A &&
        bytes[7] == 0x0A) {
      return true;
    }
    // JPEG
    if (bytes[0] == 0xFF && bytes[1] == 0xD8) {
      return true;
    }
    // GIF
    if (bytes.length >= 6 &&
        bytes[0] == 0x47 &&
        bytes[1] == 0x49 &&
        bytes[2] == 0x46 &&
        bytes[3] == 0x38) {
      return true;
    }
    // WEBP
    if (bytes.length >= 12 &&
        bytes[0] == 0x52 &&
        bytes[1] == 0x49 &&
        bytes[2] == 0x46 &&
        bytes[3] == 0x46 &&
        bytes[8] == 0x57 &&
        bytes[9] == 0x45 &&
        bytes[10] == 0x42 &&
        bytes[11] == 0x50) {
      return true;
    }
    return false;
  }
}
