import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:truck_mandi/ui/core/components/round_button.dart';
import 'package:truck_mandi/ui/core/theme/color.dart';
import 'package:truck_mandi/ui/features/my_profile/view/custom_text_filed.dart';
import 'package:truck_mandi/ui/features/my_profile/view_model/vehicle_ads_vm.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsViewRedesigned extends StatelessWidget {
  ContactUsViewRedesigned({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileNoController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyColor,
      body: CustomScrollView(
        slivers: [
          // Modern App Bar
          SliverAppBar(
            expandedHeight: 200.h,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.primary,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "Contact Us",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primary,
                      AppColors.primary.withOpacity(0.8),
                    ],
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 60.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.support_agent,
                          size: 60.sp,
                          color: Colors.white.withOpacity(0.3),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.greyColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24.h),

                    // Contact Form Card
                    _buildContactFormCard(context),

                    SizedBox(height: 24.h),

                    // Contact Information Card
                    _buildContactInfoCard(context),

                    SizedBox(height: 24.h),

                    // Social Media Card
                    _buildSocialMediaCard(context),

                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactFormCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.message_outlined,
                  color: AppColors.primary,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                'Send Us Message',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          _buildFormField(
            context,
            label: 'Full Name',
            hint: 'Enter Your Name',
            controller: nameController,
            icon: Icons.person_outline,
          ),
          SizedBox(height: 16.h),
          _buildFormField(
            context,
            label: 'Email Address',
            hint: 'Enter Email',
            controller: emailController,
            icon: Icons.email_outlined,
          ),
          SizedBox(height: 16.h),
          _buildFormField(
            context,
            label: 'Phone Number',
            hint: 'Enter PhoneNumber',
            controller: mobileNoController,
            icon: Icons.phone_outlined,
          ),
          SizedBox(height: 16.h),
          _buildFormField(
            context,
            label: 'Subject',
            hint: 'Manage Subject',
            controller: subjectController,
            icon: Icons.subject_outlined,
          ),
          SizedBox(height: 16.h),
          _buildFormField(
            context,
            label: 'Message',
            hint: 'Enter your Message Here',
            controller: messageController,
            icon: Icons.message_outlined,
            maxLines: 4,
          ),
          SizedBox(height: 24.h),
          RoundButton(
            height: 50.h,
            title: 'Submit',
            color: AppColors.primary,
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
            onPress: () => _submitForm(context),
          ),
        ],
      ),
    );
  }

  Widget _buildFormField(
    BuildContext context, {
    required String label,
    required String hint,
    required TextEditingController controller,
    required IconData icon,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18.sp, color: AppColors.primary),
            SizedBox(width: 8.w),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        CustomTextField(
          hintText: hint,
          controller: controller,
          minLines: maxLines,
          maxLines: maxLines,
          color: AppColors.greyColor,
          borderColor: Colors.transparent,
        ),
      ],
    );
  }

  Widget _buildContactInfoCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: AppColors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.info_outline,
                  color: AppColors.orange,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                'Contact Information',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          _buildContactDetail(
            context,
            icon: Icons.location_on_outlined,
            title: 'Address',
            value:
                "Saeed Allam Tower, 37-Commenical zone Liberty Market, Gulberg, Lahore, Pakistan.",
            color: AppColors.primary,
          ),
          SizedBox(height: 16.h),
          _buildContactDetail(
            context,
            icon: Icons.phone_outlined,
            title: 'Phone',
            value: '03055108452',
            color: AppColors.orange,
            onTap: () => _launchPhone('03055108452'),
          ),
          SizedBox(height: 16.h),
          _buildContactDetail(
            context,
            icon: Icons.chat_outlined,
            title: 'Whatsapp',
            value: '03055108452',
            color: Colors.green,
            onTap: () => _launchWhatsApp('03055108452'),
          ),
        ],
      ),
    );
  }

  Widget _buildContactDetail(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required Color color,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: color.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            if (onTap != null)
              Icon(Icons.arrow_forward_ios, size: 16.sp, color: color),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialMediaCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.share_outlined,
                  color: AppColors.primary,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                'Follow Us On',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          _buildSocialMediaItem(
            context,
            imagePath: 'assets/images/fb.png',
            title: "Follow us on Facebook",
            color: Color(0xFF1877F2),
            onTap: () => _launchURL(
              'https://www.facebook.com/share/1HitLSgFjq/?mibextid=wwXIfr',
            ),
          ),
          SizedBox(height: 12.h),
          _buildSocialMediaItem(
            context,
            imagePath: 'assets/images/insta.png',
            title: "Follow us on Instagram",
            color: Color(0xFFE4405F),
            onTap: () => _launchURL(
              'https://www.instagram.com/pakistanitruck1?igsh=MWZ4dGNycm5wN2I0MQ%3D%3D&utm_source=qr',
            ),
          ),
          SizedBox(height: 12.h),
          _buildSocialMediaItem(
            context,
            imagePath: 'assets/images/tiktok.png',
            title: "Follow us on TikTok",
            color: Colors.black,
            onTap: () => _launchURL(
              'https://www.tiktok.com/@pakistanitruck1?_t=ZS-8xzWijDaEeT&_r=1',
            ),
          ),
          SizedBox(height: 12.h),
          _buildSocialMediaItem(
            context,
            imagePath: 'assets/images/youtube.png',
            title: 'Subscribe us on Youtube"',
            color: Color(0xFFFF0000),
            onTap: () => _launchURL(
              'https://youtube.com/@pakistanitruckvlogs?si=Y9cpJWy551815qTT',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialMediaItem(
    BuildContext context, {
    required String imagePath,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: color.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: ClipOval(child: Image.asset(imagePath, fit: BoxFit.cover)),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16.sp, color: color),
          ],
        ),
      ),
    );
  }

  void _submitForm(BuildContext context) {
    if (mobileNoController.text.length != 11) {
      Fluttertoast.showToast(
        msg: 'Mobile number must be 11 digits',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }

    final data = {
      "fullname": nameController.text,
      "email": emailController.text,
      "mobileNumber": mobileNoController.text,
      "subject": subjectController.text,
      "message": messageController.text,
    };

    Provider.of<VehicleAdsVM>(context, listen: false)
        .submitContactRequest(data)
        .then((_) {
          Fluttertoast.showToast(
            msg: 'Contact request submitted successfully',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          nameController.clear();
          emailController.clear();
          mobileNoController.clear();
          subjectController.clear();
          messageController.clear();
        })
        .catchError((error) {
          Fluttertoast.showToast(
            msg: "Failed to submit contact request",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        });
  }

  void _launchPhone(String phone) async {
    final uri = Uri.parse('tel:$phone');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _launchWhatsApp(String phone) async {
    final uri = Uri.parse('https://wa.me/$phone');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
