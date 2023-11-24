class ApiConstants {
  static bool isProduction = const bool.fromEnvironment('dart.vm.product');

  static String testBaseUrl = 'http://54.175.8.84:3000';
  static String productionBaseUrl = 'http://54.175.8.84:3000';

  static String baseUrl = isProduction ? productionBaseUrl : testBaseUrl;
  static String visionEndpoint = '/api/vision';
  static String recipeEndpoint = '/api/recipes';
}
