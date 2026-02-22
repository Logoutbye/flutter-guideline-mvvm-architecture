// import 'package:flutter/material.dart';
// import 'package:truck_mandi/l10n/app_localizations.dart';
// import 'package:provider/provider.dart';
// import 'package:truck_mandi/src/configs/color/color.dart';
// import 'package:truck_mandi/src/configs/components/round_button.dart';
// import 'package:truck_mandi/src/configs/extensions.dart';
// import 'package:truck_mandi/src/configs/routes/my_navigation_service.dart';

// import 'package:truck_mandi/src/configs/utils.dart';
// import 'package:truck_mandi/src/features/auth/login/view/login_view_with_number.dart';
// import 'package:truck_mandi/src/features/splash/view_model/local_provider.dart';
// import '../services/splash/splash_services.dart';

// class SelectLanguageScreen extends StatefulWidget {
//   final bool fromProfileScreen;
//   const SelectLanguageScreen({super.key, this.fromProfileScreen = false});

//   @override
//   State<SelectLanguageScreen> createState() => _SelectLanguageScreenState();
// }

// class _SelectLanguageScreenState extends State<SelectLanguageScreen> {
//   SplashServices splashServices = SplashServices();
//   String? selectedLanguage;

//   @override
//   Widget build(BuildContext context) {
//     final localization = AppLocalizations.of(context)!;
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             ListView(
//               shrinkWrap: true,
//               padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
//               children: [
//                 SizedBox(height: context.mediaQueryHeight / 10),

//                 Image.asset(
//                   'assets/images/splash.png',
//                   height: context.mediaQueryHeight / 5,
//                 ),
//                 SizedBox(height: context.mediaQueryHeight / 10),

//                 Text(
//                   'Chose Language',
//                   // localization.welcome_title,
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: context.mediaQueryHeight / 80),

//                 Text(
//                   'We will show the content in your preferred language.',
//                   style: TextStyle(fontWeight: FontWeight.w400),
//                 ),
//                 SizedBox(height: context.mediaQueryHeight / 30),
//                 // Language Dropdown
//                 InlineDropdown<String>(
//                   expandedHeight: context.mediaQueryHeight / 9,
//                   hintText: localization.select_language,
//                   leadingSVG: 'assets/svg/language.svg',
//                   items: ['English', 'Urdu'],
//                   selectedItem: selectedLanguage,
//                   onChanged: (value) {
//                     setState(() {
//                       selectedLanguage = value;
//                     });
//                   },
//                   itemLabelBuilder: (item) => item,
//                 ),
//               ],
//             ),
//             Column(
//               children: [
//                 RoundButton(
//                   title: 'Next',
//                   onPress: () {
//                     if (selectedLanguage == null) {
//                       Utils.snackBar('Please select a language', context);
//                     } else {
//                       Locale locale = selectedLanguage == 'Urdu'
//                           ? const Locale('ur')
//                           : const Locale('en');
//                       // Update LocaleProvider
//                       Provider.of<LocaleProvider>(
//                         context,
//                         listen: false,
//                       ).setLocale(locale);
//                       if (widget.fromProfileScreen) {
//                         Navigator.pop(context);
//                       } else {
//                         MyNavigationService.push(LoginViewWithNumber());
//                       }
//                     }
//                   },
//                   color: selectedLanguage != null
//                       ? AppColors.primaryColor
//                       : Colors.grey,
//                 ),
//                 SizedBox(height: context.mediaQueryHeight / 21),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
