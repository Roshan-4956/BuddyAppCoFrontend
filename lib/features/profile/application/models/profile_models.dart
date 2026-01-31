enum ProfileSection { about, relocationQna, recommendations }

extension ProfileSectionX on ProfileSection {
  String get apiValue {
    switch (this) {
      case ProfileSection.about:
        return 'ABOUT';
      case ProfileSection.relocationQna:
        return 'RELOCATION_QNA';
      case ProfileSection.recommendations:
        return 'RECOMMENDATIONS';
    }
  }

  static ProfileSection fromApi(String value) {
    switch (value) {
      case 'RELOCATION_QNA':
        return ProfileSection.relocationQna;
      case 'RECOMMENDATIONS':
        return ProfileSection.recommendations;
      case 'ABOUT':
      default:
        return ProfileSection.about;
    }
  }
}

class ProfileQuestionModel {
  final int id;
  final ProfileSection section;
  final String questionText;
  final String? placeholderText;
  final String? category;
  final int displayOrder;
  final bool isEnabled;

  ProfileQuestionModel({
    required this.id,
    required this.section,
    required this.questionText,
    this.placeholderText,
    this.category,
    required this.displayOrder,
    required this.isEnabled,
  });

  factory ProfileQuestionModel.fromJson(Map<String, dynamic> json) {
    return ProfileQuestionModel(
      id: json['id'] as int,
      section: ProfileSectionX.fromApi(json['section'] as String),
      questionText: json['question_text'] as String,
      placeholderText: json['placeholder_text'] as String?,
      category: json['category'] as String?,
      displayOrder: json['display_order'] as int? ?? 0,
      isEnabled: json['is_enabled'] as bool? ?? true,
    );
  }
}

class ProfileQuestionsResponseModel {
  final List<ProfileQuestionModel> questions;
  final ProfileSection section;
  final int total;

  ProfileQuestionsResponseModel({
    required this.questions,
    required this.section,
    required this.total,
  });

