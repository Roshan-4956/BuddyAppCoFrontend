import 'package:http/http.dart' as http;

import '../../../logger.dart';
import '../../core/abstract_api.dart';
import '../../core/http_method.dart';
import 'abstract_simple_params.dart';

/// A concrete implementation of AbstractAPI that handles standard HTTP requests.
///
/// This implementation provides:
/// * Support for multipart form data
/// * Automatic content-type handling
/// * File upload support
/// * URL formatting with trailing slash handling
/// * Parameter reset functionality
///
/// Usage:
/// ```dart
/// final api = SimpleAPI<MyModel, MyParams>(
///   completeUrl: 'https://api.example.com',
///   factory: MyModel.fromJson,
///   method: HTTPMethod.post,
///   params: MyParams(),
/// );
/// ```
class SimpleAPI<MODEL, PARAM extends AbstractSimpleParameters>
    extends AbstractAPI<MODEL, PARAM, http.BaseRequest, http.Response> {
  final PARAM params;

  final bool resetParamsOnExecute;

  SimpleAPI({
    required super.completeUrl,
    required super.factory,
    required HTTPMethod method,
    required this.params,
    this.resetParamsOnExecute = false,
    super.changeListener,
    super.showToastOnError = true,
  }) : super(httpMethod: method.value);

  @override
  Future<http.BaseRequest> generateRequest() async {
    String finalUrl = params.getFormattedUrl(completeUrl);
    if (finalUrl.endsWith('#')) {
      finalUrl = removeLastLetter(finalUrl);
    }

    http.BaseRequest request;

    debugLog(debugTag, finalUrl);

    if (params.getFiles().isNotEmpty) {
      var mpRequest = http.MultipartRequest(httpMethod, Uri.parse(finalUrl));
      mpRequest.headers.clear();
      mpRequest.headers.addAll(params.getHeaders());
      mpRequest.headers.addAll({'Content-Type': 'multipart/form-data'});

      params.getBodyUnencoded().forEach((key, value) {
        mpRequest.fields[key] = value;
      });
      var files = params.getFiles();

      for (int i = 0; i < params.getFiles().keys.length; i++) {
        var key = files.keys.elementAt(i);
        mpRequest.files.add(
          await http.MultipartFile.fromPath(key, files[key]!),
        );
      }
      request = mpRequest;
    } else {
      var simpleReq = http.Request(httpMethod, Uri.parse(finalUrl));
      simpleReq.headers.clear();
      simpleReq.headers.addAll(params.getHeaders());
      simpleReq.headers.addAll({'Content-Type': 'application/json'});
      simpleReq.body = params.getBodyEncoded();
      request = simpleReq;
    }

    if (resetParamsOnExecute) {
      debugLog('API ${MODEL.toString()}', 'Parameters reset after execute.');
      params.reset();
    }

    return request;
  }

  @override
  PARAM get requestParams => params;
}

String removeLastLetter(String input) {
  if (input.isEmpty) {
    return input; // Handle empty string case if needed
  }

  return input.substring(0, input.length - 1);
}
