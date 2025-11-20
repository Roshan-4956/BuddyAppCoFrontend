/// Model for individual occupation from GET /static/occupations
class OccupationModel {
  final int occupationId;
  final String name;
  final String category;

  OccupationModel({
    required this.occupationId,
    required this.name,
    required this.category,
  });

  factory OccupationModel.fromJson(Map<String, dynamic> json) {
    return OccupationModel(
      occupationId: json['occupation_id'] as int,
      name: json['name'] as String,
      category: json['category'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'occupation_id': occupationId, 'name': name, 'category': category};
  }
}

/// Response model for GET /static/occupations endpoint
class OccupationsResponseModel {
  final List<OccupationModel> occupations;

  OccupationsResponseModel({required this.occupations});

  factory OccupationsResponseModel.fromJson(Map<String, dynamic> json) {
    return OccupationsResponseModel(
      occupations: (json['occupations'] as List)
          .map((item) => OccupationModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'occupations': occupations.map((item) => item.toJson()).toList()};
  }
}
