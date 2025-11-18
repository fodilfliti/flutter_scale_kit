import 'package:flutter/material.dart';

typedef SKImageFile = Object?;

ImageProvider<Object> createFileImage({
  required SKImageFile file,
  required double scale,
  int? cacheWidth,
  int? cacheHeight,
}) {
  throw UnsupportedError(
    'SKImage.file is only available on IO platforms (mobile/desktop).',
  );
}
