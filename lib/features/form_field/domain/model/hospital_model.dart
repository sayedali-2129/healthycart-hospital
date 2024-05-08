// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:geocoding/geocoding.dart';

import 'package:healthycart/features/form_field/domain/model/admin_model.dart';
import 'package:healthycart/utils/constants/enums.dart';

class HospitalModel extends Admin {
  HospitalModel({
    super.adminType,
    super.phoneNo,
    this.hospitalName,
    this.address,
    this.ownerName,
    this.uploadLicense,
    this.image,
    super.id,
    super.placemark,
  });

  final String? hospitalName;
  final String? address;
  final String? ownerName;
  final String? uploadLicense;
  final String? image;

  @override
  Map<String, dynamic> toMap() {
    return {
      'hospitalName': hospitalName,
      'address': address,
      'ownerName': ownerName,
      'uploadLicense': uploadLicense,
      'image': image,
      ...super.toMap()
    };
  }

  factory HospitalModel.initial() {
    return HospitalModel();
  }

  factory HospitalModel.fromMap(Map<String, dynamic> map) {
    return HospitalModel(
      adminType: Admin.getAdminType(
        map['adminType'] ?? '',
      ), // Ensure you're getting adminType from map
      phoneNo: map['phoneNo'] as String,
      id: map['id'] as String?,
      placemark: map['placemark'] != null
          ? Placemark.fromMap(map['placemark'] as Map<String, dynamic>)
          : null,
      hospitalName: map['hospitalName'] as String?,
      address: map['address'] as String?,
      ownerName: map['ownerName'] as String?,
      uploadLicense: map['uploadLicense'] as String?,
      image: map['image'] as String?,
    );
  }

  HospitalModel copyWith({
    String? hospitalName,
    String? address,
    String? ownerName,
    String? uploadLicense,
    String? image,
    AdminType? adminType,
    Placemark? placemark,
    String? phoneNo,
    String? id,
  }) {
    return HospitalModel(
      id: id ?? super.id,
      phoneNo: phoneNo ?? super.phoneNo,
      adminType: adminType ?? super.adminType,
      placemark: placemark ?? super.placemark,
      hospitalName: hospitalName ?? this.hospitalName,
      address: address ?? this.address,
      ownerName: ownerName ?? this.ownerName,
      uploadLicense: uploadLicense ?? this.uploadLicense,
      image: image ?? this.image,
    );
  }
}
