import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../utils/logger.dart';

part 'app_router_service.g.dart';

class LocationLockedModel {
  final String pathName;
  final bool isLocked;

  LocationLockedModel({required this.pathName, required this.isLocked});
}

class AppRouterService {
  final Ref ref;

  AppRouterService(this.ref);

  String locationCheck({
    required List<LocationLockedModel> locationsToCheck,
    required String location,
  }) {
    List<String> address = location.split('/');

    for (int i = 0; i < locationsToCheck.length; i++) {
      if (address.contains(locationsToCheck[i].pathName) &&
          locationsToCheck[i].isLocked) {
        String lockedLocation = '';
        for (int j = 1; j < address.length; j++) {
          if (j >= address.length) {
            return '/';
          }
          if (address[j] == locationsToCheck[i].pathName) {
            userLog('Section is locked');
            return lockedLocation;
          }
          lockedLocation = '$lockedLocation/${address[j]}';
        }
      }
    }
    return location;
  }
}

@Riverpod(keepAlive: true)
AppRouterService appRouterService(Ref ref) {
  return AppRouterService(ref);
}
