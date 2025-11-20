// This class manages API parameters and URL formatting for API Call 1.
import 'package:buddy_app/utils/api/implementation/simple_api/simple_params.dart';

class ApiCall1Params extends SimpleParameters {
  // Getter for the course ID using body data.
  String get courseId => body['random_data'];
  // Setter for course ID.
  set courseId(String val) {
    body['random_data'] = val;
  }

  // Placeholder in the URL to be replaced with actual parameter.
  static const String randomdatainURL = '{random_data}';
  String? randomdata = '';

  // Formats the URL by replacing the placeholder with the actual data.
  @override
  String getFormattedUrl(String raw) {
    return super
        .getFormattedUrl(raw)
        .replaceFirst(randomdatainURL, randomdata!);
  }
}
