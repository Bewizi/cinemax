# Walkthrough - Display Movies by Tags

I have updated the Home screen to dynamically fetch movies and display them in sections based on their tags (`top_movie`, `latest_movie`).

## Changes Made

### Feature: Home

#### [home.dart](file:///Users/chelseafc/Documents/Development/CineMax/cinemax/lib/features/Home/presentation/pages/home.dart)

- Added logic to fetch movies via `ExploreBloc` on initialization.
- Replaced the static carousel images with dynamic images fetched from the API.
- Added `LatestMovies` widget to the main column.

#### [top_movies.dart](file:///Users/chelseafc/Documents/Development/CineMax/cinemax/lib/features/Home/presentation/widgets/top_movies.dart)

- Updated the `BlocBuilder` to filter the movie list for the `top_movie` tag.

#### [latest_movies.dart](file:///Users/chelseafc/Documents/Development/CineMax/cinemax/lib/features/Home/presentation/widgets/latest_movies.dart)

- Created a new widget that filters the movie list for the `latest_movie` tag.

## Verification Results

### Manual Verification
- The sections now dynamically display images based on the tags defined in your backend seeder.
- The carousel auto-scrolls through all fetched movies.
- The UI layout matches the design requirements with "Top Movies" and "Latest Movies" sections.
