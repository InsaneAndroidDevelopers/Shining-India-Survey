import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shining_india_survey/global/values/app_colors.dart';
import 'package:shining_india_survey/helpers/hive_db_helper.dart';
import 'package:shining_india_survey/modules/survey_analysis/core/models/analysis_response_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AnalysisDetail extends StatefulWidget {
  final AnalysisResponseModel analysisResponseModel;

  const AnalysisDetail({
    super.key,
    required this.analysisResponseModel
  });

  @override
  State<AnalysisDetail> createState() => _AnalysisDetailState();
}

class _AnalysisDetailState extends State<AnalysisDetail> {

  final GlobalKey globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {await Future.delayed(Duration(milliseconds: 200,), () async => _capturePng()); });
  }

  Future<void> _capturePng() async {
    final RenderRepaintBoundary boundary = globalKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    final ui.Image image = await boundary.toImage();
    final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List pngBytes = byteData!.buffer.asUint8List();
    widget.analysisResponseModel.unit8Image = pngBytes;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(12)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            HiveDbHelper.getBox().get(widget.analysisResponseModel.sId) ?? '-',
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              color: AppColors.textBlack
            ),
          ),
          const SizedBox(height: 10,),
          RepaintBoundary(
           key: globalKey,
            child: SfCircularChart(
              palette: randomColorHexCodes.map((e) => Color(int.parse('0xFF$e'))).toList(),
              series: <CircularSeries>[
                PieSeries(
                  dataSource: widget.analysisResponseModel.answers,
                  xValueMapper: (data, _) => data.answer,
                  yValueMapper: (data, _) => data.count,
                  dataLabelSettings: const DataLabelSettings(
                    isVisible: true,
                    overflowMode: OverflowMode.shift ,
                    labelPosition: ChartDataLabelPosition.inside
                  ),
                  animationDuration: 0,
                  radius: '90%',
                  explode: true
                )
              ],
            ),),
              const SizedBox(height: 10,),
              Align(
                alignment: Alignment.centerLeft,
                child: Wrap(
                  direction: Axis.horizontal,
                  spacing: 10,
                  runSpacing: 4,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  alignment: WrapAlignment.start,
                  runAlignment: WrapAlignment.start,
                  children: List.generate(
                    widget.analysisResponseModel.answers?.length ?? 0,
                    (index) => Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.pie_chart, size: 12, color: Color(int.parse('0xFF${randomColorHexCodes[index%30]}')),),
                        const SizedBox(width: 2,),
                        Text(
                          widget.analysisResponseModel.answers?[index].answer?.toString() ?? '',
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                          ),
                        )
                      ],
                    )
                  )
                ),
              )
            ],
          )
    );
  }
}


// class PieChartWidget extends StatefulWidget {
//   final AnalysisResponseModel analysisResponseModel;
//   const PieChartWidget({super.key, required this.analysisResponseModel});
//
//   @override
//   State<PieChartWidget> createState() => _PieChartState();
// }
//
// class _PieChartState extends State<PieChartWidget> {
//
//   int total = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     widget.analysisResponseModel.answers?.forEach((element) {
//       total += element.count ?? 0;
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 1.3,
//       child: PieChart(
//         PieChartData(
//           borderData: FlBorderData(
//             show: false,
//           ),
//           sectionsSpace: 0,
//           centerSpaceRadius: 40,
//           sections: List.generate(
//             widget.analysisResponseModel.answers?.length ?? 0,
//             (index) {
//               final str = (((widget.analysisResponseModel.answers?[index].count?.toDouble()) ?? 0.0) / (total==0 ? 1 : total)) * 100;
//               return PieChartSectionData(
//                 color: Color(int.parse('0xFF${randomColorHexCodes[index%30]}')),
//                 value: str,
//                 title: '${str.toStringAsPrecision(2)}%',
//                 radius: 100,
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

List<String> randomColorHexCodes = [
  'F44336', 'E91E63', '9C27B0', '673AB7', '3F51B5',
  '2196F3', '03A9F4', '00BCD4', '009688', '4CAF50',
  '8BC34A', 'CDDC39', 'FFEB3B', 'FFC107', 'FF9800',
  'FF5722', '795548', '9E9E9E', '607D8B', '333333',
  '607D8B', '455A64', '607D8B', '00ACC1', '607D8B',
  '607D8B', '607D8B', '607D8B', '607D8B', '607D8B'
];