/// Model for individual community from GET /onboarding/communities
class CommunityModel {
  final String communityId;
  final String name;
  final String description;
  final String? imageUrl;
  final int memberCount;
  final String location;
  final List<String> tags;

  CommunityModel({
    required this.communityId,
    required this.name,
    required this.description,
    this.imageUrl,
    required this.memberCount,
    required this.location,
    required this.tags,
  });

  factory CommunityModel.fromJson(Map<String, dynamic> json) {
    return CommunityModel(
      communityId: json['community_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['image_url'] as String?,
      memberCount: json['member_count'] as int,
      location: json['location'] as String,
      tags: (json['tags'] as List).map((tag) => tag as String).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'community_id': communityId,
      'name': name,
      'description': description,
      'image_url': imageUrl,
      'member_count': memberCount,
      'location': location,
      'tags': tags,
    };
  }
}

/// Response model for GET /onboarding/communities endpoint
class CommunitiesResponseModel {
  final List<CommunityModel> communities;

  CommunitiesResponseModel({required this.communities});

  factory CommunitiesResponseModel.fromJson(Map<String, dynamic> json) {
    return CommunitiesResponseModel(
      communities: (json['communities'] as List)
          .map((item) => CommunityModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'communities': communities.map((item) => item.toJson()).toList()};
  }
}
