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
    as _i19;
import '../../features/authenthication/domain/i_auth_facade.dart' as _i12;
import '../../features/authenthication/infrastrucure/i_auth_impl.dart' as _i13;
import '../../features/form_field/application/provider/hospital_form_provider.dart'
    as _i18;
import '../../features/form_field/domain/i_form_facade.dart' as _i14;
import '../../features/form_field/infrastructure/i_form_impl.dart' as _i15;
import '../../features/hospital_app/banner_page/application/add_banner_provider.dart'
    as _i17;
import '../../features/hospital_app/banner_page/domain/i_banner_facade.dart'
    as _i8;
import '../../features/hospital_app/banner_page/infrastrucuture/i_banner_impl.dart'
    as _i9;
import '../../features/hospital_app/doctor_page/application/doctor_provider.dart'
    as _i16;
import '../../features/hospital_app/doctor_page/domain/i_doctor_facade.dart'
    as _i10;
import '../../features/hospital_app/doctor_page/infrastructure/i_doctor_impl.dart'
    as _i11;
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
  gh.lazySingleton<_i8.IBannerFacade>(() => _i9.IBannerImpl(
        gh<_i6.FirebaseFirestore>(),
        gh<_i7.ImageService>(),
      ));
  gh.lazySingleton<_i10.IDoctorFacade>(() => _i11.IDoctorImpl(
        gh<_i6.FirebaseFirestore>(),
        gh<_i7.ImageService>(),
      ));
  gh.lazySingleton<_i12.IAuthFacade>(() => _i13.IAuthImpl(
        gh<_i4.FirebaseAuth>(),
        gh<_i6.FirebaseFirestore>(),
      ));
  gh.lazySingleton<_i14.IFormFeildFacade>(() => _i15.IFormFieldImpl(
        gh<_i6.FirebaseFirestore>(),
        gh<_i7.ImageService>(),
      ));
  gh.factory<_i16.DoctorProvider>(
      () => _i16.DoctorProvider(gh<_i10.IDoctorFacade>()));
  gh.factory<_i17.AddBannerProvider>(
      () => _i17.AddBannerProvider(gh<_i8.IBannerFacade>()));
  gh.factory<_i18.HosptialFormProvider>(
      () => _i18.HosptialFormProvider(gh<_i14.IFormFeildFacade>()));
  gh.factory<_i19.AuthenicationCubit>(
      () => _i19.AuthenicationCubit(gh<_i12.IAuthFacade>()));
  return getIt;
}

class _$FirebaseInjecatbleModule extends _i3.FirebaseInjecatbleModule {}
