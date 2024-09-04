import 'package:geocoding/geocoding.dart' as geo;
import 'package:location/location.dart';

class LocationService {
  // Step 1: Create a private static instance
  static final LocationService _instance = LocationService._internal();

  // Step 2: Create a factory constructor that returns the instance
  factory LocationService() {
    return _instance;
  }

  // Step 3: Create a private named constructor
  LocationService._internal() : _location = Location();

  final Location _location;

  Future<void> init() async {
    await _ensureServiceEnabled();
    await _ensurePermissionGranted();
  }

  Future<LocationData> getLocationAsIs() async {
    return await _location.getLocation();
  }

  Future<Map<String, dynamic>> getLocationLatLog() async {
    final loc = await getLocationAsIs();
    return {
      "Latitude": loc.latitude ?? 0.0,
      "Longitude": loc.longitude ?? 0.0,
    };
  }

  Future<List<geo.Location>> locationAddress(String address) async {
    return await geo.locationFromAddress(address);
  }

  Future<List<geo.Placemark>> curlocationPlaceAsName() async {
    final loc = await getLocationAsIs();
    double latitude = loc.latitude ?? 0.0;
    double longitude = loc.longitude ?? 0.0;
    return await geo.placemarkFromCoordinates(latitude, longitude);
  }

  // Future<void> curLocPlaceAsName() async {
  //   final loc = await getLocationAsIs();
  //   double latitude = loc.latitude ?? 0.0;
  //   double longitude = loc.longitude ?? 0.0;
  //   final locName = await geo.placemarkFromCoordinates(latitude, longitude);
  //   locName
  // }

  Future<List<geo.Placemark>> locationPlaceAsName(
      double latitude, double longitude) async {
    return await geo.placemarkFromCoordinates(latitude, longitude);
  }

  Future<void> _ensureServiceEnabled() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        throw Exception("Failed to enable location service");
      }
    }
  }

  Future<void> _ensurePermissionGranted() async {
    PermissionStatus permissionStatus = await _location.hasPermission();
    if (permissionStatus != PermissionStatus.granted) {
      permissionStatus = await _location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        throw Exception("Location permission not granted");
      }
    }
  }
}
