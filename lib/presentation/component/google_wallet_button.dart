import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ggc/constants/values.dart';
import 'package:ggc/model/wallet_pass.dart';
import 'package:ggc/provider/google_wallet.dart';
import 'package:ggc/provider/google_wallet_pass_repository.dart';
import 'package:ggc/util/logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../gen/assets.gen.dart';

class GoogleWalletButton extends ConsumerWidget {
  const GoogleWalletButton({required this.score, super.key});
  final int score;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final googleWallet = ref.watch(googleWalletProvider);
    final googleWalletPassRepository =
        ref.watch(googleWalletPassRepositoryProvider);
    return GestureDetector(
      onTap: () async {
        await googleWallet.initWalletClient();
        try {
          final jwt = await googleWalletPassRepository.generateJwt(
            _createWalletPass().toJson(),
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

  WalletPass _createWalletPass() {
    final uuid = const Uuid().v4();
    final id = '$issureId.$uuid';
    const classId = '$issureId.$className';
    final cardTitle = DefalutValueWrapper.defaultValue(value: '今回のスコアは $score');
    final subheader = DefalutValueWrapper.defaultValue(value: subHeader);
    final header = DefalutValueWrapper.defaultValue(value: _header());
    const colorCode = '#00ffff';
    final heroImage = HeroImage.fromUri(imageUrl);
    return WalletPass(
      cardTitle: cardTitle,
      id: id,
      classId: classId,
      hexBackgroundColor: colorCode,
      heroImage: heroImage,
      subheader: subheader,
      header: header,
    );
  }

  String _header() {
    if (score < 10) {
      return headerA;
    }
    if (score < 20) {
      return headerB;
    }
    return headerC;
  }
}
