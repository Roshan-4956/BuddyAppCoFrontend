/// Model for individual interest item from GET /onboarding/interests
class InterestModel {
  final String interestId;
  final String name;
  final String? iconUrl;
  final String category;

  InterestModel({
    required this.interestId,
    required this.name,
    this.iconUrl,
    required this.category,
  });

  factory InterestModel.fromJson(Map<String, dynamic> json) {
    return InterestModel(
      interestId: json['interest_id'] as String,
      name: json['name'] as String,
      iconUrl: json['icon_url'] as String?,
      category: json['category'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'interest_id': interestId,
      'name': name,
      'icon_url': iconUrl,
      'category': category,
    };
  }
}

/// Response model for GET /onboarding/interests endpoint
class InterestsResponseModel {
  final List<InterestModel> interests;

  InterestsResponseModel({required this.interests});

  factory InterestsResponseModel.fromJson(Map<String, dynamic> json) {
    return InterestsResponseModel(
      interests: (json['interests'] as List)
          .map((item) => InterestModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'interests': interests.map((item) => item.toJson()).toList()};
  }
}
