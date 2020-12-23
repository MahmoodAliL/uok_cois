import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:uok_cois/models/notification_message.dart';

class FirebaseNotificationWidget extends StatefulWidget {
  @override
  _FirebaseNotificationWidgetState createState() =>
      _FirebaseNotificationWidgetState();
}

class _FirebaseNotificationWidgetState
    extends State<FirebaseNotificationWidget> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void initState() {
    super.initState();

    getFirebaseToken();
    configFirebaseMessaging();
  }

  void getFirebaseToken() async {
    String token = await _firebaseMessaging.getToken();
    debugPrint('Token: $token');
  }

  void configFirebaseMessaging() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
        _showNotificationDialog(NotificationMessage.fromJson(message));
      },
    );
  }

  void _showNotificationDialog(NotificationMessage message) {
    showDialog<bool>(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(message.title),
          content: SingleChildScrollView(
            child: Text(message.body),
          ),
          actions: [
            TextButton(
              child: Text('موافق'),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
