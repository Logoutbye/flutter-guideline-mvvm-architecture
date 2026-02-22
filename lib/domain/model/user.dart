import 'package:truck_mandi/domain/model/favorite.dart';

class User {
  final String? id;
  final String? token;
  final String? fullname;
  final String? profileImage;
  final String phone;
  final String? googleId;
  final String? appleId;
  final String? email;
  final String? password;
  final String accountMode;
  final String? shopCategory;
  final String? shopName;
  final String? shopAddress;
  final String role;
  final String? country;
  final String? city;

  final bool otpVerification;
  final bool isBlocked;
  final bool verificationDocuments;
  final String accountVerificationStatus;

  final String? idCardFrontImage;
  final String? idCardBackImage;
  final String? shopImage;

  final List<Favorite> favorites;

  final String? fcmToken;
  final DateTime? lastSeen;
  final bool isOnline;

  final int loginAttempts;
  final DateTime? lockUntil;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    this.id,
    this.token,
    this.fullname,
    this.profileImage,
    required this.phone,
    this.googleId,
    this.appleId,
    this.email,
    this.password,
    required this.accountMode,
    this.shopCategory,
    this.shopName,
    this.shopAddress,
    required this.role,
    this.country,
    this.city,
    required this.otpVerification,
    required this.isBlocked,
    required this.verificationDocuments,
    required this.accountVerificationStatus,
    this.idCardFrontImage,
    this.idCardBackImage,
    this.shopImage,
    required this.favorites,
    this.fcmToken,
    this.lastSeen,
    required this.isOnline,
    required this.loginAttempts,
    this.lockUntil,
    this.createdAt,
    this.updatedAt,
  });

  // ------------------ FROM JSON ------------------
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      token: json['token'],
      fullname: json['fullname'],
      profileImage: json['profileImage'],
      phone: json['phone'] ?? '',
      googleId: json['googleId'],
      appleId: json['appleId'],
      email: json['email'],
      password: json['password'],
      accountMode: json['accountMode'] ?? 'individual',
      shopCategory: json['shopCategory'],
      shopName: json['shopName'],
      shopAddress: json['shopAddress'],
      role: json['role'] ?? 'seller',
      country: json['country'],
      city: json['city'],
      otpVerification: json['otpVerification'] ?? false,
      isBlocked: json['isBlocked'] ?? false,
      verificationDocuments: json['verificationDocuments'] ?? false,
      accountVerificationStatus:
          json['accountVerificationStatus'] ?? 'not_requested',
      idCardFrontImage: json['idCardFrontImage'],
      idCardBackImage: json['idCardBackImage'],
      shopImage: json['shopImage'],
      favorites:
          (json['favorites'] as List<dynamic>?)
              ?.map((e) => Favorite.fromJson(e))
              .toList() ??
          [],
      fcmToken: json['fcmToken'],
      lastSeen: json['last_seen'] != null
          ? DateTime.parse(json['last_seen'])
          : null,
      isOnline: json['is_online'] ?? false,
      loginAttempts: json['loginAttempts'] ?? 0,
      lockUntil: json['lockUntil'] != null
          ? DateTime.parse(json['lockUntil'])
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }

  // ------------------ TO JSON ------------------
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'token': token,
      'fullname': fullname,
      'profileImage': profileImage,
      'phone': phone,
      'googleId': googleId,
      'appleId': appleId,
      'email': email,
      'password': password,
      'accountMode': accountMode,
      'shopCategory': shopCategory,
      'shopName': shopName,
      'shopAddress': shopAddress,
      'role': role,
      'country': country,
      'city': city,
      'otpVerification': otpVerification,
      'isBlocked': isBlocked,
      'verificationDocuments': verificationDocuments,
      'accountVerificationStatus': accountVerificationStatus,
      'idCardFrontImage': idCardFrontImage,
      'idCardBackImage': idCardBackImage,
      'shopImage': shopImage,
      'favorites': favorites.map((e) => e.toJson()).toList(),
      'fcmToken': fcmToken,
      'last_seen': lastSeen?.toIso8601String(),
      'is_online': isOnline,
      'loginAttempts': loginAttempts,
      'lockUntil': lockUntil?.toIso8601String(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
