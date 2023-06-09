// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
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

  static List<Widget> modelBuilder<M>(
          List<M> models, Widget Function(int index, M model) builder) =>
      models
          .asMap()
          .map<int, Widget>(
              (index, model) => MapEntry(index, builder(index, model)))
          .values
          .toList();

  static sendFeedbackToEmail(String comment, double rate) async {
    final smtpServer = gmail('neriyazudi@gmail.com', 'pnqygicckqqkqstc');

    final message = Message()
      ..from = const Address('SmartStoveSuport@gmail.com', 'Neriya Zudi')
      ..recipients.add('neriyazudi6@gmail.com')
      ..subject = 'Smart Stove User FeedBack'
      ..text = '$comment Food Result Rating: $rate.';

    try {
      final sendReport = await send(message, smtpServer);
      if (sendReport != null) {
        print('Email sent successfully');
      } else {
        print('Failed to send email');
      }
    } catch (e) {
      print('Error sending email: $e');
    }
  }
}
