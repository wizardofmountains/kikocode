/// API endpoint constants
/// 
/// This file contains all API-related constants including endpoints,
/// headers, and configuration values.
library;

/// Supabase configuration
class SupabaseConfig {
  // TODO: Add your Supabase credentials
  static const String supabaseUrl = 'YOUR_SUPABASE_URL';
  static const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';
}

/// API endpoints
class ApiEndpoints {
  // Base configuration is handled by Supabase
  
  // Custom endpoints (if using additional APIs)
  // Example:
  // static const String customEndpoint = '/api/v1/custom';
}

/// API headers
class ApiHeaders {
  static const String contentTypeJson = 'application/json';
  static const String contentTypeFormData = 'multipart/form-data';
}

/// API response codes
class ApiResponseCodes {
  static const int success = 200;
  static const int created = 201;
  static const int noContent = 204;
  static const int badRequest = 400;
  static const int unauthorized = 401;
  static const int forbidden = 403;
  static const int notFound = 404;
  static const int serverError = 500;
}
