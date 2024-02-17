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
    final response =
        await _dio.post<Map<String, dynamic>>(_endpoint, data: requestData);
    if (response.statusCode == 200) {
      return response.data?['jwt'].toString();
    }
    throw Exception(
      'Failed to generate jwt status code: ${response.statusCode}',
    );
  }
}
