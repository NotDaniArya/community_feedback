import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({required this.message});

  @override
  List<Object?> get props => [message];

  factory Failure.fromDioException(DioException e) {
    String errorMessage = 'Terjadi kesalahan tidak diketahui.';
    int? statusCode = e.response?.statusCode;

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        errorMessage =
            'Koneksi ke server terputus. Harap periksa internet Anda.';
        break;
      case DioExceptionType.badResponse:
        if (e.response?.data != null && e.response!.data is Map) {
          final data = e.response!.data as Map<String, dynamic>;

          if (data.containsKey('message')) {
            errorMessage = data['message'];
            break;
          }
          if (data.containsKey('error')) {
            errorMessage = data['error'];
            break;
          }
        }

        if (statusCode == 401 || statusCode == 422 || statusCode == 403) {
          errorMessage =
              'Email atau password yang Anda masukkan salah. Harap periksa kembali.';
        } else if (statusCode == 404) {
          errorMessage = 'Layanan yang Anda tuju tidak ditemukan (404).';
        } else if (statusCode == 500) {
          errorMessage = 'Terjadi masalah di server (500). Coba lagi nanti.';
        } else {
          errorMessage =
              'Server memberikan respons yang tidak terduga. Kode: $statusCode';
        }
        break;

      case DioExceptionType.cancel:
        errorMessage = 'Permintaan ke server dibatalkan.';
        break;
      case DioExceptionType.connectionError:
        errorMessage = 'Tidak dapat terhubung ke server. Periksa koneksi Anda.';
        break;
      case DioExceptionType.unknown:
      default:
        errorMessage = 'Terjadi kesalahan jaringan yang tidak terduga.';
        break;
    }

    return ServerFailure(message: errorMessage, statusCode: statusCode);
  }
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message});
}

class ServerFailure extends Failure {
  final int? statusCode;
  const ServerFailure({required super.message, this.statusCode});
}
