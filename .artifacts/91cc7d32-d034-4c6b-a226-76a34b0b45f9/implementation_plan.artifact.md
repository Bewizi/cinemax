# Implementation Plan - Fix Movie Details Loading Loop

The `MovieDetailsPage` is stuck on a loading indicator because `ExploreBloc` emits two states in quick succession when fetching movie details: `ExploreMovieLoaded` and then `ExploreMovieImageLoaded`. The `BlocBuilder` in the UI only handles `ExploreMovieLoaded`, so it resets to the loading indicator when the second state arrives.

## User Review Required

> [!IMPORTANT]
> I am removing the redundant `ExploreMovieImageLoaded` emission from the `GetMovieById` handler in `ExploreBloc`. This state is only needed when fetching an image independently, not when loading the full movie details which already include the image URL.

## Proposed Changes

### Explore Feature

#### [MODIFY] [explore_bloc.dart](file:///Users/chelseafc/Documents/Development/CineMax/cinemax/lib/features/Explore/bloc/explore_bloc.dart)
- Remove `emit(ExploreMovieImageLoaded(movie.image!));` from the `_onGetMovieById` method. This ensures that `ExploreMovieLoaded` remains the active state, allowing the UI to stay visible.

#### [MODIFY] [movie_details_page.dart](file:///Users/chelseafc/Documents/Development/CineMax/cinemax/lib/features/Explore/presentation/pages/movie_details_page.dart)
- I will also restore the full UI implementation that I previously proposed, as the current version in the file appears to be a placeholder or was accidentally reverted. This includes:
    - Movie Poster with gradient overlay.
    - Title and Rating.
    - Duration and Genres.
    - Synopsis section.
    - "Buy Ticket" button.

## Verification Plan

### Automated Tests
- I will verify the logic by ensuring the state transition in the logs (mentally) would stop at `ExploreMovieLoaded`.

### Manual Verification
- Hot restart the app.
- Navigate to a movie's details.
- Verify the page displays the full details and does not get stuck on the loading spinner.
