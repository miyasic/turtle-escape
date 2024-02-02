import 'package:flutter_google_wallet/flutter_google_wallet_plugin.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'google_wallet.g.dart';

@riverpod
FlutterGoogleWalletPlugin googleWallet(GoogleWalletRef ref) =>
    FlutterGoogleWalletPlugin();
