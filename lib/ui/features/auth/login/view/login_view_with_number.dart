// import 'package:flutter/material.dart';
// import 'package:truck_mandi/l10n/app_localizations.dart';

// import 'package:provider/provider.dart';

// import 'package:truck_mandi/ui/core/theme/color.dart';
// import 'package:truck_mandi/ui/core/components/round_button.dart';
// import 'package:truck_mandi/configs/routing/my_navigation_service.dart';
// import 'package:truck_mandi/configs/routing/slide_transition_page.dart';
// import 'package:truck_mandi/configs/utils/utils.dart';
// import 'package:truck_mandi/ui/features/auth/login/view_model/login_view_model.dart';
// import 'package:truck_mandi/ui/features/auth/widgets/country_picker_textfiled.dart';
// import 'package:truck_mandi/ui/core/components/custom_appbar.dart';
// import '../../../../../configs/utils/extensions.dart';
// import '../../../../core/theme/theme_text.dart';
// import 'login_view_with_email.dart';

// class LoginViewWithNumber extends StatefulWidget {
//   const LoginViewWithNumber({super.key});

//   @override
//   State<LoginViewWithNumber> createState() => _LoginViewWithNumberState();
// }

// class _LoginViewWithNumberState extends State<LoginViewWithNumber> {
//   final TextEditingController _controller = TextEditingController();

//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final localization = AppLocalizations.of(context)!;

//     return ChangeNotifierProvider(
//       create: (_) => LoginViewModel(),
//       child: Consumer<LoginViewModel>(
//         builder: (context, loginViewModel, _) {
//           return Scaffold(
//             appBar: CustomAppBar(
//               firstText: localization.signin_second,
//               secondText: localization.signin_first,
//               isSecondTextBeforeFirst: true,
//             ),
//             body: Padding(
//               padding: const EdgeInsets.all(20),
//               child: ListView(
//                 children: [
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         localization.safely_connect,
//                         style: Themetext.headline,
//                       ),
//                       SizedBox(height: context.mediaQueryHeight / 80),
//                       Text(localization.connect_message),
//                     ],
//                   ),
//                   SizedBox(height: context.mediaQueryHeight / 20),
//                   CountryPickerTextFormField(
//                     hintText: "Enter your phone number",
//                     controller: _controller,
//                     onCountrySelected: (country) {
//                       loginViewModel.setSelectedCountry(country!);
//                     },
//                     onPhoneNumberChanged: (phone) {
//                       loginViewModel.setPhonenuber(phone);
//                     },
//                   ),
//                   SizedBox(height: context.mediaQueryHeight / 30),
//                   RoundButton(
//                     loading: loginViewModel.loading,
//                     title: localization.continue_mobile,
//                     textStyle: Themetext.subheadline.copyWith(
//                       fontWeight: FontWeight.w600,
//                       color: loginViewModel.phoneNumber.isEmpty
//                           ? Colors.black
//                           : Colors.white,
//                     ),
//                     onPress: () async {
//                       if (loginViewModel.selectedCountry == null) {
//                         Utils.flushBarErrorMessage(
//                           'Please select your country',
//                           context,
//                         );
//                       } else if (loginViewModel.phoneNumber.isEmpty) {
//                         Utils.flushBarErrorMessage(
//                           'Please enter your phone number',
//                           context,
//                         );
//                       } else {
//                         await loginViewModel.sendPhoneOtp(context);
//                       }
//                     },
//                     color: loginViewModel.phoneNumber.isEmpty
//                         ? AppColors.greyColor
//                         : AppColors.primaryColor,
//                   ),
//                   SizedBox(height: context.mediaQueryHeight / 20),
//                   const Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 10),
//                     child: Row(
//                       children: [
//                         Expanded(child: Divider(color: Colors.grey)),
//                         SizedBox(width: 10),
//                         Text('Or'),
//                         SizedBox(width: 10),
//                         Expanded(child: Divider(color: Colors.grey)),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: context.mediaQueryHeight / 20),
//                   RoundButton(
//                     icon: Image.asset('assets/images/google.png'),
//                     title: localization.continue_google,
//                     textStyle: Themetext.subheadline.copyWith(
//                       fontWeight: FontWeight.w600,
//                     ),
//                     onPress: () {},
//                     color: AppColors.whiteColor,
//                     borderColor: Colors.grey.shade300,
//                   ),
//                   SizedBox(height: context.mediaQueryHeight / 40),
//                   RoundButton(
//                     icon: Image.asset('assets/images/sms.png'),
//                     title: localization.continue_email,
//                     textStyle: Themetext.subheadline.copyWith(
//                       fontWeight: FontWeight.w600,
//                     ),
//                     onPress: () {
//                       Navigator.push(
//                         context,
//                         SlideTransitionPage(page: LoginViewWithEmail()),
//                       );
//                     },
//                     color: AppColors.whiteColor,
//                     borderColor: Colors.grey.shade300,
//                   ),
//                   // SizedBox(height: context.mediaQueryHeight / 10),
//                   // RoundButton(
//                   //   title: localization.next_button,
//                   //   onPress: () {},
//                   // ),
//                   // SizedBox(height: context.mediaQueryHeight / 30),
//                 ],
//               ),
//             ),
//             bottomSheet: Padding(
//               padding: const EdgeInsets.only(bottom: 38.0),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     localization.dont_have_account,
//                     style: Themetext.subheadline.copyWith(fontSize: 16),
//                   ),
//                   InkWell(
//                     onTap: () {
//                       MyNavigationService.pushAndRemoveAll(
//                         LoginViewWithNumber(),
//                       );
//                     },
//                     child: Text(
//                       ' ${localization.signup_text}',
//                       style: Themetext.blackBoldText.copyWith(
//                         color: AppColors.primaryColor,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
