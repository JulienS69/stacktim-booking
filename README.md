#  Stacktim Booking <img src="https://github.com/JulienS69/stacktim-booking/assets/60474003/1d6131d2-7604-4e90-8b4a-b49cc7d740a7" alt="" width="25"/>

Application mobile Stacktim Booking created by Julien SEUX & Dheeraj TILHOO.

<img src="https://github.com/JulienS69/stacktim-booking/assets/60474003/95a99a03-5876-474b-909b-7556d32ebc27" alt="" width="100"/>
<img src="https://github.com/JulienS69/stacktim-booking/assets/60474003/769df4c4-ec8c-4546-8882-48abb9c60cde" alt="" width="100"/>
<img src="https://github.com/JulienS69/stacktim-booking/assets/60474003/514235f4-9325-4b27-a9dd-627d9aac3fa6" alt="" width="100"/>
<img src="https://github.com/JulienS69/stacktim-booking/assets/60474003/fffc5a4a-8b73-42fb-b015-eab6e17a4227" alt="" width="100"/> 



Flutter mobile application allowing to book a gaming session in the E-Sport room of XEFI Lyon.

-------------------------------------------------------------------------------------------------

# Command for build APK in ANDROID : 
    RD : 
        flutter build apk --release --no-tree-shake-icons --dart-define="ENV_TYPE=RD"
    RC : 
        flutter build apk --release --no-tree-shake-icons --dart-define="ENV_TYPE=RD"
    PROD:
        flutter build apk --release --no-tree-shake-icons --dart-define="ENV_TYPE=PROD"

# Command for build APPBUNDLE in ANDROID :
flutter build appbundle --release --no-tree-shake-icons --dart-define="ENV_TYPE=PROD"


# Command for build IOS : 
flutter build ios --release --no-tree-shake-icons 

# Command for build ARCHIVE in IOS : 
    RD : 
        flutter build ipa --release --no-tree-shake-icons --dart-define="ENV_TYPE=RD"
    RC : 
        flutter build ipa --release --no-tree-shake-icons --dart-define="ENV_TYPE=RC"
    PROD:
        flutter build ipa --release --no-tree-shake-icons --dart-define="ENV_TYPE=PROD"


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
