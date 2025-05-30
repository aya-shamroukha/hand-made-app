// ignore_for_file: avoid_print
import 'dart:async';
import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hand_made_app/core/config/local_storage/shared_preferences.dart';
import 'package:hand_made_app/core/resources/app_string.dart';
import 'package:hand_made_app/feature/share/custom_button.dart';
import 'package:hand_made_app/feature/share/positioned_for_icon.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/resources/app_color.dart';
import 'location_details_screen.dart';

getCurrentLocationApp() async {
  bool serviceEnabled;
  LocationPermission permission;
  //!للتاكد انو خدمة الموقع عل الموبايل شغالة
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (serviceEnabled == false) {
    print('trun onnn');
  }
  //!لحتى اعطي صلاحية للتطبيق
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }
  if (permission == LocationPermission.whileInUse) {
    return await Geolocator.getCurrentPosition();
  }
}

class MarkerDate {
  final LatLng position;

  MarkerDate({
    required this.position,
  });
}

class LocationScreen extends StatefulWidget {
  LocationScreen({super.key, required this.fromCart});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
  final bool fromCart;
}

StreamSubscription<Position>? positionStream;

class _LocationScreenState extends State<LocationScreen> {
  final MapController mapController = MapController();

  List<Marker> marker = [];
  // ignore: prefer_final_fields
  List<MarkerDate> _markerdate = [];
  LatLng? selectPosition;
  double? savedZoom;
  LatLng? savedCenter;
  LatLng? myLocation;
  bool isDragging = false;
  LatLng? draggedPosition;
  TextEditingController search = TextEditingController();
  List<dynamic> searchResults = [];
  bool isSearching = false;
  //!save
  Future<void> saveMapState() async {
    final prefs = getIt.get<SharedPreferences>();
    await prefs.setDouble('map_zoom', mapController.camera.zoom);
    await prefs.setDouble(
        'map_center_lat', mapController.camera.center.latitude);
    await prefs.setDouble(
        'map_center_lng', mapController.camera.center.longitude);
  }

  //! Restore map state from SharedPreferences
  Future<void> restoreMapState() async {
    final prefs = getIt.get<SharedPreferences>();
    savedZoom = prefs.getDouble('map_zoom');
    final lat = prefs.getDouble('map_center_lat');
    final lng = prefs.getDouble('map_center_lng');

    if (savedZoom != null && lat != null && lng != null) {
      savedCenter = LatLng(lat, lng);
      mapController.move(savedCenter!, savedZoom!);
    }
  }
//! Function to convert latitude and longitude to an address
//
  // Future<void> getAddressFromLatLng(double latitude, double longitude) async {
  //   Position position = await getCurrentLocationApp();

  //   try {
  //     List<Placemark> placemarks =
  //         await placemarkFromCoordinates(position.latitude, position.longitude);
  //     if (placemarks.isNotEmpty) {
  //       final placemark = placemarks.first;
  //       final address =
  //           '${placemark.country}, ${placemark.locality}, ${placemark.subLocality}';
  //       print('Current location: $address');
  //       getIt.get<SharedPreferences>().setString('address', address);
  //     }
  //   } catch (e) {
  //     print('Error occurred while getting address: $e');
  //   }
  // }

//!for my location
  void showCurrentLocation() async {
    Position position = await getCurrentLocationApp();
    try {
      LatLng currrntLatLng = LatLng(position.latitude, position.longitude);
      mapController.move(currrntLatLng, 18.0);
      setState(() {
        myLocation = currrntLatLng;
      });
      // List<Placemark> placemarks =
      //     await placemarkFromCoordinates(position.latitude, position.longitude);

      // if (placemarks.isNotEmpty) {
      //   final placemark = placemarks.first;
      //   final address =
      //       '${placemark.country}, ${placemark.locality}, ${placemark.subLocality}';
      //   print('Current location: $address');
      //   getIt.get<SharedPreferences>().setString('address', address);
      // }
      // print(placemarks);
    } catch (e) {
      print('Geocoding failed: $e');
      print('Current location: ${position.latitude}, ${position.longitude}');
      print(e);
    }
  }

  //!add marker on selected location
  void addMarker(
    LatLng position,
  ) {
    setState(() {
      final markerdate = MarkerDate(
        position: position,
      );
      _markerdate.add(markerdate);
      marker.add(Marker(
          point: position,
          child: GestureDetector(
            child: Icon(
              Icons.location_on,
              color: AppColor.primary,
              size: 50,
            ),
            onTap: () {},
          ),
          width: 80,
          height: 80));
    });
  }

//!Search feature
  Future<void> searchPlaces(String query) async {
    if (query.isEmpty) {
      setState(() {
        searchResults = [];
      });
      return;
    }
    final url =
        'https://nominatim.openstreetmap.org/search?q=$query&format=json&limit=5';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data.isNotEmpty) {
        setState(() {
          searchResults = data;
        });
      } else {
        setState(() {
          searchResults = [];
        });
      }
    } else {
      print('Failed to load data...........');
    }
  }

