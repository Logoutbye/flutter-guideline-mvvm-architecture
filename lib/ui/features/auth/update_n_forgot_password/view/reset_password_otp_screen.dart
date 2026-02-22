// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:truck_mandi/ui/core/theme/color.dart';
import 'package:truck_mandi/configs/utils/extensions.dart';
import 'package:truck_mandi/ui/core/theme/theme_text.dart';
import 'package:truck_mandi/ui/features/auth/update_n_forgot_password/view_model/forget_password_view_model.dart';

class ResetPasswordVerifyOtpScreen extends StatefulWidget {
  final String email;
  const ResetPasswordVerifyOtpScreen({super.key, required this.email});

  @override
  State<ResetPasswordVerifyOtpScreen> createState() =>
      _ResetPasswordVerifyOtpScreenState();
}

class _ResetPasswordVerifyOtpScreenState
    extends State<ResetPasswordVerifyOtpScreen> {
  final TextEditingController _controller = TextEditingController();

  int _start = 30; // Initial timer in seconds
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _start = 30;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        timer.cancel();
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();

    _controller.dispose();

    super.dispose();
  }

  Widget _buildOTPField() {
    return Pinput(
      controller: _controller,
      length: 6,
      focusNode: FocusNode(),
      closeKeyboardWhenCompleted: true,
      onCompleted: (pin) async {
        await context.read<ForgetPasswordViewModel>().verifyOtp(
          context,
          widget.email,
          pin,
        );
      },
      onChanged: (pin) {
        // Handle OTP change here if needed
      },
      defaultPinTheme: PinTheme(
        width: 45,
        height: 55,
        textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.adaptive.arrow_back),
        title: Text('Verify your number'),
      ),

      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 18),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: context.mediaQueryHeight / 16),
              Text('Enter Otp', style: Themetext.headline),
              SizedBox(height: context.mediaQueryHeight / 80),
              Text.rich(
                TextSpan(
                  text: "Please enter the six (6) digit code sent to ",
                  children: [
                    TextSpan(
                      text: widget.email,
                      style: Themetext.blackBoldText.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: " and continue that was sent to your Phone Number.",
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Wrong number?',
              style: TextStyle(color: Colors.teal),
            ),
          ),
          const SizedBox(height: 30),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [_buildOTPField()],
          ),
          const SizedBox(height: 30),
          if (_start > 0)
            Text(
              'You can Request a new OTP after $_start seconds',
              style: Themetext.textTheme.bodyMedium?.copyWith(fontSize: 15),
            )
          else
            TextButton(
              onPressed: () async {
                _startTimer();

                await context.read<ForgetPasswordViewModel>().forgotPassword(
                  context,
                  widget.email,
                );
                setState(() {});
              },
              child: const Text(
                'Resend Code',
                style: TextStyle(color: AppColors.primary),
              ),
            ),
        ],
      ),
    );
  }
}
