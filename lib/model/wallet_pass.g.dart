// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_pass.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WalletPassImpl _$$WalletPassImplFromJson(Map<String, dynamic> json) =>
    _$WalletPassImpl(
      id: json['id'] as String? ?? '3388000000022312255.codelab_object3',
      classId:
          json['classId'] as String? ?? '3388000000022312255.codelab_class2',
      genericType: json['genericType'] as String? ?? 'GENERIC_TYPE_UNSPECIFIED',
      hexBackgroundColor: json['hexBackgroundColor'] as String? ?? '#4285f4',
      logo: json['logo'] == null
          ? const Logo()
          : Logo.fromJson(json['logo'] as Map<String, dynamic>),
      cardTitle: json['cardTitle'] == null
          ? const CardTitle(defaultValue: DefaultValue(value: 'Are you ready?'))
          : DefalutValueWrapper.fromJson(
              json['cardTitle'] as Map<String, dynamic>),
      subheader: json['subheader'] == null
          ? const Subheader(
              defaultValue: DefaultValue(value: 'Save the earth!'))
          : DefalutValueWrapper.fromJson(
              json['subheader'] as Map<String, dynamic>),
      header: json['header'] == null
          ? const Header(
              defaultValue: DefaultValue(value: 'Global Gamers Challenge!!'))
          : DefalutValueWrapper.fromJson(
              json['header'] as Map<String, dynamic>),
      barcode: json['barcode'] == null
          ? const Barcode(value: '3388000000022312255.codelab_object3')
          : Barcode.fromJson(json['barcode'] as Map<String, dynamic>),
      heroImage: json['heroImage'] == null
          ? const HeroImage()
          : HeroImage.fromJson(json['heroImage'] as Map<String, dynamic>),
      textModulesData: (json['textModulesData'] as List<dynamic>?)
              ?.map((e) => TextModulesData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [
            TextModulesData(header: 'POINTS', body: '1234', id: 'points'),
            TextModulesData(header: 'CONTACTS', body: '20', id: 'contacts')
          ],
    );

Map<String, dynamic> _$$WalletPassImplToJson(_$WalletPassImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'classId': instance.classId,
      'genericType': instance.genericType,
      'hexBackgroundColor': instance.hexBackgroundColor,
      'logo': instance.logo,
      'cardTitle': instance.cardTitle,
      'subheader': instance.subheader,
      'header': instance.header,
      'barcode': instance.barcode,
      'heroImage': instance.heroImage,
      'textModulesData': instance.textModulesData,
    };

_$LogoImpl _$$LogoImplFromJson(Map<String, dynamic> json) => _$LogoImpl(
      sourceUri: json['sourceUri'] == null
          ? const SourceUri(
              uri:
                  'https://storage.googleapis.com/wallet-lab-tools-codelab-artifacts-public/pass_google_logo.jpg')
          : SourceUri.fromJson(json['sourceUri'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$LogoImplToJson(_$LogoImpl instance) =>
    <String, dynamic>{
      'sourceUri': instance.sourceUri,
    };

_$SourceUriImpl _$$SourceUriImplFromJson(Map<String, dynamic> json) =>
    _$SourceUriImpl(
      uri: json['uri'] as String,
    );

Map<String, dynamic> _$$SourceUriImplToJson(_$SourceUriImpl instance) =>
    <String, dynamic>{
      'uri': instance.uri,
    };

_$DefalutValueWrapperImpl _$$DefalutValueWrapperImplFromJson(
        Map<String, dynamic> json) =>
    _$DefalutValueWrapperImpl(
      defaultValue: json['defaultValue'] == null
          ? null
          : DefaultValue.fromJson(json['defaultValue'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$DefalutValueWrapperImplToJson(
        _$DefalutValueWrapperImpl instance) =>
    <String, dynamic>{
      'defaultValue': instance.defaultValue,
    };

_$DefaultValueImpl _$$DefaultValueImplFromJson(Map<String, dynamic> json) =>
    _$DefaultValueImpl(
      language: json['language'] as String? ?? 'en-US',
      value: json['value'] as String,
    );

Map<String, dynamic> _$$DefaultValueImplToJson(_$DefaultValueImpl instance) =>
    <String, dynamic>{
      'language': instance.language,
      'value': instance.value,
    };

_$BarcodeImpl _$$BarcodeImplFromJson(Map<String, dynamic> json) =>
    _$BarcodeImpl(
      type: json['type'] as String? ?? 'QR_CODE',
      value: json['value'] as String,
    );

Map<String, dynamic> _$$BarcodeImplToJson(_$BarcodeImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'value': instance.value,
    };

_$HeroImageImpl _$$HeroImageImplFromJson(Map<String, dynamic> json) =>
    _$HeroImageImpl(
      sourceUri: json['sourceUri'] == null
          ? const SourceUri(
              uri:
                  'https://storage.googleapis.com/wallet-lab-tools-codelab-artifacts-public/google-io-hero-demo-only.jpg')
          : SourceUri.fromJson(json['sourceUri'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$HeroImageImplToJson(_$HeroImageImpl instance) =>
    <String, dynamic>{
      'sourceUri': instance.sourceUri,
    };

_$TextModulesDataImpl _$$TextModulesDataImplFromJson(
        Map<String, dynamic> json) =>
    _$TextModulesDataImpl(
      header: json['header'] as String,
      body: json['body'] as String,
      id: json['id'] as String,
    );

Map<String, dynamic> _$$TextModulesDataImplToJson(
        _$TextModulesDataImpl instance) =>
    <String, dynamic>{
      'header': instance.header,
      'body': instance.body,
      'id': instance.id,
    };
