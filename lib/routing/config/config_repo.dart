import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../utils/api/core/http_method.dart';
import '../../utils/api/implementation/riverpod_api/riverpod_api.dart';
import '../../utils/factory_utils.dart';
import '../../utils/urls.dart';
import 'config_params.dart';

part 'config_repo.g.dart';

@Riverpod(keepAlive: true)
RiverpodAPI<ConfigModel, ConfigParams> configRepo(Ref ref) {
  return RiverpodAPI<ConfigModel, ConfigParams>(
    completeUrl: URLs.complete(
      'courses/config'
      '#',
    ),
    factory: FactoryUtils.modelFromString(ConfigModel.fromJson),
    params: ConfigParams(),
    method: HTTPMethod.get,
    ref: ref,
  );
}

class ConfigModel {
  final String? message;
  final bool? success;
  final bool? data;

  ConfigModel({this.message, this.success, this.data});

  factory ConfigModel.fromJson(Map<String, dynamic> json) {
    return ConfigModel(
      message: json['message'],
      success: json['success'],
      // data: json['data'] != null ? ConfigData.fromJson(json['data']) : null,
    );
  }
}
