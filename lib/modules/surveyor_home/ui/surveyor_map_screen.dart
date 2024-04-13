import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shining_india_survey/global/values/app_colors.dart';

class SurveyorMapScreen extends StatefulWidget {
  final double latitude;
  final double longitude;
  const SurveyorMapScreen({super.key, required this.longitude, required this.latitude});

  @override
  State<SurveyorMapScreen> createState() => _SurveyorMapScreenState();
}

class _SurveyorMapScreenState extends State<SurveyorMapScreen> {

  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: widget.latitude != 0.00 && widget.longitude != 0
          ? GoogleMap(
          cameraTargetBounds: CameraTargetBounds.unbounded,
          onMapCreated: _onMapCreated,
          zoomControlsEnabled: false,
          initialCameraPosition: CameraPosition(
              target: LatLng(widget.latitude, widget.longitude),
              zoom: 14
          ),
          markers: {
            Marker(markerId: const MarkerId('001'), position: LatLng(widget.latitude, widget.longitude)),
          },
        )
        : const Center(
          child: Text(
            'Location not provided',
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: AppColors.black,
                fontWeight: FontWeight.w600
            ),
          ),
        )
      )
    );
  }
}
