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
    as _i25;
import '../../features/authenthication/domain/i_auth_facade.dart' as _i17;
import '../../features/authenthication/infrastrucure/i_auth_impl.dart' as _i18;
import '../../features/home/application/main_provider.dart' as _i23;
import '../../features/home/domain/i_main_facade.dart' as _i19;
import '../../features/home/infrastructure/i_main_impl.dart' as _i20;
import '../../features/hospital_app/banner_page/application/add_banner_provider.dart'
    as _i22;
import '../../features/hospital_app/banner_page/domain/i_banner_facade.dart'
    as _i11;
import '../../features/hospital_app/banner_page/infrastrucuture/i_banner_impl.dart'
    as _i12;
import '../../features/hospital_app/doctor_page/application/doctor_provider.dart'
    as _i21;
import '../../features/hospital_app/doctor_page/domain/i_doctor_facade.dart'
    as _i15;
import '../../features/hospital_app/doctor_page/infrastructure/i_doctor_impl.dart'
    as _i16;
import '../../features/hospital_form_field/application/hospital_form_provider.dart'
    as _i24;
import '../../features/hospital_form_field/domain/i_form_facade.dart' as _i13;
import '../../features/hospital_form_field/infrastructure/i_form_impl.dart'
    as _i14;
import '../../features/location_page/domain/i_location_facde.dart' as _i9;
import '../../features/location_page/infrastructure/i_location_impl.dart'
    as _i10;
import '../services/image_picker.dart' as _i8;
import '../services/location_service.dart' as _i7;
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
  gh.lazySingleton<_i7.LocationService>(() => _i7.LocationService());
  gh.lazySingleton<_i8.ImageService>(
      () => _i8.ImageService(gh<_i5.FirebaseStorage>()));
  gh.lazySingleton<_i9.ILocationFacade>(() => _i10.ILocationImpl(
        gh<_i7.LocationService>(),
        gh<_i6.FirebaseFirestore>(),
      ));
  gh.lazySingleton<_i11.IBannerFacade>(() => _i12.IBannerImpl(
        gh<_i6.FirebaseFirestore>(),
        gh<_i8.ImageService>(),
      ));
  gh.lazySingleton<_i13.IFormFeildFacade>(() => _i14.IFormFieldImpl(
        gh<_i6.FirebaseFirestore>(),
        gh<_i8.ImageService>(),
      ));
  gh.lazySingleton<_i15.IDoctorFacade>(() => _i16.IDoctorImpl(
        gh<_i6.FirebaseFirestore>(),
        gh<_i8.ImageService>(),
      ));
  gh.lazySingleton<_i17.IAuthFacade>(() => _i18.IAuthImpl(
        gh<_i4.FirebaseAuth>(),
        gh<_i6.FirebaseFirestore>(),
      ));
  gh.lazySingleton<_i19.IMainFacade>(
      () => _i20.IMainImpl(gh<_i6.FirebaseFirestore>()));
  gh.factory<_i21.DoctorProvider>(
      () => _i21.DoctorProvider(gh<_i15.IDoctorFacade>()));
  gh.factory<_i22.AddBannerProvider>(
      () => _i22.AddBannerProvider(gh<_i11.IBannerFacade>()));
  gh.factory<_i23.MainProvider>(
      () => _i23.MainProvider(gh<_i19.IMainFacade>()));
  gh.factory<_i24.HosptialFormProvider>(
      () => _i24.HosptialFormProvider(gh<_i13.IFormFeildFacade>()));
  gh.factory<_i25.AuthenicationCubit>(
      () => _i25.AuthenicationCubit(gh<_i17.IAuthFacade>()));
  return getIt;
}

class _$FirebaseInjecatbleModule extends _i3.FirebaseInjecatbleModule {}
