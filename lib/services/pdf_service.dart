import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:open_document/open_document.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import '../modules/survey_analysis/ui/admin_survey_analysis_screen.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfService {

  Future<Uint8List> createPdf(List<ChartData> data, Uint8List image) async {
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

    pdf.addPage(
      pw.MultiPage(
        pageTheme: pw.PageTheme(theme: themeData, pageFormat: PdfPageFormat.a4),
        build: (context) {
          return List.generate(10, (index) => pw.Container(
              child: pw.Image(pw.MemoryImage(image), width: pageTheme.pageFormat.availableWidth)
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
  }
}