import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:healthycart/core/di/injection.dart';
import 'package:healthycart/core/services/foreground_notification.dart';
import 'package:healthycart/features/add_hospital_form_page/application/hospital_form_provider.dart';
import 'package:healthycart/features/authenthication/application/authenication_provider.dart';
import 'package:healthycart/features/hospital_banner/application/add_banner_provider.dart';
import 'package:healthycart/features/hospital_doctor/application/doctor_provider.dart';
import 'package:healthycart/features/hospital_profile/application/profile_provider.dart';
import 'package:healthycart/features/hospital_request_userside/application/provider/hospital_booking_provider.dart.dart';
import 'package:healthycart/features/location_picker/application/location_provider.dart';
import 'package:healthycart/features/notification/application/notification_provider.dart';
import 'package:healthycart/features/pending_page/application/pending_provider.dart';
import 'package:healthycart/features/splash_screen/splash_screen.dart';
import 'package:healthycart/main.dart';
import 'package:healthycart/utils/theme/theme.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  const App(
      {super.key,
      required this.androidNotificationChannel,
      required this.flutterLocalNotificationsPlugin});
  final AndroidNotificationChannel androidNotificationChannel;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    ForegroundNotificationService.foregroundNotitficationInit(
        channel: widget.androidNotificationChannel,
        flutterLocalNotificationsPlugin:
            widget.flutterLocalNotificationsPlugin);
    super.initState();
  }

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
          create: (context) => sl<HospitalBookingProvider>(),
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
        ChangeNotifierProvider(
          create: (context) => NotificationProvider(),
        ),
      ],
      child: MaterialApp(
          builder: (context, child) => Overlay(
                initialEntries: [
                  if (child != null) ...[
                    OverlayEntry(
                      builder: (context) => child,
                    ),
                  ],
                ],
              ),
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light,
          theme: BAppTheme.lightTheme,
          darkTheme: BAppTheme.darkTheme,
          home: const SplashScreen()),
    );
  }
}
