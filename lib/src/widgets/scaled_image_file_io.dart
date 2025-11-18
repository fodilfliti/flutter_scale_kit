import 'dart:io';
import 'package:flutter/material.dart';

typedef SKImageFile = File;

ImageProvider<Object> createFileImage({
  required SKImageFile file,
  required double scale,
  int? cacheWidth,
  int? cacheHeight,
}) {
  ImageProvider<Object> provider = FileImage(file, scale: scale);

  if (cacheWidth != null || cacheHeight != null) {
    provider = ResizeImage(provider, width: cacheWidth, height: cacheHeight);
  }

  return provider;
}
