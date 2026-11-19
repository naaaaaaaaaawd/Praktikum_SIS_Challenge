import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/post.dart';
import 'dio_client.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: DioClient.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String? baseUrl}) = _ApiService;

  @GET('/posts')
  Future<List<Post>> getPosts();

  @GET('/posts/{id}')
  Future<Post> getPost(@Path('id') int id);

  @GET('/posts')
  Future<List<Post>> getPostsByUserId(@Query('userId') int userId);

  @POST('/posts')
  Future<Post> createPost(@Body() Post post);

  @PUT('/posts/{id}')
  Future<Post> updatePost(@Path('id') int id, @Body() Post post);

  @DELETE('/posts/{id}')
  Future<void> deletePost(@Path('id') int id);
}
