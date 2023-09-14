import 'dart:typed_data';
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
      appBar: AppBar(
        title: Text('Analysis'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14),
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
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(12)
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Which candidate would you like to support in your area from your Assembly Constituency?',
                            style: TextStyle(
                              fontSize: 16
                            ),
                          ),
                          SizedBox(height: 6,),
                          SfCircularChart(
                            series: <CircularSeries>[
                              PieSeries(
                                dataSource: chartData,
                                xValueMapper: (data, _) => data.x,
                                yValueMapper: (data, _) => data.y,
                                dataLabelSettings: DataLabelSettings(isVisible: true),
                                legendIconType: LegendIconType.rectangle,
                                animationDuration: 0,
                                radius: '80%'
                              )
                            ],
                            legend: Legend(
                              toggleSeriesVisibility: false,
                              isVisible: true,
                              itemPadding: 1,
                              overflowMode: LegendItemOverflowMode.scroll,
                              shouldAlwaysShowScrollbar: true,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
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
    ChartData('Daveryheid', 25),
    ChartData('Stherheve', 38),
    ChartData('Jachererk', 34),
  ];
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color? color;
}
