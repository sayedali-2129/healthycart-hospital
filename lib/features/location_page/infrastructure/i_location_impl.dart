import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:geocoding/geocoding.dart';
import 'package:healthycart/core/failures/main_failure.dart';
import 'package:healthycart/core/services/location_service.dart';
import 'package:healthycart/features/location_page/domain/i_location_facde.dart';
import 'package:healthycart/features/location_page/domain/model/location_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ILocationFacade)
class ILocationImpl implements ILocationFacade {
  ILocationImpl(this._locationService, this.firebaseFirestore);

  final LocationService _locationService;
  final FirebaseFirestore firebaseFirestore;
  @override
  Future<Either<MainFailure, Placemark>> getCurrentLocationAddress() async {
    final result = await _locationService.getCurrentLocationAddress();
    return result;
  }

  @override
  Future<void> getLocationPermisson() async {
    await _locationService.getPermission();
  }

  @override
  Future<Either<MainFailure, Unit>> setLocationByHospital(PlaceMark placeMark) async{
    try {
      // add Local area
      final district = await firebaseFirestore
          .collection('sellLocation')
          .doc(placeMark.country)
          .collection(placeMark.state)
          .doc(placeMark.state)
          .collection(placeMark.district)
          .doc(placeMark.district)
          .get();
      if (district.exists) {
        // Get LocalArea Map List // [{Nilambur: Instance of 'GeoPoint'}]
        final localAreaList =(district.data()?['localArea'] as List<dynamic>?) ?? [];
        // map convert localArea key then convert 
        final localAreaKeysList = <String>[];
        for (final localArea in localAreaList) {
          final localAreaMap = localArea as Map<String, dynamic>;
          // ignore: cascade_invocations
          localAreaMap.forEach((key, value) {
            localAreaKeysList.add(key);
          });
        }

       
        if (!localAreaKeysList.contains(placeMark.localArea)) {
          await firebaseFirestore
              .collection('sellLocation')
              .doc(placeMark.country)
              .collection(placeMark.state)
              .doc(placeMark.state)
              .collection(placeMark.district)
              .doc(placeMark.district)
              .update({
            'localArea': FieldValue.arrayUnion([
              {
                placeMark.localArea: GeoPoint(
                  placeMark.geoPoint.latitude,
                  placeMark.geoPoint.longitude,
                ),
              },
            ]),
          });
        }
        return right(unit); // stop and set location
      }

      // add district
      final state = await firebaseFirestore
          .collection('sellLocation')
          .doc(placeMark.country)
          .collection(placeMark.state)
          .doc(placeMark.state)
          .get();

      if (state.exists) {
       

          // Get LocalArea Map List // [{Malappuram: Instance of 'GeoPoint'}]
        final districtList = (state.data()?['district'] as List<dynamic>?) ?? [];
        // map convert district key then convert 
        final districtKeysList = <String>[];
        for (final district in districtList) {
          final districtMap = district as Map<String, dynamic>;
          // ignore: cascade_invocations
          districtMap.forEach((key, value) {
            districtKeysList.add(key);
          });
        }

        log(districtKeysList.toString());
           

        final batch = firebaseFirestore.batch();
        if (!districtKeysList.contains(placeMark.district)) {
          batch.update(
            firebaseFirestore
                .collection('sellLocation')
                .doc(placeMark.country)
                .collection(placeMark.state)
                .doc(placeMark.state),
            {
              'district': FieldValue.arrayUnion([
                {
                  placeMark.district: GeoPoint(
                    placeMark.geoPoint.latitude,
                    placeMark.geoPoint.longitude,
                  ),
                }
              ]),
            },
          );
        }
        batch.set(
          firebaseFirestore
              .collection('sellLocation')
              .doc(placeMark.country)
              .collection(placeMark.state)
              .doc(placeMark.state)
              .collection(placeMark.district)
              .doc(placeMark.district),
          {
            'localArea': FieldValue.arrayUnion([
              {
                placeMark.localArea: GeoPoint(
                  placeMark.geoPoint.latitude,
                  placeMark.geoPoint.longitude,
                ),
              }
            ]),
          },
        );

        await batch.commit();
        return right(unit); // stop and set location
      }

      // add state
      final country = await firebaseFirestore
          .collection('sellLocation')
          .doc(placeMark.country)
          .get();
      if (country.exists) {
        // Get LocalArea Map List // [{Kerala: Instance of 'GeoPoint'}]
        final stateList = (country.data()?['state'] as List<dynamic>?) ?? [];


            
       
        // map convert state key then convert 
        final stateKeysList = <String>[];
        for (final state in stateList) {
          final stateMap = state as Map<String, dynamic>;
          // ignore: cascade_invocations
          stateMap.forEach((key, value) {
            stateKeysList.add(key);
          });
        }



        final batch = firebaseFirestore.batch();
        if (!stateKeysList.contains(placeMark.state)) {
          batch.update(
            // update
            firebaseFirestore.collection('sellLocation').doc(placeMark.country),
            {
              'state': FieldValue.arrayUnion([
                {
                  placeMark.state: GeoPoint(
                    placeMark.geoPoint.latitude,
                    placeMark.geoPoint.longitude,
                  ),
                }
              ]),
            },
          );
        }
        batch
          ..set(
            firebaseFirestore
                .collection('sellLocation')
                .doc(placeMark.country)
                .collection(placeMark.state)
                .doc(placeMark.state),
            {
              'district': FieldValue.arrayUnion([
                {
                  placeMark.district: GeoPoint(
                    placeMark.geoPoint.latitude,
                    placeMark.geoPoint.longitude,
                  ),
                }
              ]),
            },
          )
          ..set(
            firebaseFirestore
                .collection('sellLocation')
                .doc(placeMark.country)
                .collection(placeMark.state)
                .doc(placeMark.state)
                .collection(placeMark.district)
                .doc(placeMark.district),
            {
              'localArea': FieldValue.arrayUnion([
                {
                  placeMark.localArea: GeoPoint(
                    placeMark.geoPoint.latitude,
                    placeMark.geoPoint.longitude,
                  ),
                }
              ]),
            },
          );

        await batch.commit();
        return right(unit); // stop and set location
      }

      // add country
      final batch = firebaseFirestore.batch()
        ..set(
          // set
          firebaseFirestore.collection('sellLocation').doc(placeMark.country),
          {
            'state': FieldValue.arrayUnion([
              {
                placeMark.state: GeoPoint(
                  placeMark.geoPoint.latitude,
                  placeMark.geoPoint.longitude,
                ),
              }
            ]),
          },
        )
        ..set(
          firebaseFirestore
              .collection('sellLocation')
              .doc(placeMark.country)
              .collection(placeMark.state)
              .doc(placeMark.state),
          {
            'district': FieldValue.arrayUnion([
              {
                placeMark.district: GeoPoint(
                  placeMark.geoPoint.latitude,
                  placeMark.geoPoint.longitude,
                ),
              }
            ]),
          },
        )
        ..set(
          firebaseFirestore
              .collection('sellLocation')
              .doc(placeMark.country)
              .collection(placeMark.state)
              .doc(placeMark.state)
              .collection(placeMark.district)
              .doc(placeMark.district),
          {
            'localArea': FieldValue.arrayUnion([
              {
                placeMark.localArea: GeoPoint(
                  placeMark.geoPoint.latitude,
                  placeMark.geoPoint.longitude,
                ),
              }
            ]),
          },
        );

      await batch.commit();
      return right(unit); // stop and set location
    } on FirebaseException catch (e) {
      return left(
        MainFailure.firebaseException(
          errMsg: e.code,
        ),
      );
    } catch (e) {
      return left(
        MainFailure.firebaseException(
          errMsg: '$e',
        ),
      );
    }
  }
  
}
