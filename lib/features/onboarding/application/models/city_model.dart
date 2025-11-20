/// Model for individual city from GET /static/cities
class CityModel {
  final int cityId;
  final String name;
  final int stateId;

  CityModel({required this.cityId, required this.name, required this.stateId});

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      cityId: json['city_id'] as int,
      name: json['name'] as String,
      stateId: json['state_id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {'city_id': cityId, 'name': name, 'state_id': stateId};
  }
}

/// Response model for GET /static/cities endpoint
class CitiesResponseModel {
  final List<CityModel> cities;

  CitiesResponseModel({required this.cities});

  factory CitiesResponseModel.fromJson(Map<String, dynamic> json) {
    return CitiesResponseModel(
      cities: (json['cities'] as List)
          .map((item) => CityModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'cities': cities.map((item) => item.toJson()).toList()};
  }
}
