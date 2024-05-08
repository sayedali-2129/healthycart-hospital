// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorCategoryModel {
  final String image;
  final String category;
  final Timestamp isCreated;
  DoctorCategoryModel({
    required this.image,
    required this.category,
    required this.isCreated,
  });


  DoctorCategoryModel copyWith({
    String? image,
    String? category,
    Timestamp? isCreated,
  }) {
    return DoctorCategoryModel(
      image: image ?? this.image,
      category: category ?? this.category,
      isCreated: isCreated ?? this.isCreated,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
      'category': category,
      'isCreated': isCreated,
    };
  }

  factory DoctorCategoryModel.fromMap(Map<String, dynamic> map) {
    return DoctorCategoryModel(
      image: map['image'] as String,
      category: map['category'] as String,
      isCreated:map['isCreated'] as Timestamp,
    );
  }


}
