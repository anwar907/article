class Constant {
  static const String baseUrl = String.fromEnvironment('BASE_API_URL',
      defaultValue: 'https://newsapi.org/v2');
  static const String apiKey = String.fromEnvironment('API_KEY',
      defaultValue: '60fae82aa74b42a2a5ac38178f7e38fe');
  static const String domain = String.fromEnvironment('DOMAIN',
      defaultValue: 'techcrunch.com,thenextweb.com');
}
