# Implementation Plan - Fix Movie Image Display

The images are not showing because:
1.  The `HomePage` was not correctly updated to trigger the movie fetch and use dynamic data for the carousel.
2.  The image URL construction in `MovieModels` might be incorrect for Laravel's storage structure.
3.  The `MovieModels` doesn't prioritize the `image_url` field provided by the backend.

## Proposed Changes

### Core Data

#### [MODIFY] [api.dart](file:///Users/chelseafc/Documents/Development/CineMax/cinemax/lib/core/data/api.dart)
- Add `rootUrl` to separate the base server URL from the API endpoint.
- Update `baseUrl` to use `rootUrl`.

### Feature: Explore

#### [MODIFY] [movie_models.dart](file:///Users/chelseafc/Documents/Development/CineMax/cinemax/lib/features/Explore/data/models/movie_models.dart)
- Update `fromJson` to prioritize `image_url` from the backend.
- Use `Api.rootUrl` for constructing relative image paths if needed.

### Feature: Home

#### [MODIFY] [home.dart](file:///Users/chelseafc/Documents/Development/CineMax/cinemax/lib/features/Home/presentation/pages/home.dart)
- Call `ExploreBloc.add(GetMovies())` in `initState`.
- Update the carousel to use `ExploreBloc` state for dynamic images.
- Use `Image.network` for carousel images.

## Verification Plan

### Manual Verification
- Restart the app and verify that the carousel images load from the network.
- Verify that "Top Movies" and "Latest Movies" sections now display images.
- Check the console/logs for any image loading errors.
