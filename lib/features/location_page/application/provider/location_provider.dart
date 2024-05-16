import 'package:flutter/material.dart';
import 'package:healthycart/features/location_page/domain/i_location_facde.dart';

class LocationProvider extends ChangeNotifier {
  LocationProvider(this.iLocationFacade);
  final ILocationFacade iLocationFacade;

  Future<void> getLocationPermisson() async {
    iLocationFacade.getLocationPermisson();
  }

  Future<void> getCurrentLocationAddress() async {
  final result =  iLocationFacade.getCurrentLocationAddress();
  
  }
}
