part of 'explore_bloc.dart';

enum ExploreStatus { initial, loading, success, failure }

final class ExploreState extends Equatable {
  const ExploreState({
    this.status = ExploreStatus.initial,
    this.movies = const [],
    this.selectedMovie,
    this.movieStatus = ExploreStatus.initial,
    this.errorMessage,
  });

  final ExploreStatus status;
  final List<MovieEntity> movies;
  final MovieEntity? selectedMovie;
  final ExploreStatus movieStatus;
  final String? errorMessage;

  ExploreState copyWith({
    ExploreStatus? status,
    List<MovieEntity>? movies,
    MovieEntity? selectedMovie,
    ExploreStatus? movieStatus,
    String? errorMessage,
  }) {
    return ExploreState(
      status: status ?? this.status,
      movies: movies ?? this.movies,
      selectedMovie: selectedMovie ?? this.selectedMovie,
      movieStatus: movieStatus ?? this.movieStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        movies,
        selectedMovie,
        movieStatus,
        errorMessage,
      ];
}
