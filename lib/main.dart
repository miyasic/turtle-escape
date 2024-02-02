import 'package:flutter/material.dart';
import 'package:flutter_google_wallet/generated/l10n.dart';
import 'package:ggc/presentation/game_app.dart';
import 'package:ggc/router.dart';
import 'package:ggc/scaffold_messenger.dart';
import 'package:ggc/theme.dart';
import 'package:ggc/util/provider_logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(ProviderScope(observers: [ProviderLogger()], child: const GameApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final lightTheme = ref.watch(themeProvider(Brightness.light));
    final darkTheme = ref.watch(themeProvider(Brightness.dark));
    return MaterialApp.router(
      scaffoldMessengerKey: ref.watch(scaffoldMessengerKeyProvider),
      routeInformationProvider: router.routeInformationProvider,
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      localizationsDelegates: const [
        I18nGoogleWallet.delegate,
      ],
      theme: lightTheme,
      darkTheme: darkTheme,
    );
  }
}
