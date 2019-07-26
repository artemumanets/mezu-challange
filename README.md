# Mezu-Challenge
An image gallery app which uses flicker API to show images based on user's name. Allows to select an image and preview it details.

## Requirements
+ Xcode 10.2.1
+ iOS 11.0
+ Swift 5.0

## Run the project
1. Open Xcode.
2. Run the application.

## External Dependencies
+ None - External dependencies were avoided.

## Screens
+ Initial - users is allowed to insert a username which used to retrieve images.
+ List - list of images with infinite scrolling pagination.
+ Details - detailed information of the specific image.
+ Info - information about the challenge and developer.

## Additional Implementations
+ Multi-resolution support - works properly on all iPhone resolutions
+ Caching - API requests and images are cached to avoid hitting the network every time.
+ Offline Mode - When there is no network, API responses and images are loaded from the cache if possible.
+ Image requests are made asynchronously in multi task environment to ensure smoothness and good performance.

## Edge Cases
+ Validation of the specific API errors, in case of inexistent user name.
+ Validation when empty username is entered.
+ When user exists, but without photos, proper message is displayed (user example: artem).
+ List of photos is filtered by media attribute with value "photo".






