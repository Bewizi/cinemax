import 'package:bloc/bloc.dart';
import 'package:cinemax/features/Explore/domain/entities/movie_entity.dart';
import 'package:cinemax/features/Explore/domain/movie_repository.dart';
import 'package:equatable/equatable.dart';

part 'explore_event.dart';
part 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  ExploreBloc(this._movieRepository) : super(const ExploreState()) {
    on<GetMovies>(_onGetMovies);
    on<GetMovieById>(_onGetMovieById);
    on<GetMovieImage>(_onGetMovieImage);
  }

  final MovieRepository _movieRepository;

  Future<void> _onGetMovies(
    GetMovies event,
    Emitter<ExploreState> emit,
  ) async {
    emit(state.copyWith(status: ExploreStatus.loading));
    try {
      final movies = await _movieRepository.getMovies();
      emit(
        state.copyWith(
          status: ExploreStatus.success,
          movies: movies,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: ExploreStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onGetMovieById(
    GetMovieById event,
    Emitter<ExploreState> emit,
  ) async {
    emit(state.copyWith(movieStatus: ExploreStatus.loading));
    try {
      final movie = await _movieRepository.getMovieById(event.id);
      emit(
        state.copyWith(
          movieStatus: ExploreStatus.success,
          selectedMovie: movie,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          movieStatus: ExploreStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onGetMovieImage(
    GetMovieImage event,
    Emitter<ExploreState> emit,
  ) async {
    // Note: Assuming this might be for a specific movie image load if needed
    // If it's not used specifically in current flow, we keep it as is but updated to copyWith
    emit(state.copyWith(movieStatus: ExploreStatus.loading));
    try {
      final image = await _movieRepository.getMovieImage(event.id);
      // If ExploreState needs a specific field for image, it should be added.
      // For now, keeping the pattern consistent.
      emit(state.copyWith(movieStatus: ExploreStatus.success));
    } on Exception catch (e) {
      emit(
        state.copyWith(
          movieStatus: ExploreStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
