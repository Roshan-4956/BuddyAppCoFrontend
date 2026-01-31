import '../../../../utils/api/implementation/simple_api/simple_params.dart';
import '../models/profile_models.dart';

class ProfileQuestionsParams extends SimpleParameters {
  ProfileQuestionsParams(ProfileSection section) {
    queryParams['section'] = section.apiValue;
  }
}

class ProfileAnswerCreateParams extends SimpleParameters {
  void setAnswer({
    required int questionId,
    required String answerText,
    bool isPinned = false,
  }) {
    body = {
      'question_id': questionId,
      'answer_text': answerText,
      'is_pinned': isPinned,
    };
  }
}

class ProfileAnswerUpdateParams extends SimpleParameters {
  void setUpdate({String? answerText, bool? isPinned}) {
    final payload = <String, dynamic>{};
    if (answerText != null) {
      payload['answer_text'] = answerText;
    }
    if (isPinned != null) {
      payload['is_pinned'] = isPinned;
    }
    body = payload;
  }
}

class ProfilePinParams extends SimpleParameters {
  ProfilePinParams({required bool isPinned}) {
    queryParams['is_pinned'] = isPinned.toString();
  }
}
