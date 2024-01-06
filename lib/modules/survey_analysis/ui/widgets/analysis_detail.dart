import 'package:flutter/material.dart';
import 'package:shining_india_survey/global/values/app_colors.dart';
import 'package:shining_india_survey/modules/survey_analysis/core/models/analysis_response_model.dart';
import 'package:shining_india_survey/modules/survey_analysis/core/models/chart_data_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AnalysisDetail extends StatefulWidget {
  final String question;
  final List<Answers> chartData;

  const AnalysisDetail({
    super.key,
    required this.question,
    required this.chartData
  });

  @override
  State<AnalysisDetail> createState() => _AnalysisDetailState();
}

class _AnalysisDetailState extends State<AnalysisDetail> {

  @override
  void initState() {
    super.initState();

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
            widget.question,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              color: AppColors.textBlack
            ),
          ),
          SfCircularChart(
            series: <CircularSeries>[
              PieSeries(
                dataSource: widget.chartData,
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
        ],
      ),
    );
  }
}
