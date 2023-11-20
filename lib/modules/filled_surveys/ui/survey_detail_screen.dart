import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shining_india_survey/modules/filled_surveys/core/models/survey_response_model.dart';
import 'package:shining_india_survey/modules/filled_surveys/ui/widgets/survey_detail_holder.dart';
import 'package:shining_india_survey/routes/routes.dart';
import 'package:shining_india_survey/utils/app_colors.dart';
import 'package:shining_india_survey/utils/back_button.dart';
import 'package:shining_india_survey/utils/custom_button.dart';

class SurveyDetailScreen extends StatefulWidget {
  final SurveyResponseModel surveyResponseModel;
  const SurveyDetailScreen({super.key, required this.surveyResponseModel});

  @override
  State<SurveyDetailScreen> createState() => _SurveyDetailScreenState();
}

class _SurveyDetailScreenState extends State<SurveyDetailScreen> {

  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
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
                      onTap: () {
                        context.pop();
                      },
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Text(
                        widget.surveyResponseModel.personName ?? '',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 28,
                            color: AppColors.black,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.primaryBlueBackground,
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child: Column(
                          children: [
                            SurveyDetailHolder(
                              name: 'Name',
                              val: widget.surveyResponseModel.personName ?? '-',
                            ),
                            Divider(color: AppColors.dividerColor,),
                            SurveyDetailHolder(
                              name: 'Gender',
                              val: widget.surveyResponseModel.gender ?? '-',
                            ),
                            Divider(color: AppColors.dividerColor,),
                            SurveyDetailHolder(
                              name: 'Age',
                              val: widget.surveyResponseModel.age.toString() ?? '-',
                            ),
                            Divider(color: AppColors.dividerColor,),
                            SurveyDetailHolder(
                              name: 'Assembly Name',
                              val: widget.surveyResponseModel.assemblyName ?? '-',
                            ),
                            Divider(color: AppColors.dividerColor,),
                            SurveyDetailHolder(
                              name: 'Location',
                              val: '${widget.surveyResponseModel.ward}, ${widget.surveyResponseModel.district}, ${widget.surveyResponseModel.state}, ${widget.surveyResponseModel.pincode}',
                            ),
                            Divider(color: AppColors.dividerColor,),
                            SurveyDetailHolder(
                              name: 'Date & Time',
                              val: convertDateTime(widget.surveyResponseModel.surveyDateTime ?? ''),
                            ),
                            widget.surveyResponseModel.mobileNum != null
                                ? Column(
                              children: [
                                Divider(color: AppColors.dividerColor,),
                                SurveyDetailHolder(
                                  name: 'Mobile',
                                  val: widget.surveyResponseModel.mobileNum ?? '-',
                                ),
                              ],
                            ) : SizedBox.shrink(),
                            widget.surveyResponseModel.address != null
                                ? Column(
                              children: [
                                Divider(color: AppColors.dividerColor,),
                                SurveyDetailHolder(
                                  name: 'Address',
                                  val: widget.surveyResponseModel.address ?? '-',
                                ),
                              ],
                            ) : SizedBox.shrink(),
                            widget.surveyResponseModel.caste != null
                                ? Column(
                              children: [
                                Divider(color: AppColors.dividerColor,),
                                SurveyDetailHolder(
                                  name: 'Caste',
                                  val: widget.surveyResponseModel.caste ?? '-',
                                ),
                              ],
                            ) : SizedBox.shrink(),
                            widget.surveyResponseModel.religion != null
                              ? Column(
                              children: [
                                Divider(color: AppColors.dividerColor,),
                                SurveyDetailHolder(
                                  name: 'Religion',
                                  val: widget.surveyResponseModel.religion ?? '-',
                                ),
                              ],
                            ) : SizedBox.shrink(),
                            Divider(color: AppColors.dividerColor,),
                            SizedBox(height: 10,),
                            Container(
                              clipBehavior: Clip.hardEdge,
                              height: 300,
                              decoration: BoxDecoration(
                                color: widget.surveyResponseModel.latitude != null ? null : AppColors.primary,
                                borderRadius: BorderRadius.circular(12)
                              ),
                              child: widget.surveyResponseModel.latitude != null
                                ? GoogleMap(
                                  cameraTargetBounds: CameraTargetBounds.unbounded,
                                  onMapCreated: _onMapCreated,
                                  zoomControlsEnabled: false,
                                  initialCameraPosition: CameraPosition(
                                      target: LatLng(
                                        double.parse(widget.surveyResponseModel.latitude ?? '0.00'),
                                        double.parse(widget.surveyResponseModel.longitude ?? '0.00')
                                      ),
                                      zoom: 14
                                  ),
                                  markers: {
                                    Marker(markerId: MarkerId('001'), position: LatLng(
                                        double.parse(widget.surveyResponseModel.latitude ?? '0.00'),
                                        double.parse(widget.surveyResponseModel.longitude ?? '0.00')
                                    )),
                                  },
                              )
                              : Center(
                                child: Text(
                                  'Location not provided',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      CustomButton(
                        onTap: (){
                          context.push(
                              RouteNames.adminFilledSurveyResponses,
                              extra: widget.surveyResponseModel.response
                          );
                        },
                        text: 'View responses'
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String convertDateTime(String isoString) {
    if(isoString.isEmpty) {
      return '-';
    }
    DateFormat customDateFormat = DateFormat('MMM dd, yyyy, HH:mm a');
    DateTime isoDate = DateTime.parse(isoString);
    String customFormattedDate = customDateFormat.format(isoDate);
    return customFormattedDate;
  }
}
