// This model represents the structure of data received from the API Call 1.
// It includes JSON parsing logic used in the repository.
class ApiCall1Model {
  final String name;
  final String email;

  ApiCall1Model({required this.name, required this.email});

  // Factory constructor to create an instance from JSON data.
  factory ApiCall1Model.fromJson(Map<String, dynamic> json) {
    return ApiCall1Model(
      name: json['name'], // Extracts 'name' from JSON.
      email: json['email'], // Extracts 'email' from JSON.
    );
  }
}
