// ignore_for_file: unused_import, no_leading_underscores_for_local_identifiers

import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:schedular_project/Controller/user_controller.dart';

import '../Screens/Emotional/gratitude_letter.dart';


class AppPrintings {

  /// gratitude letter
  Future<Uint8List> generatePdf(PdfPageFormat format) async {
    final GratitudeLetterController _gratitudeController = Get.find();
    final pdf = pw.Document();
    var font = await PdfGoogleFonts.arimoRegular();

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) => pw.Column(
          mainAxisAlignment: pw.MainAxisAlignment.center,
          children: [
            pw.Spacer(flex: 1),
            pw.Padding(
              padding: const pw.EdgeInsets.only(left: 50, right: 50),
              child: pw.Text(
                _gratitudeController.letterbody.text,
                style: pw.TextStyle(fontSize: 15, font: font),
              ),
            ),
            pw.Spacer(),
            pw.SizedBox(height: 30),
          ],
        ),
      ),
    );

    return pdf.save();
  }

  Future<Uint8List> generateExpertLetter(
    PdfPageFormat format, {
    required String body,
    required String expert,
  }) async {
    final pdf = pw.Document();
    var font = await PdfGoogleFonts.arimoRegular();

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) => pw.Column(
          mainAxisAlignment: pw.MainAxisAlignment.center,
          children: [
            // pw.Spacer(flex: 1),
            // pw.Spacer(),
            /// to
            pw.SizedBox(height: 250),
            pw.Row(
              children: [
                pw.SizedBox(width: 70),
                pw.Text(
                  'Addressed To:',
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    font: font,
                    fontSize: 16,
                    letterSpacing: 2,
                    wordSpacing: 2,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(width: 30),
                pw.Text(
                  expert,
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    font: font,
                    fontSize: 15,
                    letterSpacing: 2,
                    wordSpacing: 2,
                  ),
                ),
              ],
            ),

            /// letter body
            pw.SizedBox(height: 20),
            pw.Row(
              // mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                // pw.Image(),
                pw.Padding(
                  padding: const pw.EdgeInsets.only(left: 150),
                  child: pw.Text(
                    'Letter Body:',
                    style: pw.TextStyle(
                      fontSize: 16.5,
                      font: font,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 25),
            pw.Container(
              margin: const pw.EdgeInsets.only(
                  left: 150, right: 150, top: 10, bottom: 10),
              child: pw.Text(
                body,
                style: pw.TextStyle(fontSize: 17, font: font),
              ),
            ),

            ///
            pw.Spacer(),
         
            pw.Signature(
              name: 'Signature',
              child: pw.Text( 
                'With Respect\n_appController.name.value}',
                style: pw.TextStyle(
                  font: font,
                  fontSize: 15,
                  letterSpacing: 2,
                  wordSpacing: 2,
                  height: 2,
                ),
              ),
            ),
            pw.SizedBox(height: 70),
          ],
        ),
      ),
    );

    return pdf.save();
  }
}
