part of 'explore_bloc.dart';

sealed class ExploreEvent extends Equatable {
  const ExploreEvent();
}

final class GetMovies extends ExploreEvent {
  const GetMovies();

  @override
  List<Object> get props => [];
}

final class GetMovieById extends ExploreEvent {
  const GetMovieById(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

final class GetMovieImage extends ExploreEvent {
  const GetMovieImage(this.image, this.id);

  final MovieEntity image;
  final String id;

  @override
  List<Object> get props => [id];
}
