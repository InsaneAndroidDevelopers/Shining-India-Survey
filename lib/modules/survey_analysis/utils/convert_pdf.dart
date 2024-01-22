import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:shining_india_survey/modules/survey_analysis/core/models/analysis_response_model.dart';
import 'package:shining_india_survey/services/pdf_service.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

Future convertPdf(List<AnalysisResponseModel> analysisList) async {
  List<Uint8List> analysisImages = [];
  final PdfService service = PdfService();
  final screenshotController = ScreenshotController();

  for (var item in analysisList) {
    final Uint8List image = await screenshotController
        .captureFromWidget(
        MediaQuery(
          data: MediaQueryData(),
          child: Wrap(
              children: [
                Container(
                  width: double.infinity,
                  child: SfCircularChart(
                    series: <CircularSeries>[
                      PieSeries(
                        radius: '100%',
                        dataSource: item.answers,
                        xValueMapper: (data, _) => data.answer,
                        yValueMapper: (data, _) => data.count,
                        dataLabelSettings: DataLabelSettings(isVisible: true),
                        legendIconType: LegendIconType.rectangle,
                        animationDuration: 0,
                      )
                    ],
                    legend: const Legend(
                        position: LegendPosition.auto,
                        toggleSeriesVisibility: false,
                        isVisible: true,
                        overflowMode: LegendItemOverflowMode.none,
                        itemPadding: 1,
                        iconHeight: 6,
                        iconWidth: 6,
                        textStyle: TextStyle(fontSize: 10)
                    ),
                  ),
                ),
              ]
          ),
        )
    );
    analysisImages.add(image);
  }
  final file = await service.createPdf(analysisList, analysisImages);
  service.savePdfFile('Filename', file);
}