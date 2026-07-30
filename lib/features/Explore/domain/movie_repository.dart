import 'package:cinemax/features/Explore/domain/entities/movie_entity.dart';

abstract class MovieRepository {
  Future<List<MovieEntity>> getMovies();

  Future<MovieEntity> getMovieById(String id);

  //   get movie image
  Future<String> getMovieImage(String id);
}
