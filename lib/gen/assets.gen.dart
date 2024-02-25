/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/bottle.png
  AssetGenImage get bottle => const AssetGenImage('assets/images/bottle.png');

  /// File path: assets/images/icon-adaptive.png
  AssetGenImage get iconAdaptive =>
      const AssetGenImage('assets/images/icon-adaptive.png');

  /// File path: assets/images/icon.png
  AssetGenImage get icon => const AssetGenImage('assets/images/icon.png');

  /// File path: assets/images/plastic_bag.png
  AssetGenImage get plasticBag =>
      const AssetGenImage('assets/images/plastic_bag.png');

  /// File path: assets/images/sea_background.jpg
  AssetGenImage get seaBackground =>
      const AssetGenImage('assets/images/sea_background.jpg');

  /// File path: assets/images/sea_turtle.png
  AssetGenImage get seaTurtle =>
      const AssetGenImage('assets/images/sea_turtle.png');

  /// File path: assets/images/splash-icon.png
  AssetGenImage get splashIcon =>
      const AssetGenImage('assets/images/splash-icon.png');

  /// File path: assets/images/straw.png
  AssetGenImage get straw => const AssetGenImage('assets/images/straw.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        bottle,
        iconAdaptive,
        icon,
        plasticBag,
        seaBackground,
        seaTurtle,
        splashIcon,
        straw
      ];
}

class $AssetsLottieGen {
  const $AssetsLottieGen();

  /// File path: assets/lottie/programming.json
  String get programming => 'assets/lottie/programming.json';

  /// List of all assets
  List<String> get values => [programming];
}

class $AssetsSvgGen {
  const $AssetsSvgGen();

  /// File path: assets/svg/enUS_add_to_google_wallet_add-wallet-badge.svg
  String get enUSAddToGoogleWalletAddWalletBadge =>
      'assets/svg/enUS_add_to_google_wallet_add-wallet-badge.svg';

  /// File path: assets/svg/enUS_add_to_google_wallet_wallet-button.svg
  String get enUSAddToGoogleWalletWalletButton =>
      'assets/svg/enUS_add_to_google_wallet_wallet-button.svg';

  /// File path: assets/svg/jp_add_to_google_wallet_add-wallet-badge.svg
  String get jpAddToGoogleWalletAddWalletBadge =>
      'assets/svg/jp_add_to_google_wallet_add-wallet-badge.svg';

  /// File path: assets/svg/jp_add_to_google_wallet_wallet-button.svg
  String get jpAddToGoogleWalletWalletButton =>
      'assets/svg/jp_add_to_google_wallet_wallet-button.svg';

  /// List of all assets
  List<String> get values => [
        enUSAddToGoogleWalletAddWalletBadge,
        enUSAddToGoogleWalletWalletButton,
        jpAddToGoogleWalletAddWalletBadge,
        jpAddToGoogleWalletWalletButton
      ];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsLottieGen lottie = $AssetsLottieGen();
  static const $AssetsSvgGen svg = $AssetsSvgGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
