class Env {
  static String get apiUri => const String.fromEnvironment("API_URI",
      defaultValue: "http://localhost:8080");
}
