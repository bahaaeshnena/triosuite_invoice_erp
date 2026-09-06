import 'package:triosuite_invoice_erp/core/common/helpers/is_arabic.dart';
import 'package:triosuite_invoice_erp/core/errors/failures.dart';
import 'package:dio/dio.dart';
import 'package:triosuite_invoice_erp/core/localization/app_translations.dart';

class ServerFailure extends Failure {
  ServerFailure(super.message);

  factory ServerFailure.fromDioException(DioException exception) {
    final tr = AppTranslations(isArabic: isArabicFun());
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(tr('connectionTimeout'));
      case DioExceptionType.sendTimeout:
        return ServerFailure(tr('sendTimeout'));
      case DioExceptionType.receiveTimeout:
        return ServerFailure(tr('receiveTimeout'));
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          exception.response?.statusCode,
          exception.response?.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure(tr('requestCancelled'));
      case DioExceptionType.unknown:
        final details = '${exception.message ?? ''} ${exception.error ?? ''}'
            .toLowerCase();
        final isConnectionFailure =
            details.contains('socketexception') ||
            details.contains('failed host lookup') ||
            details.contains('network is unreachable') ||
            details.contains('connection refused');

        return ServerFailure(
          isConnectionFailure ? tr('serverUnreachable') : tr('unexpectedError'),
        );
      case DioExceptionType.badCertificate:
        return ServerFailure(tr('serverCertificateInvalid'));
      case DioExceptionType.connectionError:
        return ServerFailure(tr('serverConnectionFailed'));
      case DioExceptionType.transformTimeout:
        return ServerFailure(tr('responseProcessingTimeout'));
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, Object? response) {
    final tr = AppTranslations(isArabic: isArabicFun());
    final responseMessage = _extractResponseMessage(response);
    if (responseMessage != null && responseMessage.isNotEmpty) {
      return ServerFailure(responseMessage);
    }

    if (statusCode == 400 ||
        statusCode == 401 ||
        statusCode == 403 ||
        statusCode == 409 ||
        statusCode == 422) {
      return ServerFailure(tr('requestCouldNotBeCompleted'));
    }

    if (statusCode == 404) {
      return ServerFailure(tr('resourceNotFound'));
    }

    if (statusCode != null && statusCode >= 500) {
      return ServerFailure(tr('internalServerError'));
    }

    return ServerFailure(tr('unexpectedError'));
  }

  static String? _extractResponseMessage(Object? response) {
    if (response is String) {
      final value = response.trim();
      return value.isEmpty ? null : value;
    }

    if (response is! Map) return null;

    final body = Map<String, dynamic>.from(response);
    final localizedMessage = isArabicFun()
        ? body['messageAr'] ?? body['message_ar']
        : body['messageEn'] ?? body['message_en'];

    if (localizedMessage != null && localizedMessage.toString().isNotEmpty) {
      return localizedMessage.toString();
    }

    final genericMessage = body['message'];
    if (genericMessage != null && genericMessage.toString().isNotEmpty) {
      return genericMessage.toString();
    }

    final error = body['error'];
    if (error is String && error.isNotEmpty) return error;
    if (error is Map) {
      final errorBody = Map<String, dynamic>.from(error);
      final errorMessage = errorBody['message'];
      if (errorMessage != null && errorMessage.toString().isNotEmpty) {
        return errorMessage.toString();
      }
    }

    final validationErrors = body['errors'];
    if (validationErrors is Map) {
      for (final value in validationErrors.values) {
        if (value is List && value.isNotEmpty) {
          return value.first.toString();
        }
        if (value != null && value.toString().isNotEmpty) {
          return value.toString();
        }
      }
    }

    return null;
  }

  @override
  String toString() => 'ServerFailure: $message';
}
