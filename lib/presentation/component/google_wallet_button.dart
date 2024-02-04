import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ggc/provider/google_wallet.dart';
import 'package:ggc/provider/google_wallet_pass_repository.dart';
import 'package:ggc/util/logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../gen/assets.gen.dart';

class GoogleWalletButton extends ConsumerWidget {
  const GoogleWalletButton({required this.onPressed, super.key});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final googleWallet = ref.watch(googleWalletProvider);
    final googleWalletPassRepository =
        ref.watch(googleWalletPassRepositoryProvider);
    return GestureDetector(
      onTap: () async {
        await googleWallet.initWalletClient();
        try {
          final jwt = await googleWalletPassRepository.generateJwt(requestData);
          if (jwt != null) {
            await googleWallet.savePassesJwt(
              jsonPass: jwt,
              addToGoogleWalletRequestCode: 1000,
            );
          }
        } on PlatformException catch (e) {
          logger.e(e);
        }
      },
      child: SvgPicture.asset(Assets.svg.enUSAddToGoogleWalletWalletButton),
    );
  }
}

const token =
// ignore: lines_longer_than_80_chars
    'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJ3YWxsZXRAZ2djLTQxMjIyMS5pYW0uZ3NlcnZpY2VhY2NvdW50LmNvbSIsImF1ZCI6Imdvb2dsZSIsIm9yaWdpbnMiOlsiaHR0cDovL2xvY2FsaG9zdDozMDAwIl0sInR5cCI6InNhdmV0b3dhbGxldCIsInBheWxvYWQiOnsiZ2VuZXJpY09iamVjdHMiOlt7ImlkIjoiMzM4ODAwMDAwMDAyMjMxMjI1NS5jb2RlbGFiX29iamVjdDMiLCJjbGFzc0lkIjoiMzM4ODAwMDAwMDAyMjMxMjI1NS5jb2RlbGFiX2NsYXNzMiIsImdlbmVyaWNUeXBlIjoiR0VORVJJQ19UWVBFX1VOU1BFQ0lGSUVEIiwiaGV4QmFja2dyb3VuZENvbG9yIjoiIzQyODVmNCIsImxvZ28iOnsic291cmNlVXJpIjp7InVyaSI6Imh0dHBzOi8vc3RvcmFnZS5nb29nbGVhcGlzLmNvbS93YWxsZXQtbGFiLXRvb2xzLWNvZGVsYWItYXJ0aWZhY3RzLXB1YmxpYy9wYXNzX2dvb2dsZV9sb2dvLmpwZyJ9fSwiY2FyZFRpdGxlIjp7ImRlZmF1bHRWYWx1ZSI6eyJsYW5ndWFnZSI6ImVuLVVTIiwidmFsdWUiOiJBcmUgeW91IHJlYWR5PyJ9fSwic3ViaGVhZGVyIjp7ImRlZmF1bHRWYWx1ZSI6eyJsYW5ndWFnZSI6ImVuLVVTIiwidmFsdWUiOiJTYXZlIHRoZSBlYXJ0aCEifX0sImhlYWRlciI6eyJkZWZhdWx0VmFsdWUiOnsibGFuZ3VhZ2UiOiJlbi1VUyIsInZhbHVlIjoiR2xvYmFsIEdhbWVycyBDaGFsbGVuZ2UhISJ9fSwiYmFyY29kZSI6eyJ0eXBlIjoiUVJfQ09ERSIsInZhbHVlIjoiMzM4ODAwMDAwMDAyMjMxMjI1NS5jb2RlbGFiX29iamVjdDMifSwiaGVyb0ltYWdlIjp7InNvdXJjZVVyaSI6eyJ1cmkiOiJodHRwczovL3N0b3JhZ2UuZ29vZ2xlYXBpcy5jb20vd2FsbGV0LWxhYi10b29scy1jb2RlbGFiLWFydGlmYWN0cy1wdWJsaWMvZ29vZ2xlLWlvLWhlcm8tZGVtby1vbmx5LmpwZyJ9fSwidGV4dE1vZHVsZXNEYXRhIjpbeyJoZWFkZXIiOiJQT0lOVFMiLCJib2R5IjoiMTIzNCIsImlkIjoicG9pbnRzIn0seyJoZWFkZXIiOiJDT05UQUNUUyIsImJvZHkiOiIyMCIsImlkIjoiY29udGFjdHMifV19XX0sImlhdCI6MTcwNzA0NDE3N30.U0TeflWYv1eeQwEOknFqdlQhF6f0_qOVVz_OehPXPJWykyznElbKfdvZvQCl7jXFFrBgeMvukhags3JK8dPdP66l_qPCf9-XiZqpx3MdZR31PPpfm1p6GF-CCHIweQDJGzJGn_FQhIo3nPlNa4c311gotsiXYu3tNpidIKOORChtMe3tI8efT-m5thFYVvt6b6tAQRYbXDy3qSssGk1vDXk0P3VHfVEkCvZ1W6J2Voz242z53q35OjEYaNEn-YzxWXvtTZzKtA0d-kLYGfqt7Y8yut2SlI5z_0kzdjIh_ytqDByOp5cecGfu40IsR53iYxLQPPQn_JrtpQaXeFQREw';

Map<String, dynamic> requestData = {
  'id': '3388000000022312255.codelab_object3',
  'classId': '3388000000022312255.codelab_class2',
  'genericType': 'GENERIC_TYPE_UNSPECIFIED',
  'hexBackgroundColor': '#4285f4',
  'logo': {
    'sourceUri': {
      'uri':
          'https://storage.googleapis.com/wallet-lab-tools-codelab-artifacts-public/pass_google_logo.jpg',
    },
  },
  'cardTitle': {
    'defaultValue': {'language': 'en-US', 'value': 'Are you ready?'},
  },
  'subheader': {
    'defaultValue': {'language': 'en-US', 'value': 'Save the earth!'},
  },
  'header': {
    'defaultValue': {'language': 'en-US', 'value': 'Global Gamers Challenge!!'},
  },
  'barcode': {
    'type': 'QR_CODE',
    'value': '3388000000022312255.codelab_object3',
  },
  'heroImage': {
    'sourceUri': {
      'uri':
          'https://storage.googleapis.com/wallet-lab-tools-codelab-artifacts-public/google-io-hero-demo-only.jpg',
    },
  },
  'textModulesData': [
    {'header': 'POINTS', 'body': '1234', 'id': 'points'},
    {'header': 'CONTACTS', 'body': '20', 'id': 'contacts'},
  ],
};
