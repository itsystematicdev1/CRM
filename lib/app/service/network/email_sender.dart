import 'package:salesman/app/widget/snak_bar.dart';
import 'package:salesman/app/helper/log.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class EmailSenderService {
  Future<void> sendEmailWithGoogleMapsLink(
      String recipientEmail, List<LatLng> routeCoords) async {
    final formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    if (routeCoords.isNotEmpty) {
      // Get the last coordinate for the destination
      LatLng destination = routeCoords.last;
      // Construct the Google Maps link
      String googleMapsLink =
          'https://www.google.com/maps/dir/?api=1&destination=${destination.latitude},${destination.longitude}&waypoints=';
      // Add waypoints
      for (LatLng coord in routeCoords) {
        googleMapsLink += '${coord.latitude},${coord.longitude}|';
      }
      // Remove the trailing "|"
      googleMapsLink = googleMapsLink.substring(0, googleMapsLink.length - 1);
      // Compose the email content
      final String emailBody = 'تقرير يوم  $formattedDate \n$googleMapsLink';
      // Create the email message
      final message = Message()
        ..from = const Address(
            'dev.one.it.systematic@gmail.com', 'Abdelwahab Mahmoud')
        ..recipients.add(recipientEmail)
        ..subject = 'Google Maps Route Link'
        ..text = emailBody;
      // Configure the SMTP server
      final smtpServer =
          gmail('dev.one.it.systematic@gmail.com', 'vtqf lcmg angv vjzl');
      try {
        final sendReport = await send(message, smtpServer);
        logError('Message sent: $sendReport');
        showCustomSnackBar('تم ارسال التقرير بنجاح');
      } on MailerException catch (e) {
        logError('Message not sent.');
        for (var p in e.problems) {
          logError('Problem: ${p.code}: ${p.msg}');
        }
      }
    } else {
      logError('No route coordinates available');
    }
  }
}
