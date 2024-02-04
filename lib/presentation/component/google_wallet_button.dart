import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ggc/model/wallet_pass.dart';
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
          final walletPass = WalletPass();
          final jwt = await googleWalletPassRepository.generateJwt(
            walletPass.toJson(),
          );
          if (jwt != null) {
            await googleWallet.savePassesJwt(
              jsonPass: jwt,
              addToGoogleWalletRequestCode: 1000,
            );
          }
        } catch (e) {
          logger.e(e);
        }
      },
      child: SvgPicture.asset(Assets.svg.enUSAddToGoogleWalletWalletButton),
    );
  }
}

const token =
// ignore: lines_longer_than_80_chars
    'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJ3YWxsZXRAZ2djLTQxMjIyMS5pYW0uZ3NlcnZpY2VhY2NvdW50LmNvbSIsImF1ZCI6Imdvb2dsZSIsIm9yaWdpbnMiOlsiaHR0cDovL2xvY2FsaG9zdDozMDAwIl0sInR5cCI6InNhdmV0b3dhbGxldCIsInBheWxvYWQiOnsiZ2VuZXJpY09iamVjdHMiOlt7ImlkIjoiMzM4ODAwMDAwMDAyMjMxMjI1NS5jb2RlbGFiX29iamVjdDQiLCJjbGFzc0lkIjoiMzM4ODAwMDAwMDAyMjMxMjI1NS5jb2RlbGFiX2NsYXNzMiIsImdlbmVyaWNUeXBlIjoiR0VORVJJQ19UWVBFX1VOU1BFQ0lGSUVEIiwiaGV4QmFja2dyb3VuZENvbG9yIjoiIzQyODVmNCIsImxvZ28iOnsic291cmNlVXJpIjp7InVyaSI6Imh0dHBzOi8vc3RvcmFnZS5nb29nbGVhcGlzLmNvbS93YWxsZXQtbGFiLXRvb2xzLWNvZGVsYWItYXJ0aWZhY3RzLXB1YmxpYy9wYXNzX2dvb2dsZV9sb2dvLmpwZyJ9fSwiY2FyZFRpdGxlIjp7ImRlZmF1bHRWYWx1ZSI6eyJsYW5ndWFnZSI6ImVuLVVTIiwidmFsdWUiOiJBcmUgeW91IHJlYWR5PyJ9fSwic3ViaGVhZGVyIjp7ImRlZmF1bHRWYWx1ZSI6eyJsYW5ndWFnZSI6ImVuLVVTIiwidmFsdWUiOiJTYXZlIHRoZSBlYXJ0aCEifX0sImhlYWRlciI6eyJkZWZhdWx0VmFsdWUiOnsibGFuZ3VhZ2UiOiJlbi1VUyIsInZhbHVlIjoiR2xvYmFsIEdhbWVycyBDaGFsbGVuZ2UhISJ9fSwiYmFyY29kZSI6eyJ0eXBlIjoiUVJfQ09ERSIsInZhbHVlIjoiMzM4ODAwMDAwMDAyMjMxMjI1NS5jb2RlbGFiX29iamVjdDQifSwiaGVyb0ltYWdlIjp7InNvdXJjZVVyaSI6eyJ1cmkiOiJodHRwczovL3N0b3JhZ2UuZ29vZ2xlYXBpcy5jb20vd2FsbGV0LWxhYi10b29scy1jb2RlbGFiLWFydGlmYWN0cy1wdWJsaWMvZ29vZ2xlLWlvLWhlcm8tZGVtby1vbmx5LmpwZyJ9fSwidGV4dE1vZHVsZXNEYXRhIjpbeyJoZWFkZXIiOiJQT0lOVFMiLCJib2R5IjoiMTIzNCIsImlkIjoicG9pbnRzIn0seyJoZWFkZXIiOiJDT05UQUNUUyIsImJvZHkiOiIyMCIsImlkIjoiY29udGFjdHMifV19XX0sImlhdCI6MTcwNzA1NDU4MX0.ACvS0e97Sgn_zftm8D-nMDIKeEL9LsKdxaBCbC5Dn7hKNDg_g5rluUiI3y0JhG5ZpI6UgXehHrzkDWPqKKqwhlTv-oTebi804w2xO2XM4GO9Wi5bI_QJWVyjErp4jJr3fqU9jpr2o_pV0tBquJXr_lR2JN2_8ydPq2hLT__-7fLa-G_AS6RPiuluRLKjcGkfXLwIVRdMV4L6v2UCbMFl7PSMLyfj_eGY_CZBYSZ7SNyZjs7T-CIxkcTR8PyPPH8hJtNhAOkmGbssz0PsYVapWuNEfckeobhn-Te-xGjc957TgsIom-0jGLtyJLaV0M1FKgsh22ZJ6c_HJOT8Xt-fgQ';
