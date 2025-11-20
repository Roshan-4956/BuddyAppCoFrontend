/// Model for individual state from GET /static/states
class StateModel {
  final int stateId;
  final String name;
  final String country;

  StateModel({
    required this.stateId,
    required this.name,
    required this.country,
  });

  factory StateModel.fromJson(Map<String, dynamic> json) {
    return StateModel(
      stateId: json['state_id'] as int,
      name: json['name'] as String,
      country: json['country'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'state_id': stateId, 'name': name, 'country': country};
  }
}

/// Response model for GET /static/states endpoint
class StatesResponseModel {
  final List<StateModel> states;

  StatesResponseModel({required this.states});

  factory StatesResponseModel.fromJson(Map<String, dynamic> json) {
    return StatesResponseModel(
      states: (json['states'] as List)
          .map((item) => StateModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'states': states.map((item) => item.toJson()).toList()};
  }
}
