import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shining_india_survey/global/values/app_colors.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {_capturePng(); });
  }

  Future<void> _capturePng() async {
    final RenderRepaintBoundary boundary = globalKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    final ui.Image image = await boundary.toImage();
    final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List pngBytes = byteData!.buffer.asUint8List();
    print(pngBytes);
    widget.analysisResponseModel.unit8Image = pngBytes;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(12)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.analysisResponseModel.sId ?? '-',
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              color: AppColors.textBlack
            ),
          ),
          RepaintBoundary(
           key: globalKey,
            child: SfCircularChart(
              series: <CircularSeries>[
                PieSeries(
                  dataSource: widget.analysisResponseModel.answers,
                  xValueMapper: (data, _) => data.answer,
                  yValueMapper: (data, _) => data.count,
                  dataLabelSettings: const DataLabelSettings(isVisible: true, overflowMode: OverflowMode.shift),
                  legendIconType: LegendIconType.seriesType,
                  animationDuration: 0,
                  radius: '100%',
                  explode: true
                )
              ],
              legend: const Legend(
                toggleSeriesVisibility: false,
                isVisible: true,
                itemPadding: 1,
                overflowMode: LegendItemOverflowMode.wrap,
                shouldAlwaysShowScrollbar: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
