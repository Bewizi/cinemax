# Implementation Plan - Displaying Movie Genres

The goal is to dynamically display movie genres in the `MovieCard` widget, replacing the current hardcoded and broken implementation. The genres are provided as a list of strings from the backend.

## User Review Required

> [!IMPORTANT]
> The `MovieCard` currently attempts to display two genres. I will change this to display all available genres using a `Wrap` widget to prevent overflow if a movie has multiple genres. Alternatively, if you prefer to show only a limited number (e.g., the first two), please let me know.

## Proposed Changes

### Explore Feature

#### [MODIFY] [movie_card.dart](file:///Users/chelseafc/Documents/Development/CineMax/cinemax/lib/features/Explore/presentation/widgets/movie_card.dart)
- Replace the hardcoded genre `Row` with a dynamic `Wrap` widget that iterates over the `genre` list.
- Fix the type casting error `(genre!.contains('genre')) as String` which would cause a runtime crash.
- Ensure null safety for the `genre` list.

## Verification Plan

### Manual Verification
- Run the app and navigate to the "Now Showing" page (or any page using `MovieCard`).
- Verify that the genres for each movie match the data seeded in the backend (e.g., "Horror", "Thriller", "Drama").
- Check for UI layout issues (e.g., overflow) when a movie has many genres.
