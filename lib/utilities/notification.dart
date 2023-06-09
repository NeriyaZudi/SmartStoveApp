import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notifications {
  static Future initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize =
        const AndroidInitializationSettings('mipmap/ic_launcher');

    var initializationsSettings = InitializationSettings(
      android: androidInitialize,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationsSettings);
  }

  static Future showBigTextNotification(
      {var id = 0,
      required String title,
      required String body,
      var payload,
      required FlutterLocalNotificationsPlugin fln}) async {
    var not = NotificationDetails(
      android: AndroidNotificationDetails(
        'your_channel_id',
        'channel_name',
        playSound: true,
        importance: Importance.max,
        priority: Priority.high,
        styleInformation: BigTextStyleInformation(
          body,
          contentTitle: title,
          //summaryText: 'Notification Summary',
          htmlFormatContent:
              true, // Enable HTML formatting in the notification text
          htmlFormatTitle:
              true, // Enable HTML formatting in the notification title
          htmlFormatSummaryText:
              true, // Enable HTML formatting in the notification summary text
        ),
      ),
    );

    await fln.show(0, title, body, not);
  }
}
