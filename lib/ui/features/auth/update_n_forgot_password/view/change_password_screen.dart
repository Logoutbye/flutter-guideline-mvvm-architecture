import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truck_mandi/ui/core/components/round_button.dart';
import 'package:truck_mandi/configs/routing/slide_transition_page.dart';
import 'package:truck_mandi/configs/utils/utils.dart';
import 'package:truck_mandi/ui/features/auth/login/view/login_view_with_email.dart';
import 'package:truck_mandi/ui/features/auth/login/view_model/login_view_model.dart';
import 'package:truck_mandi/ui/features/auth/update_n_forgot_password/view_model/forget_password_view_model.dart';
import '../../../../../configs/utils/extensions.dart';
import '../../../../core/theme/theme_text.dart';
import '../../../../core/components/custom_text_filed.dart';

// ignore: must_be_immutable
class ChangePasswordScreen extends StatefulWidget {
  String verificationCode;
  String email;

  ChangePasswordScreen({
    super.key,
    required this.email,
    required this.verificationCode,
  });

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _cnfirmPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _cnfirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(),
      child: Consumer<LoginViewModel>(
        builder: (context, loginViewModel, _) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  ListView(
                    shrinkWrap: true,
                    children: [
                      Text(
                        'Change Your Password',
                        style: Themetext.headline.copyWith(fontSize: 21),
                      ),
                      SizedBox(height: context.mediaQueryHeight / 40),
                      CustomTextFormField(
                        hintText: 'Enter your password',
                        controller: _newPasswordController,
                      ),
                      SizedBox(height: context.mediaQueryHeight / 40),
                      CustomTextFormField(
                        hintText: 'Confrim your password',
                        controller: _cnfirmPasswordController,
                      ),
                    ],
                  ),
                  Spacer(),
                  // need gap here that
                  Consumer<ForgetPasswordViewModel>(
                    builder:
                        (
                          BuildContext context,
                          ForgetPasswordViewModel provider,
                          Widget? child,
                        ) {
                          return RoundButton(
                            loading: provider.loading ? true : false,
                            title: 'Continue',
                            onPress: () {
                              if (_newPasswordController.text.isEmpty) {
                                Utils.flushBarErrorMessage(
                                  'Please enter new password',
                                  context,
                                );
                              } else if (_cnfirmPasswordController
                                  .text
                                  .isEmpty) {
                                Utils.flushBarErrorMessage(
                                  'Please enter password again',
                                  context,
                                );
                              } else if (_cnfirmPasswordController.text !=
                                  _newPasswordController.text) {
                                Utils.flushBarErrorMessage(
                                  'Password do not match',
                                  context,
                                );
                              } else {
                                Map data = {
                                  //  email, verificationCode, newPassword
                                  'verificationCode': widget.verificationCode,
                                  'email': widget.email,
                                  'newPassword': _cnfirmPasswordController.text
                                      .trim(),
                                };
                                provider
                                    .resetPassword(context, data)
                                    .then((value) {
                                      Navigator.push(
                                        context,
                                        SlideTransitionPage(
                                          page: LoginViewWithEmail(),
                                        ),
                                      );
                                    })
                                    .onError((error, stackTrace) {
                                      Utils.flushBarErrorMessage(
                                        error.toString(),
                                        context,
                                      );
                                    });
                              }
                            },
                          );
                        },
                  ),
                  SizedBox(height: context.mediaQueryHeight / 30),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
