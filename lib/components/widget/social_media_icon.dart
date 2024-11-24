import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaIcon extends StatelessWidget {
  final String? url;
  final IconData? icon;
  final Color? color;
  const SocialMediaIcon({super.key, this.url, this.icon, this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        var newUrl = "https://$url";
        newUrl.toString();
        try {
          await _launchURL(newUrl);
        } catch (e) {
          Logger().i(e.toString());
        }
      },
      child: Icon(icon, color: color, size: 30),
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}
