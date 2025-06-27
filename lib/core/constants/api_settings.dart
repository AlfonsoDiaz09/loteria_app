import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiSettings {
  final String version;
  final String apiKey;
  final String apiSupabaseUrl;
  final String storageImageUrl;

  ApiSettings({
    required this.version,
    required this.apiKey,
    required this.apiSupabaseUrl,
    required this.storageImageUrl});

  factory ApiSettings.fromEnv() {
    return ApiSettings(
      version: dotenv.env['VERSION'] ?? 'VERSION not found',
      apiKey: dotenv.env['API_KEY'] ?? 'API_KEY not found',
      apiSupabaseUrl: dotenv.env['API_SUPABASE_URL'] ?? 'API_SUPABASE_URL not found',
      storageImageUrl: dotenv.env['STORAGE_IMAGE_URL'] ?? 'STORAGE_IMAGE_URL not found');
  }
}