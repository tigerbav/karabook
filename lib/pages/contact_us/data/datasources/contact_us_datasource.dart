import 'dart:io';

import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:karabookapp/common/app_constants.dart';

abstract class IContactUsDataSource {
  Future<void> sendMessage(String message, List<File> files);
}

class ContactUsDataSource extends IContactUsDataSource {
  @override
  Future<void> sendMessage(String message, List<File> files) async {
    final email = Email(
      body: message,
      subject: C.support,
      recipients: [C.email],
      attachmentPaths: files.map((e) => e.path).toList(),
      isHTML: true,
    );

    await FlutterEmailSender.send(email);
  }
}