  factory ProfileQuestionsResponseModel.fromJson(Map<String, dynamic> json) {
    return ProfileQuestionsResponseModel(
      questions: (json['questions'] as List<dynamic>)
          .map(
            (item) =>
                ProfileQuestionModel.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
      section: ProfileSectionX.fromApi(json['section'] as String),
      total: json['total'] as int? ?? 0,
    );
  }
}

class ProfileAnswerModel {
  final String id;
  final String userId;
  final int questionId;
  final String answerText;
  final bool isPinned;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProfileAnswerModel({
    required this.id,
    required this.userId,
    required this.questionId,
    required this.answerText,
    required this.isPinned,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProfileAnswerModel.fromJson(Map<String, dynamic> json) {
    return ProfileAnswerModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      questionId: json['question_id'] as int,
      answerText: json['answer_text'] as String,
      isPinned: json['is_pinned'] as bool? ?? false,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }
}

class ProfileAnswersResponseModel {
  final List<ProfileAnswerModel> answers;
  final int total;

  ProfileAnswersResponseModel({required this.answers, required this.total});

  factory ProfileAnswersResponseModel.fromJson(Map<String, dynamic> json) {
    return ProfileAnswersResponseModel(
      answers: (json['answers'] as List<dynamic>)
          .map(
            (item) => ProfileAnswerModel.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
      total: json['total'] as int? ?? 0,
    );
  }
}

class ProfileCompletionModel {
  final double completionPercentage;
  final List<String> missingFields;
  final int answersCount;
  final int pinnedAnswersCount;
  final bool isComplete;

  ProfileCompletionModel({
    required this.completionPercentage,
    required this.missingFields,
    required this.answersCount,
    required this.pinnedAnswersCount,
    required this.isComplete,
  });

  factory ProfileCompletionModel.fromJson(Map<String, dynamic> json) {
    return ProfileCompletionModel(
      completionPercentage: (json['completion_percentage'] as num).toDouble(),
      missingFields:
          (json['missing_fields'] as List<dynamic>?)
              ?.map((item) => item.toString())
              .toList() ??
          [],
      answersCount: json['answers_count'] as int? ?? 0,
      pinnedAnswersCount: json['pinned_answers_count'] as int? ?? 0,
      isComplete: json['is_complete'] as bool? ?? false,
    );
  }
}

class ProfileAnswerWithQuestionModel {
  final String id;
  final int questionId;
  final String? questionText;
  final String answerText;
  final bool isPinned;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProfileAnswerWithQuestionModel({
    required this.id,
    required this.questionId,
    required this.questionText,
    required this.answerText,
    required this.isPinned,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProfileAnswerWithQuestionModel.fromJson(Map<String, dynamic> json) {
    return ProfileAnswerWithQuestionModel(
      id: json['id'] as String,
      questionId: json['question_id'] as int,
      questionText: json['question_text'] as String?,
      answerText: json['answer_text'] as String,
      isPinned: json['is_pinned'] as bool? ?? false,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }
}

class ProfileStateModel {
  final int stateId;
  final String name;
  final String country;

  ProfileStateModel({
    required this.stateId,
    required this.name,
    required this.country,
  });

  factory ProfileStateModel.fromJson(Map<String, dynamic> json) {
    return ProfileStateModel(
      stateId: json['state_id'] as int,
      name: json['name'] as String,
      country: json['country'] as String,
    );
  }
}

class ProfileCityModel {
  final int cityId;
  final String name;
  final int stateId;

  ProfileCityModel({
    required this.cityId,
    required this.name,
    required this.stateId,
  });

  factory ProfileCityModel.fromJson(Map<String, dynamic> json) {
    return ProfileCityModel(
      cityId: json['city_id'] as int,
      name: json['name'] as String,
      stateId: json['state_id'] as int,
    );
  }
}

class ProfileOccupationModel {
  final int occupationId;
  final String name;
  final String category;

  ProfileOccupationModel({
    required this.occupationId,
    required this.name,
    required this.category,
  });

  factory ProfileOccupationModel.fromJson(Map<String, dynamic> json) {
    return ProfileOccupationModel(
      occupationId: json['occupation_id'] as int,
      name: json['name'] as String,
      category: json['category'] as String,
    );
  }
}

class ProfileGenderModel {
  final int genderId;
  final String name;

  ProfileGenderModel({required this.genderId, required this.name});

  factory ProfileGenderModel.fromJson(Map<String, dynamic> json) {
    return ProfileGenderModel(
      genderId: json['gender_id'] as int,
      name: json['name'] as String,
    );
  }
}

class ProfileInterestModel {
  final int interestId;
  final String name;
  final int iconId;
  final String? iconUrl;

  ProfileInterestModel({
    required this.interestId,
    required this.name,
    required this.iconId,
    this.iconUrl,
  });

  factory ProfileInterestModel.fromJson(Map<String, dynamic> json) {
    return ProfileInterestModel(
      interestId: json['interest_id'] as int,
      name: json['name'] as String,
      iconId: json['icon_id'] as int? ?? 0,
      iconUrl: json['icon_url'] as String?,
    );
  }
}

class ProfileViewModel {
  final String userId;
  final String firstName;
  final String lastName;
  final DateTime dateOfBirth;
  final String address;
  final String? profilePhotoUrl;
  final int profileCompletionPercentage;
  final ProfileStateModel state;
  final ProfileCityModel city;
  final ProfileOccupationModel occupation;
  final ProfileGenderModel gender;
  final List<ProfileInterestModel> interests;
  final List<ProfileAnswerWithQuestionModel> answers;

  ProfileViewModel({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.address,
    required this.profilePhotoUrl,
    required this.profileCompletionPercentage,
    required this.state,
    required this.city,
    required this.occupation,
    required this.gender,
    required this.interests,
    required this.answers,
  });

  factory ProfileViewModel.fromJson(Map<String, dynamic> json) {
    return ProfileViewModel(
      userId: json['user_id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      dateOfBirth: DateTime.parse(json['date_of_birth'] as String),
      address: json['address'] as String,
      profilePhotoUrl: json['profile_photo_url'] as String?,
      profileCompletionPercentage:
          json['profile_completion_percentage'] as int? ?? 0,
      state: ProfileStateModel.fromJson(json['state'] as Map<String, dynamic>),
      city: ProfileCityModel.fromJson(json['city'] as Map<String, dynamic>),
      occupation: ProfileOccupationModel.fromJson(
        json['occupation'] as Map<String, dynamic>,
      ),
      gender: ProfileGenderModel.fromJson(
        json['gender'] as Map<String, dynamic>,
      ),
      interests: (json['interests'] as List<dynamic>? ?? [])
          .map(
            (item) =>
                ProfileInterestModel.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
      answers: (json['answers'] as List<dynamic>? ?? [])
          .map(
            (item) => ProfileAnswerWithQuestionModel.fromJson(
              item as Map<String, dynamic>,
            ),
          )
          .toList(),
    );
  }
}

class BasicResponseModel {
  final bool isSuccess;
  final String message;

  BasicResponseModel({required this.isSuccess, required this.message});

  factory BasicResponseModel.fromJson(Map<String, dynamic> json) {
    return BasicResponseModel(
      isSuccess: json['is_success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
    );
  }
}
