import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truck_mandi/ui/core/components/round_button.dart';
import 'package:truck_mandi/configs/utils/utils.dart';
import 'package:truck_mandi/ui/features/auth/login/view_model/login_view_model.dart';
import 'package:truck_mandi/ui/features/auth/update_n_forgot_password/view_model/forget_password_view_model.dart';
import '../../../../../configs/utils/extensions.dart';
import '../../../../core/theme/theme_text.dart';
import '../../../../core/components/custom_text_filed.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

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
           
            appBar: AppBar(
              leading: Icon(Icons.adaptive.arrow_back),
              title: Text('Already have an account'),
            ),
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
                            'Reset You\'re Password',
                            style: Themetext.headline.copyWith(fontSize: 21),
                          ),
                          SizedBox(height: context.mediaQueryHeight / 80),
                          Text(
                            'Please conform your email address and we will send a verification code.',
                          ),
                        ],
                      ),
                      SizedBox(height: context.mediaQueryHeight / 20),
                      CustomTextFormField(
                        hintText: 'Enter your email',
                        controller: _emailController,
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
                            title: 'Send Code',
                            onPress: () {
                              if (_emailController.text.isEmpty) {
                                Utils.flushBarErrorMessage(
                                  'Please enter your email',
                                  context,
                                );
                              } else {
                                provider.forgotPassword(
                                  context,
                                  _emailController.text,
                                );
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
