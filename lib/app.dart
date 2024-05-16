import 'package:flutter/material.dart';
import 'package:healthycart/core/di/injection.dart';
import 'package:healthycart/features/authenthication/application/auth_cubit/authenication_cubit.dart';
import 'package:healthycart/features/authenthication/domain/i_auth_facade.dart';
import 'package:healthycart/features/home/application/main_provider.dart';
import 'package:healthycart/features/home/domain/i_main_facade.dart';
import 'package:healthycart/features/home/presentation/home.dart';
import 'package:healthycart/features/hospital_app/banner_page/application/add_banner_provider.dart';
import 'package:healthycart/features/hospital_app/banner_page/domain/i_banner_facade.dart';
import 'package:healthycart/features/hospital_app/doctor_page/application/doctor_provider.dart';
import 'package:healthycart/features/hospital_app/doctor_page/domain/i_doctor_facade.dart';
import 'package:healthycart/features/hospital_form_field/application/hospital_form_provider.dart';
import 'package:healthycart/features/hospital_form_field/domain/i_form_facade.dart';
import 'package:healthycart/features/hospital_app/request_page/application/provider/request_doctor_provider.dart';
import 'package:healthycart/features/location_page/application/provider/location_provider.dart';
import 'package:healthycart/features/location_page/domain/i_location_facde.dart';
import 'package:healthycart/features/location_page/presentation/location.dart';
import 'package:healthycart/utils/theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MainProvider(sl<IMainFacade>()),
        ),
        ChangeNotifierProvider(
          create: (context) => HosptialFormProvider(sl<IFormFeildFacade>()),
        ),
        ChangeNotifierProvider(
          create: (context) => DoctorProvider(sl<IDoctorFacade>()),
        ),
        ChangeNotifierProvider(
          create: (context) => RequestDoctorProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddBannerProvider(sl<IBannerFacade>()),
        ),
       ChangeNotifierProvider(
          create: (context) => LocationProvider(sl<ILocationFacade>()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthenicationCubit(sl<IAuthFacade>()),
          ),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.light,
            theme: BAppTheme.lightTheme,
            darkTheme: BAppTheme.darkTheme,
            home: const LocationPage()),
      ),
    );
  }
}
