class FavoriteAdsModel {
  String id;
  List<String> images;
  List<String> videos;
  String category;
  String title;
  String subCategory;
  String location;
  int price;
  int modelYear;
  String registeredIn;
  String make;
  String engineType;
  String description;
  String localOrImported;
  String adType;
  String postedBy;
  String createdAt;
  int v;
  List<String> favorites;
  List<AdViewsModel> views;
  String condition;
  int callCount;
  int chatCount;
  bool sold;
  String status;
  String disapproveTitle;
  String disapproveDescription;

  FavoriteAdsModel({
    this.id = '',
    List<String>? images,
    List<String>? videos,
    this.category = '',
    this.title = '',
    this.subCategory = '',
    this.location = '',
    this.price = 0,
    this.modelYear = 0,
    this.registeredIn = '',
    this.make = '',
    this.engineType = '',
    this.description = '',
    this.localOrImported = '',
    this.adType = 'Vehicle',
    this.postedBy = '',
    this.createdAt = '',
    this.v = 0,
    List<String>? favorites,
    List<AdViewsModel>? views,
    this.condition = '',
    this.callCount = 0,
    this.chatCount = 0,
    this.sold = false,
    this.status = 'pending',
    this.disapproveTitle = '',
    this.disapproveDescription = '',
  }) : images = images ?? [],
       videos = videos ?? [],
       favorites = favorites ?? [],
       views = views ?? [];

  // -------------------- COPY WITH --------------------
  FavoriteAdsModel copyWith({
    String? id,
    List<String>? images,
    List<String>? videos,
    String? category,
    String? title,
    String? subCategory,
    String? location,
    int? price,
    int? modelYear,
    String? registeredIn,
    String? make,
    String? engineType,
    String? description,
    String? localOrImported,
    String? adType,
    String? postedBy,
    String? createdAt,
    int? v,
    List<String>? favorites,
    List<AdViewsModel>? views,
    String? condition,
    int? callCount,
    int? chatCount,
    bool? sold,
    String? status,
    String? disapproveTitle,
    String? disapproveDescription,
  }) {
    return FavoriteAdsModel(
      id: id ?? this.id,
      images: images ?? this.images,
      videos: videos ?? this.videos,
      category: category ?? this.category,
      title: title ?? this.title,
      subCategory: subCategory ?? this.subCategory,
      location: location ?? this.location,
      price: price ?? this.price,
      modelYear: modelYear ?? this.modelYear,
      registeredIn: registeredIn ?? this.registeredIn,
      make: make ?? this.make,
      engineType: engineType ?? this.engineType,
      description: description ?? this.description,
      localOrImported: localOrImported ?? this.localOrImported,
      adType: adType ?? this.adType,
      postedBy: postedBy ?? this.postedBy,
      createdAt: createdAt ?? this.createdAt,
      v: v ?? this.v,
      favorites: favorites ?? this.favorites,
      views: views ?? this.views,
      condition: condition ?? this.condition,
      callCount: callCount ?? this.callCount,
      chatCount: chatCount ?? this.chatCount,
      sold: sold ?? this.sold,
      status: status ?? this.status,
      disapproveTitle: disapproveTitle ?? this.disapproveTitle,
      disapproveDescription:
          disapproveDescription ?? this.disapproveDescription,
    );
  }

  // -------------------- FROM JSON --------------------
  factory FavoriteAdsModel.fromJson(Map<String, dynamic> json) {
    return FavoriteAdsModel(
      id: json['_id'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      videos: List<String>.from(json['videos'] ?? []),
      category: json['category'] ?? '',
      title: json['title'] ?? '',
      subCategory: json['subCategory'] ?? '',
      location: json['location'] ?? '',
      price: json['price'] ?? 0,
      modelYear: json['modelYear'] ?? 0,
      registeredIn: json['registeredIn'] ?? '',
      make: json['make'] ?? '',
      engineType: json['engineType'] ?? '',
      description: json['description'] ?? '',
      localOrImported: json['localOrImported'] ?? '',
      adType: json['adType'] ?? 'Vehicle',
      postedBy: json['postedBy'] ?? '',
      createdAt: json['createdAt']?.toString() ?? '',
      v: json['__v'] ?? 0,
      favorites: List<String>.from(json['favorites'] ?? []),
      views: json['views'] != null
          ? (json['views'] as List)
                .map((e) => AdViewsModel.fromJson(e))
                .toList()
          : [],
      condition: json['condition'] ?? '',
      callCount: json['callCount'] ?? 0,
      chatCount: json['chatCount'] ?? 0,
      sold: json['sold'] ?? false,
      status: json['status'] ?? 'pending',
      disapproveTitle: json['disapproveTitle'] ?? '',
      disapproveDescription: json['disapproveDescription'] ?? '',
    );
  }

  // -------------------- TO JSON --------------------
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'images': images,
      'videos': videos,
      'category': category,
      'title': title,
      'subCategory': subCategory,
      'location': location,
      'price': price,
      'modelYear': modelYear,
      'registeredIn': registeredIn,
      'make': make,
      'engineType': engineType,
      'description': description,
      'localOrImported': localOrImported,
      'adType': adType,
      'postedBy': postedBy,
      'createdAt': createdAt,
      '__v': v,
      'favorites': favorites,
      'views': views.map((e) => e.toJson()).toList(),
      'condition': condition,
      'callCount': callCount,
      'chatCount': chatCount,
      'sold': sold,
      'status': status,
      'disapproveTitle': disapproveTitle,
      'disapproveDescription': disapproveDescription,
    };
  }
}

class AdViewsModel {
  String userId;
  String timestamp;

  AdViewsModel({this.userId = '', this.timestamp = ''});

  factory AdViewsModel.fromJson(Map<String, dynamic> json) {
    return AdViewsModel(
      userId: json['userId'] ?? '',
      timestamp: json['timestamp']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'userId': userId, 'timestamp': timestamp};
  }
}
