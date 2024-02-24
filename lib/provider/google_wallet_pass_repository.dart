import 'package:dio/dio.dart';
import 'package:ggc/constants/urls.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'google_wallet_pass_repository.g.dart';

@riverpod
GoogleWalletPassRepository googleWalletPassRepository(
  GoogleWalletPassRepositoryRef ref,
) {
  const env = String.fromEnvironment('env');
  const endpoint = env == 'dev' ? localEmulatorEndpointUrl : gcrEndpointUrl;
  return GoogleWalletPassRepository(endpoint: endpoint);
}

class GoogleWalletPassRepository {
  GoogleWalletPassRepository({required this.endpoint});
  final Dio _dio = Dio();
  final String endpoint;

  Future<String?> generateJwt(Map<String, dynamic> requestData) async {
    final response =
        await _dio.post<Map<String, dynamic>>(endpoint, data: requestData);
    if (response.statusCode == 200) {
      return response.data?['jwt'].toString();
    }
    throw Exception(
      'Failed to generate jwt status code: ${response.statusCode}',
    );
  }
}
