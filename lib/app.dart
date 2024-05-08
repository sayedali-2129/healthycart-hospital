import 'package:flutter/material.dart';
import 'package:healthycart/core/di/injection.dart';
import 'package:healthycart/features/authenthication/application/auth_cubit/authenication_cubit.dart';
import 'package:healthycart/features/authenthication/domain/i_auth_facade.dart';
import 'package:healthycart/features/doctor_page/application/provider/doctor_provider.dart';
import 'package:healthycart/features/doctor_page/domain/i_doctor_facade.dart';
import 'package:healthycart/features/form_field/application/provider/hospital_form_provider.dart';
import 'package:healthycart/features/form_field/domain/i_form_facade.dart';
import 'package:healthycart/features/home/home.dart';
import 'package:healthycart/features/location_page/application/location_bloc/cubit/location_cubit.dart';
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
          create: (context) => HosptialFormProvider(sl<IFormFeildFacade>()),
        ),
                ChangeNotifierProvider(
          create: (context) => DoctorProvider(sl<IDoctorFacade>()),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthenicationCubit(sl<IAuthFacade>()),
          ),
          BlocProvider(
            create: (context) => LocationCubit(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light,
          theme: BAppTheme.lightTheme,
          darkTheme: BAppTheme.darkTheme,
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
