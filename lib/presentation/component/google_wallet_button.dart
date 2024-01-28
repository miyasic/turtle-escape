import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ggc/provider/google_wallet.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_google_wallet/widget/add_to_google_wallet_button.dart';

import '../../gen/assets.gen.dart';

class GoogleWalletButton extends ConsumerWidget {
  const GoogleWalletButton({required this.onPressed, Key? key})
      : super(key: key);
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final googleWallet = ref.watch(googleWalletProvider);
    return GestureDetector(
      onTap: () async {
        await googleWallet.initWalletClient();
        final status = await googleWallet.getWalletApiAvailabilityStatus();
        try {
          await googleWallet.savePassesJwt(
              jsonPass: token, addToGoogleWalletRequestCode: 1000);
        } catch (e) {
          print(e);
        }
      },
      child: SvgPicture.asset(Assets.svg.enUSAddToGoogleWalletWalletButton),
    );
  }
}

const token = "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJ3YWxsZXRAZ2djLTQxMjIyMS5pYW0uZ3NlcnZpY2VhY2NvdW50LmNvbSIsImF1ZCI6Imdvb2dsZSIsIm9yaWdpbnMiOlsiaHR0cDovL2xvY2FsaG9zdDozMDAwIl0sInR5cCI6InNhdmV0b3dhbGxldCIsInBheWxvYWQiOnsiZ2VuZXJpY09iamVjdHMiOlt7ImlkIjoiMzM4ODAwMDAwMDAyMjMxMjI1NS5jb2RlbGFiX29iamVjdCIsImNsYXNzSWQiOiIzMzg4MDAwMDAwMDIyMzEyMjU1LmNvZGVsYWJfY2xhc3MiLCJnZW5lcmljVHlwZSI6IkdFTkVSSUNfVFlQRV9VTlNQRUNJRklFRCIsImhleEJhY2tncm91bmRDb2xvciI6IiM0Mjg1ZjQiLCJsb2dvIjp7InNvdXJjZVVyaSI6eyJ1cmkiOiJodHRwczovL3N0b3JhZ2UuZ29vZ2xlYXBpcy5jb20vd2FsbGV0LWxhYi10b29scy1jb2RlbGFiLWFydGlmYWN0cy1wdWJsaWMvcGFzc19nb29nbGVfbG9nby5qcGcifX0sImNhcmRUaXRsZSI6eyJkZWZhdWx0VmFsdWUiOnsibGFuZ3VhZ2UiOiJlbi1VUyIsInZhbHVlIjoiR29vZ2xlIEkvTyAnMjIifX0sInN1YmhlYWRlciI6eyJkZWZhdWx0VmFsdWUiOnsibGFuZ3VhZ2UiOiJlbi1VUyIsInZhbHVlIjoiQXR0ZW5kZWUifX0sImhlYWRlciI6eyJkZWZhdWx0VmFsdWUiOnsibGFuZ3VhZ2UiOiJlbi1VUyIsInZhbHVlIjoiQWxleCBNY0phY29icyJ9fSwiYmFyY29kZSI6eyJ0eXBlIjoiUVJfQ09ERSIsInZhbHVlIjoiMzM4ODAwMDAwMDAyMjMxMjI1NS5jb2RlbGFiX29iamVjdCJ9LCJoZXJvSW1hZ2UiOnsic291cmNlVXJpIjp7InVyaSI6Imh0dHBzOi8vc3RvcmFnZS5nb29nbGVhcGlzLmNvbS93YWxsZXQtbGFiLXRvb2xzLWNvZGVsYWItYXJ0aWZhY3RzLXB1YmxpYy9nb29nbGUtaW8taGVyby1kZW1vLW9ubHkuanBnIn19LCJ0ZXh0TW9kdWxlc0RhdGEiOlt7ImhlYWRlciI6IlBPSU5UUyIsImJvZHkiOiIxMjM0IiwiaWQiOiJwb2ludHMifSx7ImhlYWRlciI6IkNPTlRBQ1RTIiwiYm9keSI6IjIwIiwiaWQiOiJjb250YWN0cyJ9XX1dfSwiaWF0IjoxNzA2NDI2MzMzfQ.rOWbYVP80GuZsLNnmgIMZHIRZ01aHZw-scXGYldeTAzti2bXg6vXe0_nc_rI7mLhB6QgeCWUEUgXSavTQHD5Beo9Hz9GSf1RQe4Nh5lRGHslAse2iqIpLXLyn0DWr1eGShIpmyDPehnYsrUeELU7Jux7_x14WfYSHSdl7GxRfmP9CMReVCmVj_0FKmZDVxSEpdGWa9puRcQ_JHLua5y3nV6r7FKXvDSuy_F3TGoPMfq1bv4ANP_9cluA9FK8WSEmdRX0bNBkw2Vwm3875fpkZEGRAIeEUEUXItc-tudXml7xQC6W8tLU5yocsuY9nHljlwCyJ_00vQqcEGkJ8_10rg";