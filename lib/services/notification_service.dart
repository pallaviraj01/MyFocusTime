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

  static Future<void> showTimerNotification(String time) async {
    const androidDetails = AndroidNotificationDetails(
      'focus_channel',
      'Focus Timer',
      channelDescription: 'Shows timer while focusing',
      importance: Importance.max,
      priority: Priority.high,
      ongoing: true,
      showWhen: false,
    );

    const iosDetails = DarwinNotificationDetails();

    const platformDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);

    await _notificationsPlugin.show(
      0,
      'Focus Timer Running ⏳',
      'Time Remaining: $time',
      platformDetails,
    );
  }

  static Future<void> cancelNotification() async {
    await _notificationsPlugin.cancelAll();
  }
}


/**  TEST BELOW CODE 
 * 
 * import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const String channelId = 'focus_channel';
  static const String channelName = 'Focus Timer';
  static const String channelDescription = 'Shows timer while focusing';

  static Future<void> init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();
    const initSettings = InitializationSettings(android: android, iOS: ios);

    await _notificationsPlugin.initialize(initSettings);
  }

  // Show notification for the first time with sound/vibration
  static Future<void> showTimerNotification(String time) async {
    final androidDetails = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      ongoing: true,
      showWhen: false,
      playSound: true,  // Only play sound once here
      enableVibration: true,
    );

    final iosDetails = DarwinNotificationDetails(
      presentSound: true,
    );

    final platformDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);

    await _notificationsPlugin.show(
      0,
      'Focus Timer Running ⏳',
      'Time Remaining: $time',
      platformDetails,
    );
  }

  // Update notification silently (no sound/vibration)
  static Future<void> updateTimerNotification(String time) async {
    final androidDetails = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      ongoing: true,
      showWhen: false,
      playSound: false,      // No sound on updates
      enableVibration: false,
      onlyAlertOnce: true,   // Prevents alert on update
    );

    final iosDetails = DarwinNotificationDetails(
      presentSound: false,
    );

    final platformDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);

    await _notificationsPlugin.show(
      0,
      'Focus Timer Running ⏳',
      'Time Remaining: $time',
      platformDetails,
    );
  }

  static Future<void> cancelNotification() async {
    await _notificationsPlugin.cancelAll();
  }
}

 */