import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:screenshot/screenshot.dart';
import 'package:shining_india_survey/modules/filled_surveys/widgets/date_chips.dart';
import 'package:shining_india_survey/modules/filled_surveys/widgets/gender_chips.dart';
import 'package:shining_india_survey/modules/survey_analysis/ui/widgets/age_chips.dart';
import 'package:shining_india_survey/services/pdf_service.dart';
import 'package:shining_india_survey/utils/app_colors.dart';
import 'package:shining_india_survey/utils/array_res.dart';
import 'package:shining_india_survey/utils/back_button.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AdminSurveyAnalysisScreen extends StatefulWidget {
  const AdminSurveyAnalysisScreen({super.key});

  @override
  State<AdminSurveyAnalysisScreen> createState() => _AdminSurveyAnalysisScreenState();
}

class _AdminSurveyAnalysisScreenState extends State<AdminSurveyAnalysisScreen> {

  ValueNotifier<bool> isVisible = ValueNotifier<bool>(true);
  String _dropDownUserValue = ArrayResources.users[0];

  final PdfService service = PdfService();
  final screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    final outlineBorder = OutlineInputBorder(
        borderSide: const BorderSide(
            color: AppColors.lightBlack
        ),
        borderRadius: BorderRadius.circular(16)
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomBackButton(
                      onTap: (){
                        context.pop();
                      },
                    ),
                    SizedBox(width: 16,),
                    Expanded(
                      child: Text(
                        'Analysis',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 28,
                            color: AppColors.black,
                            fontWeight: FontWeight.w700
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    'Filters',
                    style: TextStyle(
                        color: AppColors.textBlack,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins'
                    ),
                  ),
                  IconButton(
                      onPressed: (){
                        if(isVisible.value == true) {
                          isVisible.value = false;
                        } else {
                          isVisible.value = true;
                        }
                        setState(() {});
                      },
                      icon: Icon(isVisible.value==true ? Icons.keyboard_arrow_down_rounded : Icons.keyboard_arrow_up_rounded)
                  )
                ],
              ),
              ValueListenableBuilder(
                valueListenable: isVisible,
                builder: (context, value, child) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: AppColors.dividerColor,
                        borderRadius: BorderRadius.circular(14)
                    ),
                    child: isVisible.value == true ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8,),
                        Text(
                          'Gender',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: AppColors.black,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        GenderChips(),
                        SizedBox(height: 8,),
                        Text(
                          'User',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: AppColors.black,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        DropdownButtonFormField(
                          isExpanded: true,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: const Icon(Icons.person_2_rounded, color: AppColors.textBlack,),
                            border: outlineBorder,
                            disabledBorder: outlineBorder,
                            errorBorder: outlineBorder,
                            focusedBorder: outlineBorder,
                            focusedErrorBorder: outlineBorder,
                            enabledBorder: outlineBorder,
                          ),
                          value: _dropDownUserValue,
                          items: ArrayResources.users
                              .map<DropdownMenuItem<String>>((String item) {
                            return DropdownMenuItem<String>(
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      color: AppColors.textBlack
                                  ),
                                ),
                                value: item);
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _dropDownUserValue = value ?? '';
                              print(value);
                            });
                          },
                        ),
                        SizedBox(height: 8,),
                        Text(
                          'Age',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: AppColors.black,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        AgeChips(),
                        SizedBox(height: 8,),
                        GestureDetector(
                          onTap: (){
                            isVisible.value = false;
                            setState(() {});
                          },
                          child: Container(
                            height: 40,
                            width: double.maxFinite,
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color:  AppColors.primaryBlue,
                                borderRadius: BorderRadius.circular(12)
                            ),
                            child: Text(
                              'Apply',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                      ],
                    ) : SizedBox.shrink(),
                  );
                },
              ),
              SizedBox(height: 10,),
              Expanded(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
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
