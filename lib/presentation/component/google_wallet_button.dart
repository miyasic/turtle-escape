import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ggc/model/wallet_pass.dart';
import 'package:ggc/provider/google_wallet.dart';
import 'package:ggc/provider/google_wallet_pass_repository.dart';
import 'package:ggc/util/logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../gen/assets.gen.dart';

class GoogleWalletButton extends ConsumerWidget {
  const GoogleWalletButton({required this.score, super.key});
  final String score;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final googleWallet = ref.watch(googleWalletProvider);
    final googleWalletPassRepository =
        ref.watch(googleWalletPassRepositoryProvider);
    return GestureDetector(
      onTap: () async {
        await googleWallet.initWalletClient();
        try {
          final issureId = '3388000000022312255';
          final uuid = const Uuid().v4();
          final id = '$issureId.$uuid';
          final classId = '$issureId.codelab_class2';
          final cardTitle =
              DefalutValueWrapper.defaultValue(value: 'Your score is $score');
          final colorCode = '#00ffff';
          final HeroImage heroImage =
              HeroImage.fromUri('https://picsum.photos/600/200');
          final Barcode barcode = Barcode.qrCode(
              value: 'https://www.unicef.or.jp/kodomo/sdgs/17goals/14-sea/');
          final walletPass = WalletPass(
            cardTitle: cardTitle,
            id: id,
            classId: classId,
            hexBackgroundColor: colorCode,
            heroImage: heroImage,
            barcode: barcode,
          );

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

final jwt =
    'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJ3YWxsZXRAZ2djLTQxMjIyMS5pYW0uZ3NlcnZpY2VhY2NvdW50LmNvbSIsImF1ZCI6Imdvb2dsZSIsIm9yaWdpbnMiOlsiaHR0cDovL2xvY2FsaG9zdDozMDAwIl0sInR5cCI6InNhdmV0b3dhbGxldCIsInBheWxvYWQiOnsiZ2VuZXJpY09iamVjdHMiOlt7ImlkIjoiMzM4ODAwMDAwMDAyMjMxMjI1NS5jb2RlbGFiX29iamVjdDYiLCJjbGFzc0lkIjoiMzM4ODAwMDAwMDAyMjMxMjI1NS5jb2RlbGFiX2NsYXNzMiIsImdlbmVyaWNUeXBlIjoiR0VORVJJQ19UWVBFX1VOU1BFQ0lGSUVEIiwiaGV4QmFja2dyb3VuZENvbG9yIjoiI0ZGRkZGRiIsImxvZ28iOnsic291cmNlVXJpIjp7InVyaSI6Imh0dHBzOi8vc3RvcmFnZS5nb29nbGVhcGlzLmNvbS93YWxsZXQtbGFiLXRvb2xzLWNvZGVsYWItYXJ0aWZhY3RzLXB1YmxpYy9wYXNzX2dvb2dsZV9sb2dvLmpwZyJ9fSwiY2FyZFRpdGxlIjp7ImRlZmF1bHRWYWx1ZSI6eyJsYW5ndWFnZSI6ImVuLVVTIiwidmFsdWUiOiJJIEdvdCBpdCEifX0sInN1YmhlYWRlciI6eyJkZWZhdWx0VmFsdWUiOnsibGFuZ3VhZ2UiOiJlbi1VUyIsInZhbHVlIjoiU2F2ZSB0aGUgZWFydGghIn19LCJoZWFkZXIiOnsiZGVmYXVsdFZhbHVlIjp7Imxhbmd1YWdlIjoiZW4tVVMiLCJ2YWx1ZSI6Ikdsb2JhbCBHYW1lcnMgQ2hhbGxlbmdlISEifX0sImJhcmNvZGUiOnsidHlwZSI6IlFSX0NPREUiLCJ2YWx1ZSI6IjMzODgwMDAwMDAwMjIzMTIyNTUuY29kZWxhYl9vYmplY3Q2In0sImhlcm9JbWFnZSI6eyJzb3VyY2VVcmkiOnsidXJpIjoiaHR0cHM6Ly9zdG9yYWdlLmdvb2dsZWFwaXMuY29tL3dhbGxldC1sYWItdG9vbHMtY29kZWxhYi1hcnRpZmFjdHMtcHVibGljL2dvb2dsZS1pby1oZXJvLWRlbW8tb25seS5qcGcifX0sInRleHRNb2R1bGVzRGF0YSI6W3siaGVhZGVyIjoiUE9JTlRTIiwiYm9keSI6IjEyMzQiLCJpZCI6InBvaW50cyJ9LHsiaGVhZGVyIjoiQ09OVEFDVFMiLCJib2R5IjoiMjAiLCJpZCI6ImNvbnRhY3RzIn1dfV19LCJpYXQiOjE3MDgyMjM3NzZ9.BOMDykSzfJz8dF8zBSCw1SlcxLJvqdTzZo7hTCu02PD3G9fhFnT0Z7OX_9gT6SVdAAdSQcDHPtvolwvUnD1_tJFuqwlQCuYVC_u1L8qiCDo0BCfhwyhrErf0syEBAQJvbhRzDJmVTrnO2PupOGYgElE0wF0fE1m0lH8daqtfNTiH4V7bl4F8YcSRKRI7n3nnQAD63yegPEttI3OHa198kehtBZSWKbz1gUp2s4jpJuuOjtSJn6tiZDFrRQYN4xWu8BDFS3e9bFneh0EuYoajhQTKj38BIjwQ1aCx_uqlvOGi2bNXtu3lT5WhNdpesyIvRACHnFGcV0VNLE0CB4A3nw';
