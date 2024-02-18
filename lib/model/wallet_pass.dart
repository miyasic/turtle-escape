import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_pass.freezed.dart';
part 'wallet_pass.g.dart';

@freezed
class WalletPass with _$WalletPass {
  const factory WalletPass({
    @Default('3388000000022312255.codelab_object3') String id,
    @Default('3388000000022312255.codelab_class2') String classId,
    @Default('GENERIC_TYPE_UNSPECIFIED') String genericType,
    @Default('#4285f4') String hexBackgroundColor,
    @Default(Logo()) Logo logo,
    @Default(CardTitle(defaultValue: DefaultValue(value: 'Are you ready?')))
    CardTitle cardTitle,
    @Default(Subheader(defaultValue: DefaultValue(value: 'Save the earth!')))
    Subheader subheader,
    @Default(
        Header(defaultValue: DefaultValue(value: 'Global Gamers Challenge!!')))
    Header header,
    @Default(Barcode(value: '3388000000022312255.codelab_object3'))
    Barcode barcode,
    @Default(HeroImage()) HeroImage heroImage,
    @Default([
      TextModulesData(header: 'POINTS', body: '1234', id: 'points'),
      TextModulesData(header: 'CONTACTS', body: '20', id: 'contacts'),
    ])
    List<TextModulesData> textModulesData,
  }) = _WalletPass;

  factory WalletPass.fromJson(Map<String, dynamic> json) =>
      _$WalletPassFromJson(json);
}

@freezed
class Logo with _$Logo {
  const factory Logo({
    @Default(
      SourceUri(
        uri:
            'https://storage.googleapis.com/wallet-lab-tools-codelab-artifacts-public/pass_google_logo.jpg',
      ),
    )
    SourceUri sourceUri,
  }) = _Logo;

  factory Logo.fromJson(Map<String, dynamic> json) => _$LogoFromJson(json);
}

@freezed
class SourceUri with _$SourceUri {
  const factory SourceUri({
    required String uri,
  }) = _SourceUri;

  factory SourceUri.fromJson(Map<String, dynamic> json) =>
      _$SourceUriFromJson(json);
}

@freezed
class DefalutValueWrapper with _$DefalutValueWrapper {
  const factory DefalutValueWrapper({
    DefaultValue? defaultValue,
  }) = _DefalutValueWrapper;

  factory DefalutValueWrapper.fromJson(Map<String, dynamic> json) =>
      _$DefalutValueWrapperFromJson(json);
}

@freezed
class DefaultValue with _$DefaultValue {
  const factory DefaultValue({
    @Default('en-US') String language,
    required String value,
  }) = _DefaultValue;

  factory DefaultValue.fromJson(Map<String, dynamic> json) =>
      _$DefaultValueFromJson(json);
}

@freezed
class Barcode with _$Barcode {
  const factory Barcode({
    @Default('QR_CODE') String type,
    required String value,
  }) = _Barcode;

  factory Barcode.fromJson(Map<String, dynamic> json) =>
      _$BarcodeFromJson(json);
}

@freezed
class HeroImage with _$HeroImage {
  const factory HeroImage({
    @Default(
      SourceUri(
        uri:
            'https://storage.googleapis.com/wallet-lab-tools-codelab-artifacts-public/google-io-hero-demo-only.jpg',
      ),
    )
    SourceUri sourceUri,
  }) = _HeroImage;

  factory HeroImage.fromJson(Map<String, dynamic> json) =>
      _$HeroImageFromJson(json);
}

@freezed
class TextModulesData with _$TextModulesData {
  const factory TextModulesData({
    required String header,
    required String body,
    required String id,
  }) = _TextModulesData;

  factory TextModulesData.fromJson(Map<String, dynamic> json) =>
      _$TextModulesDataFromJson(json);
}

typedef CardTitle = DefalutValueWrapper;
typedef Subheader = DefalutValueWrapper;
typedef Header = DefalutValueWrapper;
