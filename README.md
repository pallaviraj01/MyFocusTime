# 🧘‍♂️ MyFocusTime

**A beautifully simple focus timer app built with Flutter.**  
Helps you stay focused using a countdown timer, local notifications, and a calming UI.

## ✨ Features

- ⏳ Pomodoro-style focus timer (25 mins default)
- 🔔 Local notifications when app is minimized
- 📱 Elegant UI with smooth background animation
- 🎛️ Pause, reset, or continue your session easily
- 🛠️ Built using Riverpod for state management
- ⚙️ Ready for Android 12+ with proper permissions and notification setup

## 📸 Screenshots

*Coming soon*

## 🚀 Getting Started

### Prerequisites

- Flutter 3.10 or later
- Dart 3.x
- Android SDK 33 or above

### Run the app

```bash
flutter pub get
```
```bash
flutter run
```

## 📦 Packages Used 
- Get latest package versions from pub.dev (https://pub.dev/)
```bash
flutter_local_notifications
```
```bash
flutter_riverpod
```
```bash
google_fonts
```
```bash
permission_handler
```
## 🔐 Permissions
Make sure these permissions are added in your AndroidManifest.xml:
```xml
<!-- Needed to schedule exact alarms (Android 12+) -->
<uses-permission android:name="android.permission.SCHEDULE_EXACT_ALARM"/>

<!-- Required to reschedule notifications after device reboot -->
<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>

<!-- Required for using foreground services like persistent notifications -->
<uses-permission android:name="android.permission.FOREGROUND_SERVICE"/>

<!-- Needed for showing notifications (Android 13+) -->
<uses-permission android:name="android.permission.POST_NOTIFICATIONS" />

```
And the following components should be declared inside the <application> tag to support notification behavior across devices:
```xml
<!-- Runs when the device boots to restore scheduled notifications (Android 12+) -->
<receiver android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationBootReceiver"
          android:exported="true">
    <intent-filter>
        <action android:name="android.intent.action.BOOT_COMPLETED"/>
    </intent-filter>
</receiver>

<!-- Required for handling scheduled notifications (All Android versions) -->
<receiver android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationReceiver" />

<!-- Required to display ongoing notifications using a foreground service (Android 9+) -->
<service android:name="com.dexterous.flutterlocalnotifications.ForegroundService"
         android:exported="true" />
```
## 🛠 Development Status
✅ Functional
- 🚧 More features coming soon: time selection, break sessions, user settings, and history tracking.
- Inspired by Pomodoro productivity techniques and apps like Forest.

## 📄 License
MIT License.
Feel free to use and share!
