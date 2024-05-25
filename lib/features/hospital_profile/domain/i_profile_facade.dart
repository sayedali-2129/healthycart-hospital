import 'package:healthycart/core/general/typdef.dart';
import 'package:healthycart/features/hospital_doctor/domain/model/add_doctor_model.dart';

abstract class IProfileFacade {
  FutureResult<List<DoctorAddModel>> getAllDoctorDetails();

  FutureResult<String> setActiveHospital(
      {required bool ishospitalON, required String hospitalId,});
}
