import 'package:mail_sender/services/storage_service.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class MailSender {
  static Future<SendReport?> sendEmail({
    required List recipients,
    required String subject,
    required String address,
    required String html,
    required String text,
  }) async {
    String username = StorageService.read("email"); // Faqat bitta Gmail
    String password = StorageService.read("password"); // Google App Password
    // evwr nlzv qxfi jlyd

    final smtpServer = gmail(username, password);

    String innerHtml = """<!DOCTYPE html><html lang="uz"><head><meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5; /* Oq fon */
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
        p {
            font-size: 16px;
            color: #333;
            line-height: 1.5;
        }
        a {
            color: #007BFF;
            text-decoration: none;
            font-weight: bold;
        }</style></head><body><div class="container">$html</div></body></html>""";

    final message = Message()
      ..from = Address(username, address)
      ..recipients = recipients
      ..text = text
      ..subject = subject
      ..envelopeFrom = username
      ..html = innerHtml;

    try {
      final sendReport = await send(message, smtpServer);
      return sendReport;
    } catch (e) {
      print("Error: $e");
    }
    return null;
  }
}
