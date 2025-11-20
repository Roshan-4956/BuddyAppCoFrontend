/// Model for individual gender from GET /static/genders
class GenderModel {
  final int genderId;
  final String name;

  GenderModel({required this.genderId, required this.name});

  factory GenderModel.fromJson(Map<String, dynamic> json) {
    return GenderModel(
      genderId: json['gender_id'] as int,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'gender_id': genderId, 'name': name};
  }
}

/// Response model for GET /static/genders endpoint
class GendersResponseModel {
  final List<GenderModel> genders;

  GendersResponseModel({required this.genders});

  factory GendersResponseModel.fromJson(Map<String, dynamic> json) {
    return GendersResponseModel(
      genders: (json['genders'] as List)
          .map((item) => GenderModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'genders': genders.map((item) => item.toJson()).toList()};
  }
}
