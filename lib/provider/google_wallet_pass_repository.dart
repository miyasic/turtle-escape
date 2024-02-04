import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'google_wallet_pass_repository.g.dart';

@riverpod
GoogleWalletPassRepository googleWalletPassRepository(
  GoogleWalletPassRepositoryRef ref,
) =>
    GoogleWalletPassRepository();

class GoogleWalletPassRepository {
  final Dio _dio = Dio();
  final String _endpoint =
      'http://10.0.2.2:3000/generate-jwt'; // android emulatorの場合

  Future<String?> generateJwt(Map<String, dynamic> requestData) async {
    try {
      final response = await _dio.post(_endpoint, data: requestData);
      if (response.statusCode == 200) {
        return response.data['jwt'].toString();
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
