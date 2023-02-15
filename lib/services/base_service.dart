abstract class BaseService {
  Future<dynamic> getResponse(String url, String token);
  Future<dynamic> getMultipartResponse(String url, Map<String, String> data);
  Future<dynamic> postResponse(String url, var body, String token);
}
