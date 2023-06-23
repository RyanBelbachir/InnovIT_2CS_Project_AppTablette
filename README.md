# mobile1_distributeur_frontend
The frontend part of the mobile1 distributor ( tablet ) application in the 2CS project card.

# Used
Flutter SDK 3.0.0
dependencies : 
  - drop_shadow_image: ^0.9.1
  - drop_shadow: ^0.1.0
  - assorted_layout_widgets: ^8.0.0
  - qr_flutter: ^4.0.0
  - percent_indicator: ^4.0.1
  - video_player: ^2.6.0
  - http: ^0.13.5
  - path_provider: ^2.0.14
  - flutter_svg: ^2.0.4
  - flutter_screen_lock: ^9.0.1
  - camera: ^0.10.3+2
  - flutter_dotenv: ^5.0.2
  - image_picker: ^0.8.7+1
  - socket_io_client: ^2.0.1
  - mqtt5_client: ^3.3.7
  - geolocator: ^7.0.3
  - location: ^4.1.1
  - audioplayers: ^4.0.1

## How to use

1- install dependencies by running the command : flutter pub get

2- launch the app by running the command : flutter run

# Main files and folders

- The main.dart file : represents the entry point of the app ( main function )
- The pages folder: contains all the screens of the app as widgets
- The widgets folder : contains the reusable widgets that are used by different screens
- The styles folder : contains the themes and the custom styles used in the app
- The utils folder : contains utility functions and integration functions ( that communicate with the backend
- The viewmodels folder : contains data classes that bind data to the UI
