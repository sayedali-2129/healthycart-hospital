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
    as _i32;
import '../../features/add_hospital_form_page/domain/i_form_facade.dart'
    as _i21;
import '../../features/add_hospital_form_page/infrastructure/i_form_impl.dart'
    as _i22;
import '../../features/authenthication/application/authenication_provider.dart'
    as _i34;
import '../../features/authenthication/domain/i_auth_facade.dart' as _i25;
import '../../features/authenthication/infrastrucure/i_auth_impl.dart' as _i26;
import '../../features/hospital_banner/application/add_banner_provider.dart'
    as _i31;
import '../../features/hospital_banner/domain/i_banner_facade.dart' as _i23;
import '../../features/hospital_banner/infrastrucuture/i_banner_impl.dart'
    as _i24;
import '../../features/hospital_doctor/application/doctor_provider.dart'
    as _i13;
import '../../features/hospital_doctor/domain/i_doctor_facade.dart' as _i11;
import '../../features/hospital_doctor/infrastructure/i_doctor_impl.dart'
    as _i12;
import '../../features/hospital_profile/application/profile_provider.dart'
    as _i30;
import '../../features/hospital_profile/domain/i_profile_facade.dart' as _i14;
import '../../features/hospital_profile/infrastructure/i_profile_impl.dart'
    as _i15;
import '../../features/hospital_request_userside/application/provider/hospital_booking_provider.dart.dart'
    as _i33;
import '../../features/hospital_request_userside/domain/i_booking_facade.dart'
    as _i28;
import '../../features/hospital_request_userside/infrastructure/i_booking_impl.dart'
    as _i29;
import '../../features/location_picker/application/location_provider.dart'
    as _i27;
import '../../features/location_picker/domain/i_location_facde.dart' as _i18;
import '../../features/location_picker/infrastructure/i_location_impl.dart'
    as _i19;
import '../../features/pending_page/application/pending_provider.dart' as _i20;
import '../../features/pending_page/domain/i_pending_facade.dart' as _i16;
import '../../features/pending_page/infrastrucuture/i_pending_impl.dart'
    as _i17;
import '../services/image_picker.dart' as _i7;
import '../services/location_service.dart' as _i8;
import '../services/pdf_picker.dart' as _i9;
import '../services/url_launcher.dart' as _i10;
import 'firebase_injectable_module.dart' as _i3;
import 'general_injectable_module.dart' as _i35;

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
  gh.lazySingleton<_i11.IDoctorFacade>(() => _i12.IDoctorImpl(
        gh<_i6.FirebaseFirestore>(),
        gh<_i7.ImageService>(),
      ));
  gh.factory<_i13.DoctorProvider>(
      () => _i13.DoctorProvider(gh<_i11.IDoctorFacade>()));
  gh.lazySingleton<_i14.IProfileFacade>(
      () => _i15.IProfileImpl(gh<_i6.FirebaseFirestore>()));
  gh.lazySingleton<_i16.IPendingFacade>(
      () => _i17.IPendingImpl(gh<_i10.UrlService>()));
  gh.lazySingleton<_i18.ILocationFacade>(() => _i19.ILocationImpl(
        gh<_i8.LocationService>(),
        gh<_i6.FirebaseFirestore>(),
      ));
  gh.factory<_i20.PendingProvider>(
      () => _i20.PendingProvider(gh<_i16.IPendingFacade>()));
  gh.lazySingleton<_i21.IFormFeildFacade>(() => _i22.IFormFieldImpl(
        gh<_i6.FirebaseFirestore>(),
        gh<_i7.ImageService>(),
        gh<_i9.PdfPickerService>(),
      ));
  gh.lazySingleton<_i23.IBannerFacade>(() => _i24.IBannerImpl(
        gh<_i6.FirebaseFirestore>(),
        gh<_i7.ImageService>(),
      ));
  gh.lazySingleton<_i25.IAuthFacade>(() => _i26.IAuthImpl(
        gh<_i4.FirebaseAuth>(),
        gh<_i6.FirebaseFirestore>(),
      ));
  gh.factory<_i27.LocationProvider>(
      () => _i27.LocationProvider(gh<_i18.ILocationFacade>()));
  gh.lazySingleton<_i28.IBookingFacade>(
      () => _i29.IBookingImpl(gh<_i6.FirebaseFirestore>()));
  gh.factory<_i30.ProfileProvider>(
      () => _i30.ProfileProvider(gh<_i14.IProfileFacade>()));
  gh.factory<_i31.AddBannerProvider>(
      () => _i31.AddBannerProvider(gh<_i23.IBannerFacade>()));
  gh.factory<_i32.HosptialFormProvider>(
      () => _i32.HosptialFormProvider(gh<_i21.IFormFeildFacade>()));
  gh.factory<_i33.HospitalBookingProvider>(
      () => _i33.HospitalBookingProvider(gh<_i28.IBookingFacade>()));
  gh.factory<_i34.AuthenticationProvider>(
      () => _i34.AuthenticationProvider(gh<_i25.IAuthFacade>()));
  return getIt;
}

class _$FirebaseInjecatbleModule extends _i3.FirebaseInjecatbleModule {}

class _$GeneralInjecatbleModule extends _i35.GeneralInjecatbleModule {}
