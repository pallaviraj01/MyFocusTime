import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();
    const initSettings = InitializationSettings(android: android, iOS: ios);

    await _notificationsPlugin.initialize(initSettings);
  }

  static Future<void> showPersistentNotification() async {
    const androidDetails = AndroidNotificationDetails(
      'focus_channel',
      'Focus Timer',
      channelDescription: 'Indicates that the focus timer is running',
      importance: Importance.low, // no heads-up
      priority: Priority.low,
      ongoing: true, // This keeps it persistent
      showWhen: false,
    );

    const iosDetails = DarwinNotificationDetails();

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notificationsPlugin.show(
      0, // Static ID to overwrite if shown again
      'Focus Timer ⏳',
      'Your focus session is in progress.',
      notificationDetails,
    );
  }

  static Future<void> cancelNotification() async {
    await _notificationsPlugin.cancelAll();
  }
}