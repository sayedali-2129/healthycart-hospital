import 'dart:convert';
import 'dart:developer';

// ignore: depend_on_referenced_packages
import 'package:healthycart/core/custom/toast/toast.dart';
import 'package:healthycart/core/services/open_street_map/open_street_map_model.dart';
import 'package:healthycart/features/location_page/domain/model/location_model.dart';
import 'package:http/http.dart' as http;

class OpenStritMapServices {
  //USER CURRENT LOCATION
  static Future<PlaceMark> fetchCurrentLocaion({
    required String latitude,
    required String longitude,
  }) async {
    final url = Uri.parse(
      'https://nominatim.openstreetmap.org/reverse?format=json&lat=$latitude&lon=$longitude',
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final streatMap = OpentreetMapModel.fromMap(
        json.decode(response.body) as Map<String, dynamic>,
      );
      log(streatMap.toString());
      return PlaceMark(
        country: streatMap.country ?? '',
        district: streatMap.district ?? '',
        geoPoint: LandMark(
          latitude: streatMap.latitude!,
          longitude: streatMap.longitude!,
        ),
        localArea: streatMap.localArea ?? '',
        pincode: streatMap.pincode ?? '',
        state: streatMap.state ?? '',
      );
    } else {
      log('ERROR IN CONVERT TO ADRESS FUNCTION : ${response.statusCode}');
      CustomToast.errorToast(text: 'Please try again');
      throw Exception('Failed to load album');
    }
  }

  //SEARCH LOCATION
  static Future<List<PlaceMark>> searchPlaces({
    required String input,
  }) async {
    final url = Uri.parse(
      'https://nominatim.openstreetmap.org/search.php?q=$input&format=json&addressdetails=1&limit=20&countrycodes=in',
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final placeMarks = <PlaceMark>[];
      final data = json.decode(response.body) as List<dynamic>;
      for (final item in data) {
        final streatMap = OpentreetMapModel.fromMap(
          item as Map<String, dynamic>,
        );
        placeMarks.add(
          PlaceMark(
            country: streatMap.country ?? '',
            district: streatMap.district ?? '',
            geoPoint: LandMark(
              latitude: streatMap.latitude!,
              longitude: streatMap.longitude!,
            ),
            localArea: streatMap.localArea ?? '',
            pincode: streatMap.pincode ?? '',
            state: streatMap.state ?? '',
          ),
        );
      }
      return placeMarks;
    } else {
      log('ERROR IN CONVERT TO ADRESS FUNCTION : ${response.statusCode}');
          CustomToast.errorToast(text:'ERROR IN CONVERT TO ADRESS FUNCTION : ${response.statusCode}');

      throw Exception('Failed to load album');
    }
  }
}
