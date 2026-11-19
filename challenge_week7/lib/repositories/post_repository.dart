import 'dart:io';

import 'package:dio/dio.dart';

import '../models/post.dart';
import '../services/api_service.dart';
import '../services/dio_client.dart';

class PostRepository {
  final ApiService _apiService;

  PostRepository({ApiService? apiService})
    : _apiService = apiService ?? ApiService(DioClient.createDio());

  Future<List<Post>> getPosts({int? userId}) async {
    try {
      if (userId != null) {
        return await _apiService.getPostsByUserId(userId);
      }
      return await _apiService.getPosts();
    } on DioException catch (error) {
      throw Exception(_handleDioError(error));
    }
  }

  Future<Post> getPostDetail(int id) async {
    try {
      return await _apiService.getPost(id);
    } on DioException catch (error) {
      throw Exception(_handleDioError(error));
    }
  }

  Future<Post> createPost({
    required String title,
    required String body,
    int userId = 1,
  }) async {
    try {
      return await _apiService.createPost(
        Post(id: 0, userId: userId, title: title, body: body),
      );
    } on DioException catch (error) {
      throw Exception(_handleDioError(error));
    }
  }

  Future<Post> updatePost({
    required int id,
    required String title,
    required String body,
    int? userId,
  }) async {
    try {
      return await _apiService.updatePost(
        id,
        Post(id: id, userId: userId ?? 1, title: title, body: body),
      );
    } on DioException catch (error) {
      throw Exception(_handleDioError(error));
    }
  }

  Future<void> deletePost(int id) async {
    try {
      await _apiService.deletePost(id);
    } on DioException catch (error) {
      throw Exception(_handleDioError(error));
    }
  }

  String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
        return 'Waktu koneksi habis (timeout). Periksa koneksi internet Anda.';
      case DioExceptionType.badResponse:
        final code = error.response?.statusCode;
        switch (code) {
          case 400:
            return 'Permintaan tidak valid (Bad Request - 400).';
          case 401:
            return 'Tidak diizinkan (Unauthorized - 401).';
          case 404:
            return 'Data atau endpoint tidak ditemukan (Not Found - 404).';
          case 500:
            return 'Terjadi gangguan pada server (Internal Server Error - 500).';
          default:
            return 'Gagal memproses data dari server (Status $code).';
        }
      case DioExceptionType.connectionError:
        if (error.error is SocketException) {
          return 'Tidak ada akses internet. Pastikan perangkat terhubung.';
        }
        return 'Gagal terhubung ke server API.';
      case DioExceptionType.cancel:
        return 'Permintaan dibatalkan.';
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        return error.message ?? 'Terjadi kesalahan jaringan.';
    }
  }
}
