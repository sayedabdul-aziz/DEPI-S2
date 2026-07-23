import 'package:bookia/core/services/apis/apis.dart';

enum FlavorEnv { staging, production }

class FlavorEnvironment {
  static FlavorEnv _flavorType = FlavorEnv.staging;

  static void setCurrentEnvironment(FlavorEnv type) {
    _flavorType = type;
  }

  static FlavorEnv get currentFlavor => _flavorType;
}

class UrlProvider {
  static FlavorEnvConfig get config {
    switch (FlavorEnvironment.currentFlavor) {
      case FlavorEnv.production:
        return FlavorProductionConfig();
      case FlavorEnv.staging:
        return FlavorStagingConfig();
    }
  }
}

abstract class FlavorEnvConfig {
  String get baseUrl;
  String get geminiApiKey;
}

class FlavorStagingConfig implements FlavorEnvConfig {
  @override
  String get baseUrl => Apis.baseUrl;

  @override
  String get geminiApiKey => 'gemini_api_key';
}

class FlavorProductionConfig implements FlavorEnvConfig {
  @override
  String get baseUrl => Apis.baseUrl;

  @override
  String get geminiApiKey => 'gemini_api_key';
}
