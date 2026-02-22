import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truck_mandi/ui/core/theme/color.dart';
import 'package:truck_mandi/ui/core/components/round_button.dart';
import 'package:truck_mandi/configs/routing/my_navigation_service.dart';
import 'package:truck_mandi/configs/utils/utils.dart';
import 'package:truck_mandi/ui/core/theme/theme_text.dart';
import 'package:truck_mandi/ui/features/auth/login/view_model/login_view_model.dart';
import 'package:truck_mandi/ui/features/auth/signup/view/signup_view_with_email.dart';
import 'package:truck_mandi/ui/features/auth/update_n_forgot_password/view/forgot_password_screen.dart';
import '../../../../../configs/utils/extensions.dart';
import '../../../../core/components/custom_text_filed.dart';

class LoginViewWithEmail extends StatefulWidget {
  const LoginViewWithEmail({super.key});

  @override
  State<LoginViewWithEmail> createState() => _LoginViewWithEmailState();
}

class _LoginViewWithEmailState extends State<LoginViewWithEmail> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(),
      child: Consumer<LoginViewModel>(
        builder: (context, loginViewModel, _) {
          return Scaffold(
            resizeToAvoidBottomInset: false,

            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  ListView(
                    shrinkWrap: true,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sign In',
                            style: Themetext.headline.copyWith(
                              color: AppColors.primary,
                              fontSize: 21,
                            ),
                          ),
                          SizedBox(height: context.mediaQueryHeight / 80),
                          Text('Don’t have an account Create You\'re Account'),
                        ],
                      ),
                      SizedBox(height: context.mediaQueryHeight / 20),

                      CustomTextFormField(
                        hintText: 'Enter your email',
                        controller: _emailController,
                      ),
                      SizedBox(height: context.mediaQueryHeight / 30),
                      CustomTextFormField(
                        hintText: 'Enter your password',
                        controller: _passwordController,
                      ),
                      SizedBox(height: context.mediaQueryHeight / 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(),
                          RoundButton(
                            width: context.mediaQueryWidth / 2.5,
                            textStyle: TextStyle(
                              color: AppColors.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            color: AppColors.greyColor,
                            title: 'Forgot password?',
                            onPress: () {
                              MyNavigationService.push(ForgetPasswordScreen());
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  // need gap here that
                  Consumer<LoginViewModel>(
                    builder:
                        (
                          BuildContext context,
                          LoginViewModel provider,
                          Widget? child,
                        ) {
                          return RoundButton(
                            loading: provider.loading ? true : false,
                            title: 'Login',
                            onPress: () {
                              if (_emailController.text.isEmpty) {
                                Utils.flushBarErrorMessage(
                                  'Please enter your email',
                                  context,
                                );
                              } else if (_passwordController.text.isEmpty) {
                                Utils.flushBarErrorMessage(
                                  'Please enter your password',
                                  context,
                                );
                              } else {
                                Map data = {
                                  'email': _emailController.text.trim(),
                                  'password': _passwordController.text.trim(),
                                };
                                provider.signinWithEmail(context, data);
                              }
                            },
                          );
                        },
                  ),
                  SizedBox(height: context.mediaQueryHeight / 30),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have account',
                        style: Themetext.subheadline.copyWith(fontSize: 16),
                      ),
                      InkWell(
                        onTap: () {
                          MyNavigationService.push(SignUpViewWithEmail());
                        },
                        child: Text(
                          ' Sign Up',
                          style: Themetext.blackBoldText.copyWith(
                            color: AppColors.primary,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
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
