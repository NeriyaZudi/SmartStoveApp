import 'package:url_launcher/url_launcher.dart';

class Utils {
  static Future openLink({required String url}) {
    return _launchUrl(url);
  }

  static _launchUrl(String url) async {
    final Uri parseUrl = Uri.parse(url);
    if (await canLaunchUrl(parseUrl)) {
      await launchUrl(parseUrl);
    }
  }
}
