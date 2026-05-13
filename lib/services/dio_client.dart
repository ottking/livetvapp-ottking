import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../core/config/app_config.dart';
import '../core/constants.dart';
import '../core/utils/exceptions.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  late Dio _dio;
  static final Logger _logger = Logger();

  DioClient._internal() {
    _initializeDio();
  }

  factory DioClient() {
    return _instance;
  }

  void _initializeDio() {
    _dio = Dio(
      BaseOptions(
        connectTimeout: AppConstants.apiTimeoutDuration,
        receiveTimeout: AppConstants.apiTimeoutDuration,
        contentType: Headers.jsonContentType,
      ),
    );

    // Add interceptors
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['Authorization'] = ConfigManager().getAuthHeader();
          options.headers['Content-Type'] = 'application/json';
          _logger.d('API Request: ${options.method} ${options.path}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          _logger.d('API Response: ${response.statusCode} ${response.requestOptions.path}');
          return handler.next(response);
        },
        onError: (error, handler) {
          _logger.e('API Error: ${error.message}');
          return handler.next(error);
        },
      ),
    );

    // Pretty logger
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
      ),
    );
  }

  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic) converter,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
      );
      return converter(response.data);
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<T> post<T>(
    String path, {
    required Map<String, dynamic> data,
    required T Function(dynamic) converter,
  }) async {
    try {
      final response = await _dio.post(path, data: data);
      return converter(response.data);
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<T> put<T>(
    String path, {
    required Map<String, dynamic> data,
    required T Function(dynamic) converter,
  }) async {
    try {
      final response = await _dio.put(path, data: data);
      return converter(response.data);
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<void> delete(String path) async {
    try {
      await _dio.delete(path);
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  void _handleError(DioException error) {
    String message;
    
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        message = 'সংযোগ সময়সীমা অতিক্রম করেছে';
        break;
      case DioExceptionType.badResponse:
        message = 'সার্ভার ত্রুটি: ${error.response?.statusCode}';
        break;
      case DioExceptionType.unknown:
        message = 'নেটওয়ার্ক সংযোগ ব্যর্থ হয়েছে';
        break;
      default:
        message = 'অজানা ত্রুটি';
    }
    
    throw NetworkException(
      message: message,
      originalException: error,
    );
  }
}

class PrettyDioLogger extends Interceptor {
  final bool requestHeader;
  final bool requestBody;
  final bool responseHeader;
  final bool responseBody;

  PrettyDioLogger({
    this.requestHeader = true,
    this.requestBody = true,
    this.responseHeader = true,
    this.responseBody = true,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    printBoxed('─── Request ───');
    if (requestHeader) {
      printBoxed('Headers: ${options.headers}');
    }
    if (requestBody) {
      printBoxed('Body: ${options.data}');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    printBoxed('─── Response ───');
    if (responseHeader) {
      printBoxed('Status: ${response.statusCode}');
    }
    if (responseBody) {
      printBoxed('Data: ${response.data}');
    }
    handler.next(response);
  }

  void printBoxed(String msg) {
    Logger().d(msg);
  }
}
