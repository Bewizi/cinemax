# Fix Persistent Loading on Navigation Back

The app currently experiences a persistent loading indicator when navigating back from `MovieDetailsPage` to `NowShowingPage` or `HomePage`. This is because the `ExploreBloc` uses mutually exclusive state classes for movie lists and movie details. When movie details are fetched, the state that holds the movie list is replaced, causing list widgets to show a loading indicator as they no longer see the `ExploreLoaded` state.

## Proposed Changes

### [Explore Feature]

#### [MODIFY] [explore_state.dart](file:///Users/chelseafc/Documents/Development/CineMax/cinemax/lib/features/Explore/bloc/explore_state.dart)
- Refactor `ExploreState` from a sealed class hierarchy to a single class.
- Add fields for `movies` (list), `selectedMovie` (single), `status` (for the list), `movieStatus` (for details), and `errorMessage`.
- This ensures that fetching details doesn't clear the `movies` list.

#### [MODIFY] [explore_bloc.dart](file:///Users/chelseafc/Documents/Development/CineMax/cinemax/lib/features/Explore/bloc/explore_bloc.dart)
- Update event handlers to work with the new single `ExploreState` class.
- Use `emit(state.copyWith(...))` to update only the relevant parts of the state.

#### [MODIFY] [top_movies.dart](file:///Users/chelseafc/Documents/Development/CineMax/cinemax/lib/features/Home/presentation/widgets/top_movies.dart)
- Update `BlocBuilder` to check for `state.status == ExploreStatus.success` and use `state.movies`.

#### [MODIFY] [latest_movies.dart](file:///Users/chelseafc/Documents/Development/CineMax/cinemax/lib/features/Home/presentation/widgets/latest_movies.dart)
- Update `BlocBuilder` to check for `state.status == ExploreStatus.success` and use `state.movies`.

#### [MODIFY] [now_showing_page.dart](file:///Users/chelseafc/Documents/Development/CineMax/cinemax/lib/features/Explore/presentation/pages/now_showing_page.dart)
- Update `BlocBuilder` to check for `state.status == ExploreStatus.success` and use `state.movies`.

#### [MODIFY] [movie_details_page.dart](file:///Users/chelseafc/Documents/Development/CineMax/cinemax/lib/features/Explore/presentation/pages/movie_details_page.dart)
- Update `BlocBuilder` to check for `state.movieStatus == ExploreStatus.success` and use `state.selectedMovie`.

## Verification Plan

### Manual Verification
- Navigate from Home to Explore.
- Click "View Movies" to go to `NowShowingPage`.
- Click a movie to go to `MovieDetailsPage`.
- Go back to `NowShowingPage` and verify the list is still there without a loading indicator.
- Go back to Home and verify `Top Movies` and `Latest Movies` are still visible.
