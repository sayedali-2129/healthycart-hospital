import 'package:flutter/material.dart';
import 'package:healthycart/core/di/injection.dart';
import 'package:healthycart/features/authenthication/application/authenication_provider.dart';
import 'package:healthycart/features/hospital_banner/application/add_banner_provider.dart';
import 'package:healthycart/features/hospital_doctor/application/doctor_provider.dart';
import 'package:healthycart/features/add_hospital_form_page/application/hospital_form_provider.dart';
import 'package:healthycart/features/hospital_profile/application/profile_provider.dart';
import 'package:healthycart/features/hospital_request_userside/application/provider/request_doctor_provider.dart';
import 'package:healthycart/features/location_picker/application/location_provider.dart';
import 'package:healthycart/features/pending_page/application/pending_provider.dart';
import 'package:healthycart/features/pending_page/presentation/pending_page.dart';
import 'package:healthycart/features/splash_screen/splash_screen.dart';
import 'package:healthycart/main.dart';
import 'package:healthycart/utils/theme/theme.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
   
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(
        //   create: (context) => HomeProvider(sl<IHomeFacade>()),
        // ),
        ChangeNotifierProvider(
          create: (context) => sl<HosptialFormProvider>(),
        ),
        ChangeNotifierProvider(
          create: (context) => sl<DoctorProvider>(),
        ),
        ChangeNotifierProvider(
          create: (context) => RequestDoctorProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => sl<AddBannerProvider>(),
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
       ChangeNotifierProvider(
          create: (context) => sl<ProfileProvider>(),
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
