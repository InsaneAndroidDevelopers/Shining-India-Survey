import 'dart:io';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
// import 'package:open_document/open_document.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:shining_india_survey/helpers/hive_db_helper.dart';
import 'package:shining_india_survey/modules/survey_analysis/core/models/analysis_response_model.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:shining_india_survey/modules/survey_analysis/ui/widgets/analysis_detail.dart';

class PdfService {

  Future<Uint8List> createPdf(
      List<AnalysisResponseModel> data,
  {int? maxAge,
      int? minAge,
      String? toDate,
      String? fromDate,
      String? gender,
      String? teamID,
      String? state}
    ) async {
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
              pw.Image(pw.MemoryImage(imageLogo), height: 14, width: 40),
              pw.SizedBox(width: 2),
              pw.Text(
                'Shining India Survey',
                style: const pw.TextStyle(
                  fontSize: 10
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
                style: const pw.TextStyle(
                  fontSize: 10
                )
              )
            ]
          );
        },
        build: (context) {
          return [
            pw.Padding(
              padding: const pw.EdgeInsets.symmetric(vertical: 18),
              child: pw.Text(
                'Survey Analysis Report',
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold
                )
              ),
            ),
            pw.Align(
              alignment: pw.Alignment.centerLeft,
              child: pw.Wrap(
                direction: pw.Axis.horizontal,
                  crossAxisAlignment: pw.WrapCrossAlignment.center,
                  runAlignment: pw.WrapAlignment.start,
                  runSpacing: 10,
                  spacing: 10,
                  children: [
                    if((teamID != null && teamID != '')
                        || (minAge != null && minAge != 0)
                        || (maxAge != null && maxAge != 0)
                        || (gender != null && gender != '')
                        || (state != null && state != '')
                        || (fromDate != null && fromDate != '')
                    )
                    pw.Text(
                        'Filters:',
                        style: pw.TextStyle(
                            fontSize: 12,
                            fontWeight: pw.FontWeight.bold
                        )
                    ),
                    if (teamID != null && teamID != '')
                      pw.Row(
                          mainAxisSize: pw.MainAxisSize.min,
                          children:[
                            pw.Text(
                              'Team: ',
                              style: const pw.TextStyle(
                                  fontSize: 10
                              ),),
                            pw.Text(
                              teamID,
                              style: const pw.TextStyle(
                                  fontSize: 10
                              ),  )
                          ]
                      ),
                    if (minAge != null && minAge != 0)
                      pw.Row(
                          mainAxisSize: pw.MainAxisSize.min,
                          children:[
                            pw.Text(
                              'Min. Age: ',
                              style: const pw.TextStyle(
                                  fontSize: 10
                              ),),
                            pw.Text(
                              '$minAge',
                              style: const pw.TextStyle(
                                  fontSize: 10
                              ),  )
                          ]
                      ),
                    if (maxAge != null && maxAge != 0)
                      pw.Row(
                          mainAxisSize: pw.MainAxisSize.min,
                          children:[
                            pw.Text(
                              'Max. Age: ',
                              style: const pw.TextStyle(
                                  fontSize: 10
                              ),),
                            pw.Text(
                              '$maxAge',
                              style: const pw.TextStyle(
                                  fontSize: 10
                              ),  )
                          ]
                      ),
                    if (gender != null && gender != '')
                      pw.Row(
                          mainAxisSize: pw.MainAxisSize.min,
                          children:[
                            pw.Text(
                              'Gender: ',
                              style: const pw.TextStyle(
                                  fontSize: 10
                              ),),
                            pw.Text(
                              gender,
                              style: const pw.TextStyle(
                                  fontSize: 10
                              ),  )
                          ]
                      ),
                    if (state != null && state != '')
                      pw.Row(
                          mainAxisSize: pw.MainAxisSize.min,
                          children:[
                            pw.Text(
                              'State: ',
                              style: const pw.TextStyle(
                                  fontSize: 10
                              ),),
                            pw.Text(
                              state,
                              style: const pw.TextStyle(
                                  fontSize: 10
                              ),  )
                          ]
                      ),
                    if (fromDate != null && fromDate != '')
                      pw.Row(
                          mainAxisSize: pw.MainAxisSize.min,
                          children:[
                            pw.Text(
                              'From date: ',
                              style: const pw.TextStyle(
                                  fontSize: 10
                              ),),
                            pw.Text(
                              DateFormat("dd-MMM-yyyy").format(DateTime.parse(fromDate)),
                              style: const pw.TextStyle(
                                  fontSize: 10
                              ),  )
                          ]
                      ),
                  ]
              ),
            ),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: List.generate(data.length, (index) => pw.Padding(
                  padding: const pw.EdgeInsets.only(top: 20),
                  child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'Q${index+1}. ${HiveDbHelper.getBox().get(data[index].sId)}' ?? '-',
                            textAlign: pw.TextAlign.left,
                        ),
                        pw.SizedBox(height: 20),
                        pw.Container(
                          alignment: pw.Alignment.centerLeft,
                            child: pw.Image(
                                pw.MemoryImage(data[index].unit8Image ?? Uint8List(64)),
                                width: pageTheme.pageFormat.availableWidth,
                                height: pageTheme.pageFormat.height / 4,
                              fit: pw.BoxFit.scaleDown
                            )
                        ),
                        pw.SizedBox(height: 10),
                        pw.Wrap(
                          runSpacing: 6,
                          spacing: 10,
                          children: List.generate(
                            data[index].answers?.length ?? 0,
                            (ansIndex) => pw.Row(
                              mainAxisSize: pw.MainAxisSize.min,
                              children: [
                                pw.Container(
                                  height: 8,
                                  width: 8,
                                  decoration: pw.BoxDecoration(
                                    shape: pw.BoxShape.circle,
                                    color: PdfColor.fromInt(int.parse('0xFF${randomColorHexCodes[ansIndex%30]}'))
                                  )
                                ),
                                pw.SizedBox(width: 4),
                                pw.Text(
                                  data[index].answers?[ansIndex].answer.toString() ?? '',
                                  style: const pw.TextStyle(
                                    fontSize: 10
                                  )
                                )
                              ]
                            )
                          )
                        )
                      ]
                  )
              ))
            )
          ];
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
    //await OpenDocument.openDocument(filePath: filePath);
    //Share.shareXFiles([XFile('${output.path}/$fileName.pdf')], text: 'Pdf');
  }
}