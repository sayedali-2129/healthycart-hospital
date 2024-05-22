import 'package:flutter/material.dart';
import 'package:healthycart/core/di/injection.dart';
import 'package:healthycart/features/authenthication/application/authenication_provider.dart';
import 'package:healthycart/features/authenthication/domain/i_auth_facade.dart';
import 'package:healthycart/features/home/application/main_provider.dart';
import 'package:healthycart/features/home/domain/i_main_facade.dart';
import 'package:healthycart/features/home/presentation/home.dart';
import 'package:healthycart/features/hospital_app/banner_page/application/add_banner_provider.dart';
import 'package:healthycart/features/hospital_app/banner_page/domain/i_banner_facade.dart';
import 'package:healthycart/features/hospital_app/doctor_page/application/doctor_provider.dart';
import 'package:healthycart/features/hospital_app/doctor_page/domain/i_doctor_facade.dart';
import 'package:healthycart/features/add_hospital_form/application/hospital_form_provider.dart';
import 'package:healthycart/features/add_hospital_form/domain/i_form_facade.dart';
import 'package:healthycart/features/hospital_app/request_page/application/provider/request_doctor_provider.dart';
import 'package:healthycart/features/location_page/application/location_provider.dart';
import 'package:healthycart/features/location_page/presentation/location.dart';
import 'package:healthycart/features/pending_page/application/pending_provider.dart';
import 'package:healthycart/features/splash_screen/splash_screen.dart';
import 'package:healthycart/main.dart';
import 'package:healthycart/utils/theme/theme.dart';
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
          create: (context) => sl<LocationProvider>(),
        ),

      ChangeNotifierProvider(
          create: (context) => sl<AuthenticationProvider>(),
        ), 
        
      ChangeNotifierProvider(
          create: (context) => sl<PendingProvider>(),
        ), 
      ],
        child: MaterialApp(
          navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.light,
            theme: BAppTheme.lightTheme,
            darkTheme: BAppTheme.darkTheme,
            home: const SplashScreen()),
      
    );
  }
}