//!movie to specific location
  void moveToLocation(double lat, double lon) async {
    LatLng location = LatLng(lat, lon);
    mapController.move(location, 18.0);
    // List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);

    // if (placemarks.isNotEmpty) {
    //   final placemark = placemarks.first;
    //   final address =
    //       '${placemark.country}, ${placemark.locality}, ${placemark.subLocality} ,${placemark.name}';
    //   print('Current location: $address');
    //   getIt.get<SharedPreferences>().setString('address', address);
    // }
    // print(placemarks);

    setState(() {
      selectPosition = location;
      searchResults = [];
      isSearching = false;
      MarkerLayer(markers: [
        Marker(
            point: LatLng(lat, lon),
            width: 80,
            height: 80,
            child: Icon(
              Icons.location_on,
              color: AppColor.primary,
            )),
      ]);
      Future.delayed(const Duration(seconds: 3), () async {
        Navigator.of(context).pushNamed('locationdetails');
      });
      //  search.clear();
    });
  }

  @override
  void initState() {
    super.initState();

    search.addListener(
      () {
        searchPlaces(search.text);
      },
    );
    showCurrentLocation();
    getCurrentLocationApp();
    //restoreMapState();
  }

  @override
  void dispose() {
    if (positionStream != null) {
      positionStream!.cancel();
    }
    search.dispose();
    saveMapState();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          body: Stack(children: [
        FlutterMap(
          mapController: mapController,
          options: MapOptions(
            initialCenter: const LatLng(32.883942, -6.930680),
            initialZoom: 13.0,
            onTap: (tapPosition, latlng) {
              selectPosition = latlng;
              draggedPosition = selectPosition;
            },
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
            ),
            MarkerLayer(markers: marker),
            if (isDragging && draggedPosition != null)
              MarkerLayer(markers: [
                Marker(
                    point: draggedPosition!,
                    width: 80,
                    height: 80,
                    child: Icon(
                      Icons.location_on,
                      color: AppColor.primary,
                    )),
              ]),
            if (myLocation != null)
              MarkerLayer(
                markers: [
                  Marker(
                      point: myLocation!,
                      width: 80,
                      height: 80,
                      child: Icon(
                        Icons.location_on,
                        color: AppColor.primary,
                        size: 45,
                      ))
                ],
              ),
          ],
        ),
        Positioned(
          bottom: screenHeight * 0.09.h,
          right: 20,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: showCurrentLocation,
              child: Container(
                  width: 34.w,
                  height: 34.h,
                  decoration: BoxDecoration(
                      color: AppColor.brownText.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(8)),
                  child: Icon(
                    Icons.location_searching_rounded,
                    color: AppColor.primary,
                  )),
            ),
          ),
        ),
        PositionedForIcon(
          left: 0,
          top: screenHeight * 0.027,
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('bottom');
          },
        ),
        //!for anthor loation
        Positioned(
          top: 25,
          right: 10,
          child: SizedBox(
            height: screenHeight * 0.04.h,
            width: screenWidth * 0.7.w,
            child: Center(
              child: TextFormField(
                cursorColor: AppColor.primary,
                onTap: () {
                  setState(() {
                    isSearching = true;
                  });
                },
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none),
                    hintText: AppStrings.chooseLocation.tr(),
                    hintStyle: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(color: AppColor.blodbrownText, fontSize: 20),
                    fillColor: AppColor.background,
                    filled: true,
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColor.primary,
                    ),
                    suffixIcon: isSearching
                        ? IconButton(
                            onPressed: () {
                              search.clear();
                              (setState(() {
                                isSearching = false;
                                searchResults = [];
                              }));
                            },
                            icon: const Icon(Icons.clear))
                        : null),
                controller: search,
              ),
            ),
          ),
        ),
        //!formyloaction
        Positioned(
            bottom: screenHeight * 0.019.h,
            right: screenWidth * 0.14.w,
            child: Center(
              child: CustomButton(
                  width: screenWidth * 0.6,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            LocationDetailsScreen(fromCart: widget.fromCart),
                      ),
                    );
                  },
                  text: AppStrings.LocationConfirm.tr()),
            )),
        //!for result of search
        if (isSearching && searchResults.isNotEmpty)
          Positioned(
            bottom: 220,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColor.brownText.withOpacity(0.7),
              ),
              //height: 60.h,
              width: 350,
              child: Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      final place = searchResults[index];
                      return SizedBox(
                        height: 50.h,
                        width: 900,
                        child: ListTile(
                          title: Text(
                            place['display_name'].toString(),
                            overflow: TextOverflow.ellipsis,
                          ),
                          onTap: () {
                            final lat = double.parse(place['lat'].toString());
                            final lon = double.parse(place['lon'].toString());
                            print(place['lat'].toString());
                            print(place['lon'].toString());
                            // getAddressFromLatLng(lat, lon);
                            moveToLocation(lat, lon);
                            addMarker(
                              LatLng(lat, lon),
                            );
                          },
                        ),
                      );
                    }),
              ),
            ),
          ),
      ])),
    );
  }
}
