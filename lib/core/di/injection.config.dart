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

import '../../features/add_hospital_form/application/hospital_form_provider.dart'
    as _i29;
import '../../features/add_hospital_form/domain/i_form_facade.dart' as _i18;
import '../../features/add_hospital_form/infrastructure/i_form_impl.dart'
    as _i19;
import '../../features/authenthication/application/authenication_provider.dart'
    as _i33;
import '../../features/authenthication/domain/i_auth_facade.dart' as _i24;
import '../../features/authenthication/infrastrucure/i_auth_impl.dart' as _i25;
import '../../features/home/application/main_provider.dart' as _i32;
import '../../features/home/domain/i_main_facade.dart' as _i26;
import '../../features/home/infrastructure/i_main_impl.dart' as _i27;
import '../../features/hospital_app/banner_page/application/add_banner_provider.dart'
    as _i30;
import '../../features/hospital_app/banner_page/domain/i_banner_facade.dart'
    as _i15;
import '../../features/hospital_app/banner_page/infrastrucuture/i_banner_impl.dart'
    as _i16;
import '../../features/hospital_app/doctor_page/application/doctor_provider.dart'
    as _i28;
import '../../features/hospital_app/doctor_page/domain/i_doctor_facade.dart'
    as _i22;
import '../../features/hospital_app/doctor_page/infrastructure/i_doctor_impl.dart'
    as _i23;
import '../../features/hospital_app/profile_page/domain/i_profile_facade.dart'
    as _i11;
import '../../features/hospital_app/profile_page/infrastructure/i_profile_impl.dart'
    as _i12;
import '../../features/location_page/application/location_provider.dart'
    as _i31;
import '../../features/location_page/domain/i_location_facde.dart' as _i20;
import '../../features/location_page/infrastructure/i_location_impl.dart'
    as _i21;
import '../../features/pending_page/application/pending_provider.dart' as _i17;
import '../../features/pending_page/domain/i_pending_facade.dart' as _i13;
import '../../features/pending_page/infrastrucuture/i_pending_impl.dart'
    as _i14;
import '../services/image_picker.dart' as _i9;
import '../services/location_service.dart' as _i7;
import '../services/pdf_picker.dart' as _i10;
import '../services/url_launcher.dart' as _i8;
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
  gh.lazySingleton<_i8.UrlService>(() => _i8.UrlService());
  gh.lazySingleton<_i9.ImageService>(
      () => _i9.ImageService(gh<_i5.FirebaseStorage>()));
  gh.lazySingleton<_i10.PdfPickerService>(
      () => _i10.PdfPickerService(gh<_i5.FirebaseStorage>()));
  gh.lazySingleton<_i11.IProfileFacade>(() => _i12.IProfileImpl());
  gh.lazySingleton<_i13.IPendingFacade>(
      () => _i14.IPendingImpl(gh<_i8.UrlService>()));
  gh.lazySingleton<_i15.IBannerFacade>(() => _i16.IBannerImpl(
        gh<_i6.FirebaseFirestore>(),
        gh<_i9.ImageService>(),
      ));
  gh.factory<_i17.PendingProvider>(
      () => _i17.PendingProvider(gh<_i13.IPendingFacade>()));
  gh.lazySingleton<_i18.IFormFeildFacade>(() => _i19.IFormFieldImpl(
        gh<_i6.FirebaseFirestore>(),
        gh<_i9.ImageService>(),
        gh<_i10.PdfPickerService>(),
      ));
  gh.lazySingleton<_i20.ILocationFacade>(() => _i21.ILocationImpl(
        gh<_i7.LocationService>(),
        gh<_i6.FirebaseFirestore>(),
      ));
  gh.lazySingleton<_i22.IDoctorFacade>(() => _i23.IDoctorImpl(
        gh<_i6.FirebaseFirestore>(),
        gh<_i9.ImageService>(),
      ));
  gh.lazySingleton<_i24.IAuthFacade>(() => _i25.IAuthImpl(
        gh<_i4.FirebaseAuth>(),
        gh<_i6.FirebaseFirestore>(),
      ));
  gh.lazySingleton<_i26.IMainFacade>(
      () => _i27.IMainImpl(gh<_i6.FirebaseFirestore>()));
  gh.factory<_i28.DoctorProvider>(
      () => _i28.DoctorProvider(gh<_i22.IDoctorFacade>()));
  gh.factory<_i29.HosptialFormProvider>(
      () => _i29.HosptialFormProvider(gh<_i18.IFormFeildFacade>()));
  gh.factory<_i30.AddBannerProvider>(
      () => _i30.AddBannerProvider(gh<_i15.IBannerFacade>()));
  gh.factory<_i31.LocationProvider>(
      () => _i31.LocationProvider(gh<_i20.ILocationFacade>()));
  gh.factory<_i32.MainProvider>(
      () => _i32.MainProvider(gh<_i26.IMainFacade>()));
  gh.factory<_i33.AuthenticationProvider>(
      () => _i33.AuthenticationProvider(gh<_i24.IAuthFacade>()));
  return getIt;
}

class _$FirebaseInjecatbleModule extends _i3.FirebaseInjecatbleModule {}
