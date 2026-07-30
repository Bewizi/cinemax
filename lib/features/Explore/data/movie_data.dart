import 'package:cinemax/core/data/api.dart';
import 'package:cinemax/core/data/api_client.dart';
import 'package:cinemax/features/Explore/data/models/movie_models.dart';
import 'package:cinemax/features/Explore/domain/entities/movie_entity.dart';
import 'package:cinemax/features/Explore/domain/movie_repository.dart';

class MovieData implements MovieRepository {
  MovieData(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<List<MovieEntity>> getMovies() async {
    final response = await _apiClient.get('v1/getMovies');
    final list = response.data['data'] as List<dynamic>;
    return list
        .map((e) => MovieModels.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<MovieEntity> getMovieById(String id) async {
    final response = await _apiClient.get('v1/getMovieById/$id');
    return MovieModels.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<String> getMovieImage(String id) async {
    final response = await _apiClient.get('v1/getMoviesImages/$id');
    String imageUrl = response.data['data'] as String;
    if (imageUrl.isNotEmpty && !imageUrl.startsWith('http')) {
      imageUrl = '${Api.baseUrl}$imageUrl';
    }
    return imageUrl;
  }
}
