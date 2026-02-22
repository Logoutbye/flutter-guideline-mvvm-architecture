import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truck_mandi/ui/core/theme/color.dart';
import 'package:truck_mandi/ui/core/components/round_button.dart';
import 'package:truck_mandi/configs/utils/utils.dart';
import '../../../../../configs/utils/extensions.dart';
import '../../../../core/theme/theme_text.dart';
import '../../../../core/components/custom_text_filed.dart';
import '../view_model/signup_viewmodel.dart';

class SignUpViewWithEmail extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  SignUpViewWithEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpViewModel>(
      builder: (context, signUpViewModel, _) {
        return Scaffold(
          appBar: AppBar(title: Text('Create an account')),
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
                          'Sign Up',
                          style: Themetext.headline.copyWith(
                            color: AppColors.primary,
                            fontSize: 21,
                          ),
                        ),
                        SizedBox(height: context.mediaQueryHeight / 80),
                        Text('Don’t have an account? Create your account'),
                      ],
                    ),
                    SizedBox(height: context.mediaQueryHeight / 20),
                    Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: context.mediaQueryHeight / 75),
                    CustomTextFormField(
                      maxLines: 1,
                      minLines: 1,
                      hintText: 'Enter your email',
                      controller: _emailController,
                    ),
                    SizedBox(height: context.mediaQueryHeight / 30),
                    Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: context.mediaQueryHeight / 75),
                    CustomTextFormField(
                      hintText: 'Enter Password',
                      controller: _otpController,
                    ),
                  ],
                ),
                Spacer(),
                RoundButton(
                  loading: signUpViewModel.loading,
                  title: 'Sign Up',
                  onPress: () {
                    // Send OTP
                    if (_emailController.text.isEmpty) {
                      Utils.flushBarErrorMessage(
                        'Please enter your email and password',
                        context,
                      );
                    } else {
                      final emailData = {
                        'email': _emailController.text,
                        'password': _otpController.text,
                      };
                      signUpViewModel.signupEmail(context, emailData);
                    }
                  },
                ),
                SizedBox(height: context.mediaQueryHeight / 30),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have Account',
                      style: Themetext.subheadline.copyWith(fontSize: 16),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        ' Sign In}',
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
    );
  }
}
