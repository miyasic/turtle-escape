import 'package:flutter/material.dart';
import 'package:ggc/constants/urls.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicyButton extends StatelessWidget {
  const PrivacyPolicyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // url_launcherでプライバシーポリシーを開く
        await launchUrl(
          Uri.parse(privacyPolicyUrl),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          'プライバシーポリシー',
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
