# Fix Hero Animation Between Movie Card and Movie Details

The Hero animation is currently not working because both `MovieCard` and `MovieDetailsPage` use a hardcoded tag `'dash'`. This causes conflicts when multiple `MovieCard`s are present in a list and doesn't provide a unique mapping for the transition. Additionally, `MovieDetailsPage` only builds the `Hero` widget after the movie details have been successfully loaded, which might be too late for the transition animation.

## Proposed Changes

### [Explore Feature]

#### [MODIFY] [movie_card.dart](file:///Users/chelseafc/Documents/Development/CineMax/cinemax/lib/features/Explore/presentation/widgets/movie_card.dart)
- Add a `heroTag` property to the `MovieCard` constructor.
- Use the `heroTag` in the `Hero` widget instead of the hardcoded `'dash'`.

#### [MODIFY] [now_showing_page.dart](file:///Users/chelseafc/Documents/Development/CineMax/cinemax/lib/features/Explore/presentation/pages/now_showing_page.dart)
- Pass the movie's ID as the `heroTag` to the `MovieCard`.

#### [MODIFY] [movie_details_page.dart](file:///Users/chelseafc/Documents/Development/CineMax/cinemax/lib/features/Explore/presentation/pages/movie_details_page.dart)
- Use the movie's `id` as the `Hero` tag.
- Modify the `BlocBuilder` to show the `Hero` widget immediately if the movie is already present in the `state.movies` list (even if the full details are still loading). This ensures the animation starts as soon as the page transition begins.
- Handle the loading and success states gracefully while keeping the `Hero` widget consistent.

## Verification Plan

### Manual Verification
- Navigate to the "Now Showing" page.
- Tap on a movie card and observe the Hero animation transition to the details page.
- Verify that the image smoothly expands from the card to the detail header.
- Go back and verify the return animation.
