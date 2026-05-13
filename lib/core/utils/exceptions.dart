class AppException implements Exception {
  final String message;
  final dynamic originalException;
  final StackTrace? stackTrace;

  AppException({
    required this.message,
    this.originalException,
    this.stackTrace,
  });

  @override
  String toString() => message;
}

class NetworkException extends AppException {
  NetworkException({required super.message, super.originalException, super.stackTrace});
}

class FirebaseException extends AppException {
  FirebaseException({required super.message, super.originalException, super.stackTrace});
}

class VersionMismatchException extends AppException {
  VersionMismatchException({required super.message, super.originalException, super.stackTrace});
}

class MaintenanceModeException extends AppException {
  MaintenanceModeException({required super.message, super.originalException, super.stackTrace});
}
