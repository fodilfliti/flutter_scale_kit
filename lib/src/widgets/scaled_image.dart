import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/scale_value_factory.dart';

/// Scaled Image widget - extends Flutter's Image
/// Automatically applies scaling to width and height
/// Uses cached values for optimal performance
class SKImage extends Image {
  static final _factory = ScaleValueFactory.instance;

  SKImage({
    super.key,
    required super.image,
    super.frameBuilder,
    super.loadingBuilder,
    super.errorBuilder,
    super.semanticLabel,
    super.excludeFromSemantics = false,
    double? width,
    double? height,
    super.color,
    super.colorBlendMode,
    super.fit,
    super.alignment = Alignment.center,
    super.repeat = ImageRepeat.noRepeat,
    super.centerSlice,
    super.matchTextDirection = false,
    super.gaplessPlayback = false,
    super.filterQuality = FilterQuality.low,
    super.isAntiAlias = false,
    super.opacity,
  }) : super(
         width: width != null ? _factory.createWidth(width) : null,
         height: height != null ? _factory.createHeight(height) : null,
       );

  /// Creates an image widget from an asset bundle.
  ///
  /// The [name] argument must not be null. It should be the name of an asset
  /// in the asset bundle, as would be passed to [AssetBundle.load].
  ///
  /// The [package] argument must be non-null when loading an asset from a
  /// package. See [AssetImage] for details.
  ///
  /// Automatically applies scaling to [width] and [height] parameters.
  SKImage.asset(
    String name, {
    super.key,
    AssetBundle? bundle,
    super.frameBuilder,
    super.errorBuilder,
    super.semanticLabel,
    super.excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    super.color,
    super.colorBlendMode,
    super.fit,
    super.alignment = Alignment.center,
    super.repeat = ImageRepeat.noRepeat,
    super.centerSlice,
    super.matchTextDirection = false,
    super.gaplessPlayback = false,
    super.isAntiAlias = false,
    String? package,
    super.filterQuality = FilterQuality.low,
  }) : super(
         image:
             scale != null
                 ? ExactAssetImage(
                   name,
                   bundle: bundle,
                   package: package,
                   scale: scale,
                 )
                 : AssetImage(name, bundle: bundle, package: package),
         width: width != null ? _factory.createWidth(width) : null,
         height: height != null ? _factory.createHeight(height) : null,
       );

  /// Creates an image widget from a network URL.
  ///
  /// The [src] argument must not be null. It should be a valid URL pointing to an image.
  ///
  /// Automatically applies scaling to [width] and [height] parameters.
  SKImage.network(
    String src, {
    super.key,
    super.frameBuilder,
    super.errorBuilder,
    super.semanticLabel,
    super.excludeFromSemantics = false,
    double? scale = 1.0,
    double? width,
    double? height,
    super.color,
    super.colorBlendMode,
    super.fit,
    super.alignment = Alignment.center,
    super.repeat = ImageRepeat.noRepeat,
    super.centerSlice,
    super.matchTextDirection = false,
    super.gaplessPlayback = false,
    super.filterQuality = FilterQuality.low,
    super.isAntiAlias = false,
    Map<String, String>? headers,
    int? cacheWidth,
    int? cacheHeight,
  }) : super(
         image: _createNetworkImageProvider(
           src: src,
           scale: scale,
           headers: headers,
           cacheWidth: cacheWidth,
           cacheHeight: cacheHeight,
         ),
         width: width != null ? _factory.createWidth(width) : null,
         height: height != null ? _factory.createHeight(height) : null,
       );

  /// Creates an image widget from a file.
  ///
  /// The [file] argument must not be null. It should be a [File] object pointing to an image file.
  ///
  /// Automatically applies scaling to [width] and [height] parameters.
  SKImage.file(
    File file, {
    super.key,
    super.frameBuilder,
    super.errorBuilder,
    super.semanticLabel,
    super.excludeFromSemantics = false,
    double scale = 1.0,
    double? width,
    double? height,
    super.color,
    super.colorBlendMode,
    super.fit,
    super.alignment = Alignment.center,
    super.repeat = ImageRepeat.noRepeat,
    super.centerSlice,
    super.matchTextDirection = false,
    super.gaplessPlayback = false,
    super.filterQuality = FilterQuality.low,
    super.isAntiAlias = false,
    int? cacheWidth,
    int? cacheHeight,
  }) : super(
         image: _createFileImageProvider(
           file: file,
           scale: scale,
           cacheWidth: cacheWidth,
           cacheHeight: cacheHeight,
         ),
         width: width != null ? _factory.createWidth(width) : null,
         height: height != null ? _factory.createHeight(height) : null,
       );

  /// Creates an image widget from in-memory image data.
  ///
  /// The [bytes] argument must not be null. It should be a [Uint8List] containing image data.
  ///
  /// Automatically applies scaling to [width] and [height] parameters.
  SKImage.memory(
    Uint8List bytes, {
    super.key,
    super.frameBuilder,
    super.errorBuilder,
    super.semanticLabel,
    super.excludeFromSemantics = false,
    double scale = 1.0,
    double? width,
    double? height,
    super.color,
    super.colorBlendMode,
    super.fit,
    super.alignment = Alignment.center,
    super.repeat = ImageRepeat.noRepeat,
    super.centerSlice,
    super.matchTextDirection = false,
    super.gaplessPlayback = false,
    super.filterQuality = FilterQuality.low,
    super.isAntiAlias = false,
    int? cacheWidth,
    int? cacheHeight,
  }) : super(
         image: _createMemoryImageProvider(
           bytes: bytes,
           scale: scale,
           cacheWidth: cacheWidth,
           cacheHeight: cacheHeight,
         ),
         width: width != null ? _factory.createWidth(width) : null,
         height: height != null ? _factory.createHeight(height) : null,
       );

  static ImageProvider _createNetworkImageProvider({
    required String src,
    double? scale,
    Map<String, String>? headers,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    ImageProvider provider = NetworkImage(
      src,
      scale: scale ?? 1.0,
      headers: headers,
    );

    if (cacheWidth != null || cacheHeight != null) {
      provider = ResizeImage(provider, width: cacheWidth, height: cacheHeight);
    }

    return provider;
  }

  static ImageProvider _createFileImageProvider({
    required File file,
    required double scale,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    ImageProvider provider = FileImage(file, scale: scale);

    if (cacheWidth != null || cacheHeight != null) {
      provider = ResizeImage(provider, width: cacheWidth, height: cacheHeight);
    }

    return provider;
  }

  static ImageProvider _createMemoryImageProvider({
    required Uint8List bytes,
    required double scale,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    ImageProvider provider = MemoryImage(bytes, scale: scale);

    if (cacheWidth != null || cacheHeight != null) {
      provider = ResizeImage(provider, width: cacheWidth, height: cacheHeight);
    }

    return provider;
  }
}
