// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i6;
import 'package:firebase_auth/firebase_auth.dart' as _i4;
import 'package:firebase_storage/firebase_storage.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/authenthication/application/auth_cubit/authenication_cubit.dart'
    as _i16;
import '../../features/authenthication/domain/i_auth_facade.dart' as _i13;
import '../../features/authenthication/infrastrucure/i_auth_impl.dart' as _i14;
import '../../features/doctor_page/application/provider/doctor_provider.dart'
    as _i12;
import '../../features/doctor_page/domain/i_doctor_facade.dart' as _i8;
import '../../features/doctor_page/infrastructure/i_doctor_impl.dart' as _i9;
import '../../features/form_field/application/provider/hospital_form_provider.dart'
    as _i15;
import '../../features/form_field/domain/i_form_facade.dart' as _i10;
import '../../features/form_field/infrastructure/i_form_impl.dart' as _i11;
import '../services/image_picker.dart' as _i7;
import 'firebase_injectable_module.dart' as _i3;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i1.GetIt> init(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final firebaseInjecatbleModule = _$FirebaseInjecatbleModule();
  await gh.factoryAsync<_i3.FirebaseServeice>(
    () => firebaseInjecatbleModule.firebaseServeice,
    preResolve: true,
  );
  gh.lazySingleton<_i4.FirebaseAuth>(() => firebaseInjecatbleModule.auth);
  gh.lazySingleton<_i5.FirebaseStorage>(() => firebaseInjecatbleModule.storage);
  gh.lazySingleton<_i6.FirebaseFirestore>(() => firebaseInjecatbleModule.repo);
  gh.lazySingleton<_i7.ImageService>(
      () => _i7.ImageService(gh<_i5.FirebaseStorage>()));
  gh.lazySingleton<_i8.IDoctorFacade>(() => _i9.IDoctorImpl(
        gh<_i6.FirebaseFirestore>(),
        gh<_i7.ImageService>(),
      ));
  gh.lazySingleton<_i10.IFormFeildFacade>(
      () => _i11.IFormFieldImpl(gh<_i6.FirebaseFirestore>()));
  gh.factory<_i12.DoctorProvider>(
      () => _i12.DoctorProvider(gh<_i8.IDoctorFacade>()));
  gh.lazySingleton<_i13.IAuthFacade>(() => _i14.IAuthImpl(
        gh<_i4.FirebaseAuth>(),
        gh<_i6.FirebaseFirestore>(),
      ));
  gh.factory<_i15.HosptialFormProvider>(
      () => _i15.HosptialFormProvider(gh<_i10.IFormFeildFacade>()));
  gh.factory<_i16.AuthenicationCubit>(
      () => _i16.AuthenicationCubit(gh<_i13.IAuthFacade>()));
  return getIt;
}

class _$FirebaseInjecatbleModule extends _i3.FirebaseInjecatbleModule {}
