# Implementation Plan - Integrate Movie Images from Backend

The goal is to correctly fetch movie data and image URLs from the Laravel backend. This involves updating the Flutter data layer to match the Laravel API's route structure and response format.

## User Review Required

> [!IMPORTANT]
> The Laravel backend returns responses wrapped in a `{"status": "...", "data": ...}` structure. I will update the Flutter `MovieData` class to extract the `data` field correctly.
>
> I will also add the `v1/` prefix to the API paths in `MovieData` as defined in your Laravel router.

> [!NOTE]
> For the movie images to display correctly in Flutter, they should be full URLs. I'll assume `getImageUrlAttribute()` on the backend provides the full URL. If it only provides a relative path, we may need to prepend the base storage URL in Flutter.

## Proposed Changes

### [Explore Feature - Data Layer]

#### [MODIFY] [movie_data.dart](file:///Users/chelseafc/Documents/Development/CineMax/cinemax/lib/features/Explore/data/movie_data.dart)
- Update `getMovies()` to use `v1/getMovies` and extract `response.data['data']`.
- Update `getMovieById()` to use `v1/getMovieById/$id` and extract `response.data['data']`.
- Update `getMovieImage()` to use `v1/getMoviesImages/$id` and extract `response.data['data']`.

#### [MODIFY] [movie_models.dart](file:///Users/chelseafc/Documents/Development/CineMax/cinemax/lib/features/Explore/data/models/movie_models.dart)
- Update `fromJson` to handle potential field name differences if necessary, though it seems consistent with the seeder for now.
- Consider adding a helper to construct the full image URL if the backend doesn't provide it.

## Verification Plan

### Automated Tests
- I will check if there are existing tests for `MovieData` and update them if they exist.

### Manual Verification
- The user should verify that the images are correctly fetched by checking the logs or running the app if the UI is connected.
