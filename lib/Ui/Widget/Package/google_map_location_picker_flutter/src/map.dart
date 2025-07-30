import 'package:ataa/Config/config.dart';
import 'package:ataa/UI/Widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as map_toolkit;

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'address_result.dart';

class MapScreen extends StatefulWidget {
  final Widget pinWidget;
  final String apiKey;
  final LatLng initialLocation;
  final String appBarTitle;
  final String addressTitle;
  final String confirmButtonText;
  final String language;
  final List<map_toolkit.LatLng>? polygonPoints;
  final String country;
  final String addressPlaceHolder;
  final Color confirmButtonColor;
  final Color pinColor;
  final Color confirmButtonTextColor;
  const MapScreen(
      {super.key,
      required this.apiKey,
      required this.appBarTitle,
      this.polygonPoints,
      required this.addressTitle,
      required this.confirmButtonText,
      required this.language,
      this.country = "",
      required this.confirmButtonColor,
      required this.pinColor,
      required this.confirmButtonTextColor,
      required this.addressPlaceHolder,
      required this.pinWidget,
      required this.initialLocation});
  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  bool loading = false;
  String _currentAddress = "";
  LatLng? _latLng;
  String _shortName = "";
  CameraPosition? _kGooglePlex;

  CameraPosition cameraPosition(LatLng target) => CameraPosition(
      bearing: 192.8334901395799,
      target: target,
      tilt: 59.440717697143555,
      zoom: 15);

  isUserInArea(latitude, longitude) {
    map_toolkit.LatLng point = map_toolkit.LatLng(latitude, longitude);
    bool geodesic = true;
    bool checkIfUserInArea = map_toolkit.PolygonUtil.containsLocation(
        point, widget.polygonPoints ?? [], geodesic);
    return checkIfUserInArea;
  }

  getAddress(LatLng? location) async {
    try {
      final endpoint =
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=${location?.latitude},${location?.longitude}'
          '&key=${widget.apiKey}&language=${widget.language}';

      final response = jsonDecode((await http.get(
        Uri.parse(endpoint),
      ))
          .body);
      setState(() {
        _currentAddress = response['results'][0]['formatted_address'];
        _shortName =
            response['results'][0]['address_components'][1]['long_name'];
      });
    } catch (_) {}

    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _latLng = widget.initialLocation;
    _kGooglePlex = CameraPosition(
      target: widget.initialLocation,
      zoom: 15,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarX(title: "Select Location"),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex!,
            myLocationButtonEnabled: false,
            rotateGesturesEnabled: true,
            scrollGesturesEnabled: true,
            tiltGesturesEnabled: true,
            zoomGesturesEnabled: true,
            myLocationEnabled: true,
            onCameraMoveStarted: () {
              setState(() {
                loading = true;
              });
            },
            onCameraMove: (p) {
              _latLng = LatLng(p.target.latitude, p.target.longitude);
            },
            onCameraIdle: () async {
              getAddress(_latLng);
            },
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Positioned(
            bottom: 0,
            child: Container(
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width,
              child: ContainerX(
                margin: const EdgeInsets.all(0),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 6),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 4,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.withValues(alpha: 0.6),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      TextX(
                        widget.addressTitle,
                        style: TextStyleX.supTitleLarge,
                      ),
                      const SizedBox(height: 8),
                      TextX(_shortName,
                          style: TextStyleX.titleLarge,
                          fontWeight: FontWeight.bold),
                      const SizedBox(height: 8),
                      TextX(
                        _currentAddress == ""
                            ? widget.addressPlaceHolder
                            : _currentAddress,
                      ),
                      const SizedBox(height: 12),
                      (widget.polygonPoints == null ||
                                  isUserInArea(
                                      _latLng?.latitude, _latLng?.longitude)) &&
                              loading == false
                          ? ButtonX(
                              text: widget.confirmButtonText,
                              onTap: () {
                                AddressResult addressResult = AddressResult(
                                    latlng: _latLng!, address: _currentAddress);
                                Navigator.pop(context, addressResult);
                              },
                            )
                          : const SizedBox(
                              height: 1,
                            ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 10,
            right: 10,
            child: GestureDetector(
              onTap: () async {
                // if (result != null) {
                //   final location =await getPlace(result);
                //   CameraPosition cPosition = CameraPosition(
                //     zoom: 15,
                //     target: LatLng(double.parse(location['lat'].toString()),
                //         double.parse(location['lng'].toString())),
                //   );
                //   final GoogleMapController controller =
                //   await _controller.future;
                //   controller
                //       .animateCamera(
                //       CameraUpdate.newCameraPosition(cPosition))
                //       .then((value) {});
                // }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Card(
                    color: Colors.white,
                    child: IconButton(
                      onPressed: () async {
                        CameraPosition cPosition = CameraPosition(
                          zoom: 15,
                          target: widget.initialLocation,
                        );
                        final GoogleMapController controller =
                            await _controller.future;
                        controller
                            .animateCamera(
                                CameraUpdate.newCameraPosition(cPosition))
                            .then((value) {});
                      },
                      icon: const Icon(
                        Icons.my_location,
                        color: Colors.blue,
                      ),
                      iconSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
              child: Padding(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: widget.pinWidget,
          ))
        ],
      ),
    );
  }

  getPlace(placeId) async {
    String baseURL = 'https://maps.googleapis.com/maps/api/place/details/json';
    String request =
        '$baseURL?place_id=$placeId&key=${widget.apiKey}&language=${widget.language}';
    var response = await http.get(Uri.parse(request));

    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      return res['result']['geometry']['location'];
    } else {
      throw Exception('Failed to load predictions');
    }
  }
}

showGoogleMapLocationPicker(
    {required BuildContext context,
    required Widget pinWidget,
    required String apiKey,
    List<map_toolkit.LatLng>? polygonPoints,
    required String appBarTitle,
    required String searchHint,
    required String addressTitle,
    required LatLng initialLocation,
    required String confirmButtonText,
    required String language,
    required String country,
    required String addressPlaceHolder,
    required Color confirmButtonColor,
    required Color pinColor,
    required Color confirmButtonTextColor}) async {
  final pickedLocation = await Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => MapScreen(
              apiKey: apiKey,
              pinWidget: pinWidget,
              appBarTitle: appBarTitle,
              polygonPoints: polygonPoints,
              addressTitle: addressTitle,
              confirmButtonText: confirmButtonText,
              language: language,
              confirmButtonColor: confirmButtonColor,
              pinColor: pinColor,
              confirmButtonTextColor: confirmButtonTextColor,
              addressPlaceHolder: addressPlaceHolder,
              initialLocation: initialLocation,
            )),
  );
  return pickedLocation;
}
