# Implementation Plan - Now Showing Screen

The goal is to implement the "Now Showing" screen as seen in the provided images. This screen displays a list of movies for a selected cinema (e.g., iMax Cinemas).

## User Review Required

> [!IMPORTANT]
> I recommend using a **`StatefulWidget`** (or `StatelessWidget`) for the "Now Showing" screen instead of a `mixin`.
>
> - **Why not a mixin?** Mixins are used to add shared behavior/methods to multiple classes. They are not intended to define full UI components or screens.
> - **Why a Widget?** In Flutter, everything UI is a widget. A dedicated `NowShowingPage` allows you to manage the screen's lifecycle, handle navigation, and integrate with your `ExploreBloc` cleanly.

## Proposed Changes

### Explore Feature

#### [NEW] [now_showing_page.dart](file:///Users/chelseafc/Documents/Development/CineMax/cinemax/lib/features/Explore/presentation/pages/now_showing_page.dart)
- Create a `NowShowingPage` widget.
- Use `AppScaffold` for the layout.
- Implement the header with a back button and "Now Showing" title.
- Use a `ListView` to display the movies.

#### [NEW] [movie_card.dart](file:///Users/chelseafc/Documents/Development/CineMax/cinemax/lib/features/Explore/presentation/widgets/movie_card.dart)
- Create a reusable `MovieCard` widget.
- Include the poster image, badge, title, genre tags, rating, duration, description, and price as shown in the mockup.

#### [MODIFY] [explore.dart](file:///Users/chelseafc/Documents/Development/CineMax/cinemax/lib/features/Explore/presentation/pages/explore.dart)
- Update the "View Movies" button to navigate to the `NowShowingPage`.
- Pass the cinema name/details to the `NowShowingPage`.

#### [DELETE] [now_showing.dart](file:///Users/chelseafc/Documents/Development/CineMax/cinemax/lib/features/Explore/presentation/widgets/mixin/now_showing.dart)
- Remove the unused mixin file or repurpose it if you had a specific shared logic in mind.

## Verification Plan

### Manual Verification
- Navigate to the **Explore** tab.
- Tap on "View Movies" for any cinema.
- Verify that the **Now Showing** screen appears with the correct cinema title.
- Verify the layout and styling of the movie cards match the mockup.
