# Implementation Plan - Display Bottom Navigation on Now Showing and Movie Details Pages

The goal is to ensure the `BottomNavigationBar` remains visible when navigating to the "Now Showing" and "Movie Details" pages. Currently, these routes are defined as top-level routes outside the `StatefulShellRoute`, which causes them to cover the entire screen, including the bottom navigation.

## Proposed Changes

### Router Configuration

#### [MODIFY] [app_router.dart](file:///Users/chelseafc/Documents/Development/CineMax/cinemax/lib/core/router/app_router.dart)
- Move `NowShowingRoute` and `MovieDetailsRoute` classes into the `TypedStatefulShellBranch<ExploreBranchData>` routes list.
- Remove their standalone `@TypedGoRoute` annotations.
- This ensures they are rendered within the `ScaffoldWithBottomNavBar` when navigated to.

### UI Components

#### [MODIFY] [movie_details_page.dart](file:///Users/chelseafc/Documents/Development/CineMax/cinemax/lib/features/Explore/presentation/pages/movie_details_page.dart)
- Fix the syntax error at `bottomNavigationBar: ,`. I will remove this line to avoid overriding the shell's navigation bar or causing a build failure.

## Verification Plan

### Manual Verification
- Navigate to the **Explore** tab.
- Click on **View Movies** in any cinema card to go to the **Now Showing** page.
- Verify that the `BottomNavigationBar` is still visible.
- Click on any movie card to go to the **Movie Details** page.
- Verify that the `BottomNavigationBar` is still visible.
- Verify that the **Back** button in the AppBar works as expected, returning to the previous page within the Explore branch.
