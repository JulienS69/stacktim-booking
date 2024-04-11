# Stacktim Booking

Application mobile Stacktim Booking created by Julien SEUX & Dheeraj TILHOO.

![controller-svgrepo-com 15 (2)](https://github.com/JulienS69/stacktim-booking/assets/60474003/1d6131d2-7604-4e90-8b4a-b49cc7d740a7)

Flutter mobile application allowing to book a gaming session in the E-Sport room of XEFI Lyon.

-------------------------------------------------------------------------------------------------

# Command for build APK in ANDROID : 
flutter build apk --release --no-tree-shake-icons

# Command for build APPBUNDLE in ANDROID : 
flutter build appbundle --release --no-tree-shake-icons

# Command for build IOS : 
flutter build ios --release --no-tree-shake-icons 

# Command for build ARCHIVE in IOS : 
flutter build ipa --release --no-tree-shake-icons 

# Generate models in project :
flutter pub run build_runner build --delete-conflicting-outputs

# Clean models : 
flutter pub run build_runner clean

# Environnements API : 

    # RD
        - https://rd-stacktim-booking-api.xefi-apps.fr/api
    # RC
        - https://rc-stacktim-booking-api.xefi-apps.fr/api
    # DEMO
        - https://demo-stacktim-booking-api.xefi-apps.fr/api
    # PROD
        - https://stacktim-booking-api.dailyapps.fr/api
