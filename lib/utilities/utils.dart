import 'package:url_launcher/url_launcher.dart';

class Utils {
  static Future<void> openLink({required String url}) async {
    try {
      final Uri parseUrl = Uri.parse(url);
      if (await canLaunchUrl(parseUrl)) {
        await launchUrl(parseUrl);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error opening link: $e');
    }
  }
}
