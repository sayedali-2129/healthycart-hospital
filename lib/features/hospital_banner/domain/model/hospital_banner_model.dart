

import 'package:cloud_firestore/cloud_firestore.dart';

class HospitalBannerModel {
  String? id;
  final String? image;
  final Timestamp? isCreated;
  HospitalBannerModel({
    this.id,
    this.image,
     this.isCreated,
  });

  HospitalBannerModel copyWith({
    String? id,
    String? image,
    Timestamp? isCreated,
  }) {
    return HospitalBannerModel(
      id: id ?? this.id,
      image: image ?? this.image,
      isCreated: isCreated ?? this.isCreated,);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image': image,
      'isCreated': isCreated,
    };
  }

  factory HospitalBannerModel.fromMap(Map<String, dynamic> map) {
    return HospitalBannerModel(
      id: map['id'] != null ? map['id'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      isCreated: map['isCreated'] as Timestamp,
    );
  }


}
