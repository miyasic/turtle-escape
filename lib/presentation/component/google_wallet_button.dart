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
