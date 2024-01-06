import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:open_document/open_document.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:shining_india_survey/modules/survey_analysis/core/models/analysis_response_model.dart';
import '../modules/survey_analysis/ui/admin_survey_analysis_screen.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

class PdfService {

  Future<Uint8List> createPdf(List<AnalysisResponseModel> data, List<Uint8List> image) async {
    final font = await rootBundle.load("assets/fonts/OpenSans-Medium.ttf");
    final ttf = pw.Font.ttf(font);
    final fontBold = await rootBundle.load("assets/fonts/OpenSans-Bold.ttf");
    final ttfBold = pw.Font.ttf(fontBold);
    final fontItalic = await rootBundle.load("assets/fonts/OpenSans-Italic.ttf");
    final ttfItalic = pw.Font.ttf(fontItalic);
    final fontBoldItalic = await rootBundle.load("assets/fonts/OpenSans-BoldItalic.ttf");
    final ttfBoldItalic = pw.Font.ttf(fontBoldItalic);

    final pw.ThemeData themeData = pw.ThemeData.withFont(
      base: ttf,
      bold: ttfBold,
      italic: ttfItalic,
      boldItalic: ttfBoldItalic,
    );

    final pageTheme = pw.PageTheme(
        theme: themeData, pageFormat: PdfPageFormat.a4
    );

    final pdf = pw.Document();

    final imageLogo = (await rootBundle.load('assets/logo.jpeg')).buffer.asUint8List();

    pdf.addPage(
      pw.MultiPage(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        mainAxisAlignment: pw.MainAxisAlignment.start,
        pageTheme: pw.PageTheme(theme: themeData, pageFormat: PdfPageFormat.a4),
        header: (context) {
          return pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Image(pw.MemoryImage(imageLogo), height: 8, width: 32),
              pw.SizedBox(width: 2),
              pw.Text(
                'Shining India Survey',
                style: pw.TextStyle(
                  fontSize: 8
                )
              )
            ]
          );
        },
        footer: (context) {
          return pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.end,
            children: [
              pw.Text(
                'Page ${context.pageNumber} of ${context.pagesCount}',
                style: pw.TextStyle(
                  fontSize: 8
                )
              )
            ]
          );
        },
        build: (context) {
          return List.generate(data.length, (index) => pw.Container(
            margin: pw.EdgeInsets.symmetric(vertical: 10),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Text(
                  data[index].sId ?? '-',
                ),
                pw.Container(
                  child: pw.Image(
                    pw.MemoryImage(image[index]),
                    width: pageTheme.pageFormat.availableWidth,
                    height: pageTheme.pageFormat.height / 4
                  )
                )
              ]
            )
          ));
        },
      )
    );
    return pdf.save();
  }

  Future<void> savePdfFile(String fileName, Uint8List byteList) async {
    final output = await getTemporaryDirectory();
    var filePath = "${output.path}/$fileName.pdf";
    final file = File(filePath);
    await file.writeAsBytes(byteList);
    await OpenDocument.openDocument(filePath: filePath);
    //Share.shareXFiles([XFile('${output.path}/$fileName.pdf')], text: 'Pdf');
  }
}