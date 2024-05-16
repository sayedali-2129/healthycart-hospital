
// import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:healthycart/features/hospital_app/doctor_page/domain/model/add_doctor_model.dart';

// class DoctorAddedListModel {
//   String? combinedId;
//   final String? categoryId;
//   final String? userId;
//   final List<DoctorAddModel> doctors;
//   DoctorAddedListModel({
//     this.categoryId,
//     this.userId,
//     this.combinedId,
//     required this.doctors,
//   });

//   DoctorAddedListModel copyWith({
//     String? categoryId,
//     String? userId,
//     String? combinedId,
//     List<DoctorAddModel>? doctors,
//   }) {
//     return DoctorAddedListModel(
//       categoryId: categoryId ?? this.categoryId,
//       userId: userId ?? this.userId,
//       combinedId: combinedId ?? this.combinedId,
//       doctors: doctors ?? this.doctors,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'categoryId': categoryId,
//       'userId': userId,
//       'combinedId': combinedId,
//       'doctors': DoctorAddedListModel.listToMapofMap(doctors),
//     };
//   }

//   factory DoctorAddedListModel.fromMap(Map<String, dynamic> map) {
//     return DoctorAddedListModel(
//       categoryId:
//       map['categoryId'] != null ? map['categoryId'] as String : null,
//       userId: map['userId'] != null ? map['userId'] as String : null,
//       combinedId:map['combinedId'] != null ? map['combinedId'] as String : null,
//       doctors: mapToListDoctorAddModel(extractData(map['doctors'])),
//     );
//   }

//   static Map<String, Map<String, dynamic>> listToMapofMap(
//       List<DoctorAddModel> doctors) {
//     Map<String, Map<String, dynamic>> resultMap = {};
//     for (DoctorAddModel element in doctors) {
//       resultMap[element.id ?? 'uuu'] = element.toMap();
//     }
//     return resultMap;
//   }

//   static List<DoctorAddModel> mapToListDoctorAddModel(
//       Map<String, Map<String, dynamic>> map) {
//     List<DoctorAddModel> resultList = [];

//     map.entries.forEach((element) {
//       Map<String, dynamic> doctors = element.value;
//       DoctorAddModel doctorModel = DoctorAddModel(
//         id: doctors['id'] != null ? doctors['id'] as String : null,
//         doctorImage: doctors['doctorImage'] != null
//             ? doctors['doctorImage'] as String
//             : null,
//         doctorName: doctors['doctorName'] != null
//             ? doctors['doctorName'] as String
//             : null,
//         doctorTotalTime: doctors['doctorTotalTime'] != null
//             ? doctors['doctorTotalTime'] as String
//             : null,
//         doctorTimeList: doctors['doctorTimeList'] != null
//             ? List<String>.from((doctors['doctorTimeList'] as List<dynamic>))
//             : null,
//         doctorFee:
//             doctors['doctorFee'] != null ? doctors['doctorFee'] as int : null,
//         doctorSpecialization: doctors['doctorSpecialization'] != null
//             ? doctors['doctorSpecialization'] as String
//             : null,
//         doctorExperience: doctors['doctorExperience'] != null
//             ? doctors['doctorExperience'] as int
//             : null,
//         doctorQualification: doctors['doctorQualification'] != null
//             ? doctors['doctorQualification'] as String
//             : null,
//         doctorAbout: doctors['doctorAbout'] != null
//             ? doctors['doctorAbout'] as String
//             : null,
//       );
//       resultList.add(doctorModel);
//     });
//     return resultList;
//   }

//   static Map<String, Map<String, dynamic>> extractData(
//       Map<String, dynamic> data) {
//     Map<String, Map<String, dynamic>> resultMap = {};
//     data.forEach((key, value) {
//       resultMap[key] = Map<String, dynamic>.from(value);
//     });
//     return resultMap;
//   }
// }
