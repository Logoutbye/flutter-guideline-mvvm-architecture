import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:truck_mandi/ui/core/theme/color.dart';
import 'package:truck_mandi/ui/core/components/round_button.dart';
import 'package:truck_mandi/configs/utils/extensions.dart';
import 'package:truck_mandi/configs/routing/my_navigation_service.dart';
import 'package:truck_mandi/ui/features/splash/view_model/session_controller.dart';

bool _isDialogShowing = false;

void showLoginRequiredDialog({required String reason}) {
  if (_isDialogShowing) return;
  _isDialogShowing = true;

  showGeneralDialog(
    context: MyNavigationService.navigatorKey.currentContext!,
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.4),
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      return GestureDetector(
        onTap: () {}, // prevents tap through
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
              child: Container(
                color: Colors.black.withOpacity(0), // Required for blur
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Login Required",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          // reason.isNotEmpty
                          //     ? reason
                          //     :
                          'To continue using this feature, you need to log in or create an account.',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RoundButton(
                              textStyle: TextStyle(
                                fontSize: 14,
                                color: AppColors.whiteColor,
                              ),
                              width: context.mediaQueryWidth / 2,
                              onPress: () {
                                SessionController().logout(context);
                                // MyNavigationService.pushAndRemoveAll(
                                //   // SplashView(),
                                // );
                                _isDialogShowing = false;
                              },
                              title: "Continue",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

void showAccountBannedDialog({required String reason}) {
  if (_isDialogShowing) return;
  _isDialogShowing = true;

  showGeneralDialog(
    context: MyNavigationService.navigatorKey.currentContext!,
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.4),
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      return GestureDetector(
        onTap: () {}, // prevents tap through
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
              child: Container(
                color: Colors.black.withOpacity(0), // Required for blur
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Wait a minute!",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          reason.isNotEmpty
                              ? reason
                              : 'Your account has been banned. Please contact support for assistance.',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RoundButton(
                              textStyle: TextStyle(
                                fontSize: 14,
                                color: AppColors.whiteColor,
                              ),
                              width: context.mediaQueryWidth / 2,
                              onPress: () {
                                SessionController().logout(context);

                                _isDialogShowing = false;
                              },
                              title: "Continue",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
