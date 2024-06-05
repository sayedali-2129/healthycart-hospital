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

import '../../features/add_hospital_form_page/application/hospital_form_provider.dart'
    as _i30;
import '../../features/add_hospital_form_page/domain/i_form_facade.dart'
    as _i20;
import '../../features/add_hospital_form_page/infrastructure/i_form_impl.dart'
    as _i21;
import '../../features/authenthication/application/authenication_provider.dart'
    as _i31;
import '../../features/authenthication/domain/i_auth_facade.dart' as _i24;
import '../../features/authenthication/infrastrucure/i_auth_impl.dart' as _i25;
import '../../features/hospital_banner/application/add_banner_provider.dart'
    as _i29;
import '../../features/hospital_banner/domain/i_banner_facade.dart' as _i22;
import '../../features/hospital_banner/infrastrucuture/i_banner_impl.dart'
    as _i23;
import '../../features/hospital_doctor/application/doctor_provider.dart'
    as _i27;
import '../../features/hospital_doctor/domain/i_doctor_facade.dart' as _i15;
import '../../features/hospital_doctor/infrastructure/i_doctor_impl.dart'
    as _i16;
import '../../features/hospital_profile/application/profile_provider.dart'
    as _i28;
import '../../features/hospital_profile/domain/i_profile_facade.dart' as _i11;
import '../../features/hospital_profile/infrastructure/i_profile_impl.dart'
    as _i12;
import '../../features/location_picker/application/location_provider.dart'
    as _i26;
import '../../features/location_picker/domain/i_location_facde.dart' as _i17;
import '../../features/location_picker/infrastructure/i_location_impl.dart'
    as _i18;
import '../../features/pending_page/application/pending_provider.dart' as _i19;
import '../../features/pending_page/domain/i_pending_facade.dart' as _i13;
import '../../features/pending_page/infrastrucuture/i_pending_impl.dart'
    as _i14;
import '../services/image_picker.dart' as _i7;
import '../services/location_service.dart' as _i8;
import '../services/pdf_picker.dart' as _i9;
import '../services/url_launcher.dart' as _i10;
import 'firebase_injectable_module.dart' as _i3;
import 'general_injectable_module.dart' as _i32;

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
  final generalInjecatbleModule = _$GeneralInjecatbleModule();
  await gh.factoryAsync<_i3.FirebaseService>(
    () => firebaseInjecatbleModule.firebaseService,
    preResolve: true,
  );
  gh.lazySingleton<_i4.FirebaseAuth>(() => firebaseInjecatbleModule.auth);
  gh.lazySingleton<_i5.FirebaseStorage>(() => firebaseInjecatbleModule.storage);
  gh.lazySingleton<_i6.FirebaseFirestore>(() => firebaseInjecatbleModule.repo);
  gh.lazySingleton<_i7.ImageService>(
      () => generalInjecatbleModule.imageServices);
  gh.lazySingleton<_i8.LocationService>(
      () => generalInjecatbleModule.locationServices);
  gh.lazySingleton<_i9.PdfPickerService>(
      () => generalInjecatbleModule.pdfPickerService);
  gh.lazySingleton<_i10.UrlService>(() => generalInjecatbleModule.urlService);
  gh.lazySingleton<_i11.IProfileFacade>(
      () => _i12.IProfileImpl(gh<_i6.FirebaseFirestore>()));
  gh.lazySingleton<_i13.IPendingFacade>(
      () => _i14.IPendingImpl(gh<_i10.UrlService>()));
  gh.lazySingleton<_i15.IDoctorFacade>(() => _i16.IDoctorImpl(
        gh<_i6.FirebaseFirestore>(),
        gh<_i7.ImageService>(),
      ));
  gh.lazySingleton<_i17.ILocationFacade>(() => _i18.ILocationImpl(
        gh<_i8.LocationService>(),
        gh<_i6.FirebaseFirestore>(),
      ));
  gh.factory<_i19.PendingProvider>(
      () => _i19.PendingProvider(gh<_i13.IPendingFacade>()));
  gh.lazySingleton<_i20.IFormFeildFacade>(() => _i21.IFormFieldImpl(
        gh<_i6.FirebaseFirestore>(),
        gh<_i7.ImageService>(),
        gh<_i9.PdfPickerService>(),
        gh<_i5.FirebaseStorage>(),
      ));
  gh.lazySingleton<_i22.IBannerFacade>(() => _i23.IBannerImpl(
        gh<_i6.FirebaseFirestore>(),
        gh<_i7.ImageService>(),
      ));
  gh.lazySingleton<_i24.IAuthFacade>(() => _i25.IAuthImpl(
        gh<_i4.FirebaseAuth>(),
        gh<_i6.FirebaseFirestore>(),
      ));
  gh.factory<_i26.LocationProvider>(
      () => _i26.LocationProvider(gh<_i17.ILocationFacade>()));
  gh.factory<_i27.DoctorProvider>(
      () => _i27.DoctorProvider(gh<_i15.IDoctorFacade>()));
  gh.factory<_i28.ProfileProvider>(
      () => _i28.ProfileProvider(gh<_i11.IProfileFacade>()));
  gh.factory<_i29.AddBannerProvider>(
      () => _i29.AddBannerProvider(gh<_i22.IBannerFacade>()));
  gh.factory<_i30.HosptialFormProvider>(
      () => _i30.HosptialFormProvider(gh<_i20.IFormFeildFacade>()));
  gh.factory<_i31.AuthenticationProvider>(
      () => _i31.AuthenticationProvider(gh<_i24.IAuthFacade>()));
  return getIt;
}

class _$FirebaseInjecatbleModule extends _i3.FirebaseInjecatbleModule {}

class _$GeneralInjecatbleModule extends _i32.GeneralInjecatbleModule {}
