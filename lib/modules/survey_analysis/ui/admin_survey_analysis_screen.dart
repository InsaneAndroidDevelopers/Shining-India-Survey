import 'dart:math';
import 'dart:typed_data';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:shining_india_survey/services/pdf_service.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AdminSurveyAnalysisScreen extends StatefulWidget {
  const AdminSurveyAnalysisScreen({super.key});

  @override
  State<AdminSurveyAnalysisScreen> createState() => _AdminSurveyAnalysisScreenState();
}

class _AdminSurveyAnalysisScreenState extends State<AdminSurveyAnalysisScreen> {

  final PdfService service = PdfService();
  final screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              //Filters
            ),
            Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.grey,
                    child: SfCircularChart(
                      series: <CircularSeries>[
                        PieSeries(
                          dataSource: chartData,
                          xValueMapper: (data, _) => data.x,
                          yValueMapper: (data, _) => data.y,
                          dataLabelSettings: DataLabelSettings(isVisible: true),
                          legendIconType: LegendIconType.rectangle,
                          animationDuration: 0,
                          radius: '100'
                        )
                      ],
                      legend: Legend(
                        toggleSeriesVisibility: false,
                        isVisible: true,
                        overflowMode: LegendItemOverflowMode.scroll,
                        shouldAlwaysShowScrollbar: true,
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final Uint8List image = await screenshotController.captureFromWidget(
            MediaQuery(
                  data: MediaQueryData(),
                  child: Wrap(
                    children: [
                      Container(
                        width: double.infinity,
                        child: SfCircularChart(
                          series: <CircularSeries>[
                            PieSeries(
                              radius: '70%',
                              dataSource: chartData,
                              xValueMapper: (data, _) => data.x,
                              yValueMapper: (data, _) => data.y,
                              dataLabelSettings: DataLabelSettings(isVisible: true),
                              legendIconType: LegendIconType.rectangle,
                              animationDuration: 0,
                            )
                          ],
                          legend: Legend(
                            position: LegendPosition.auto,
                            toggleSeriesVisibility: false,
                            isVisible: true,
                            overflowMode: LegendItemOverflowMode.none,
                            itemPadding: 1,
                            iconHeight: 6,
                            iconWidth: 6,
                            textStyle: TextStyle(
                              fontSize: 10
                            )
                          ),
                        ),
                      ),
                    ]
                  ),
                )
          );

          final file = await service.createPdf(chartData, image);
          service.savePdfFile('Filename', file);
        },
        child: Icon(Icons.save_alt),
      ),
    );
  }

  final List<ChartData> chartData = [
    ChartData('David', 25),
    ChartData('Steve', 38),
    ChartData('Jack', 34),
    ChartData('Others', 52),
    ChartData('Davi', 25),
    ChartData('Stee', 38),
    ChartData('Davidbsrh', 25),
    ChartData('Sterthrve', 38),
    ChartData('Jahrwtrck', 34),
    ChartData('Otrhrhers', 52),
    ChartData('Dawrhtvi', 25),
    ChartData('Sttrhee', 38),
  ];
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color? color;
}
