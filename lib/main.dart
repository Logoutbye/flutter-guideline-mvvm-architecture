import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:truck_mandi/data/network/app_url.dart';
import 'package:truck_mandi/ui/core/theme/color.dart';
import 'package:truck_mandi/configs/routing/my_navigation_service.dart';
import 'package:truck_mandi/ui/features/auth/update_n_forgot_password/view_model/forget_password_view_model.dart';
import 'package:truck_mandi/ui/features/my_profile/view_model/edit_profile_vm.dart';
import 'package:truck_mandi/ui/features/my_profile/view_model/my_profile_vm.dart';
import 'package:truck_mandi/ui/features/my_profile/view_model/vehicle_ads_vm.dart';
import 'package:truck_mandi/ui/features/sell_spare_parts/view_model/auto_parts_view_model.dart';
import 'package:truck_mandi/ui/features/sell_trucks/view_model/truck_view_model.dart';
import 'package:truck_mandi/ui/features/splash/view/splash_screen.dart';
import 'package:truck_mandi/ui/features/auth/signup/view_model/signup_viewmodel.dart';
import 'package:truck_mandi/ui/features/dashboard/view_model/navigation_provider.dart';
import 'package:truck_mandi/ui/features/home/view_model/category_tab_index_notifier.dart';
import 'package:truck_mandi/ui/features/home/view_model/new_tab_bar_notifier.dart';
import 'package:truck_mandi/ui/features/splash/view_model/splash_view_model.dart';
import 'ui/features/auth/login/view_model/login_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: AppColors.whiteColor,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarColor: AppColors.whiteColor,
    ),
  );
  AppUrl.init();

  runApp(
    ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) => MyApp(),
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SplashViewModel()),
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => SignUpViewModel()),
        ChangeNotifierProvider(create: (_) => ForgetPasswordViewModel()),
        ChangeNotifierProvider(create: (_) => VehicleAdsVM()),
        ChangeNotifierProvider(create: (_) => ProfileVM()),
        ChangeNotifierProvider(create: (_) => EditProfileVM()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => EditProfileVM()),
        ChangeNotifierProvider(create: (_) => TruckViewModel()),
        ChangeNotifierProvider(create: (_) => AutoPartsViewModel()),

        ChangeNotifierProvider(create: (_) => CategoryTabIndexNotifier()),
        ChangeNotifierProvider(create: (_) => CustomTabBarNotifier()),
      ],
      child: MaterialApp(
        navigatorKey: MyNavigationService.navigatorKey,

        debugShowCheckedModeBanner: false,
        title: 'flutter-mvvm-feature-architecture',

        home: SplashScreen(),
      ),
    );
  }
}
