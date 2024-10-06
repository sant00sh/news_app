import 'package:url_launcher/url_launcher.dart';

class Utilities {
  static Future<void> launchWeb(String? url) async {
    if (url == null) return;
    Uri? uri = Uri.tryParse(url);
    if (uri != null) {
      try {
        await launchUrl(uri);
      } catch (e) {
        throw Exception('Could not launch $url');
      }
    }
  }
}
