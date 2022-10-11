import 'package:tableapptest/consts/api_consts.dart';
import 'package:tableapptest/models/enums/api_level.dart';

extension ApiLevelDefiner on ApiLevel {
  String get getBaseUrl {
    switch (this) {
      case ApiLevel.PRODUCTION:
        return ApiConsts.baseProdUrl;
      case ApiLevel.DEVELOPMENT:
        return ApiConsts.baseDevUrl;
      default:
        return ApiConsts.baseProdUrl;
    }
  }
}