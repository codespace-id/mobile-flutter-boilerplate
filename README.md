## DOT Flutter Base Project

design from [Figma](<https://www.figma.com/file/QyGiKfQXAlotDRcFiSqup2/PICSPILE-Social-Media-(Community)>).  
download apk file [here](https://www.dropbox.com/s/i2g4q5qtjrceyfo)

## Setup Vscode Plugin & Environment

- Launch VS Code Quick Open (Ctrl+P), paste the following command `ext install studio-cloud.asset-syncronation`, and press enter.
- run `flutter pub get`

Build with Flutter, using [Bloc Library](https://bloclibrary.dev/#/)
How to run

```
flutter run --flavor development
flutter run --flavor staging
flutter run --flavor production
```

Or choose flavour types from run and debug menu in VScode and run using CTRL+F5 shortcut or Run Without Debugging

![debug_menu](https://i.imgur.com/xRedm5Y.jpeg)

## Google Analytics

Run this command to debugging Google Analytics, so it will be shown on DebugView and Realtime Analytics in Firebase Console

```
adb shell setprop debug.firebase.analytics.app com.dot.base_flutter.dev
```

#### Dependencies

```
Flutter 3.10.1 • channel stable • https://github.com/flutter/flutter.git
Framework • revision d3d8effc68 (5 days ago) • 2023-05-16 17:59:05 -0700
Engine • revision b4fb11214d
Tools • Dart 3.0.1 • DevTools 2.23.1
```

#### Screenshot

|         ![](https://i.imgur.com/LtP9pWJ.png)         |         ![](https://i.imgur.com/ryKzwUx.png)         |         ![](https://i.imgur.com/RgRm4OQ.png)         |         ![](https://i.imgur.com/dbThLIB.png)         |
| :--------------------------------------------------: | :--------------------------------------------------: | :--------------------------------------------------: | :--------------------------------------------------: |
|         ![](https://i.imgur.com/VDbhXRf.png)         |         ![](https://i.imgur.com/WItleqV.png)         | ![](https://images2.imgbox.com/f8/30/rOFDnjO4_o.png) | ![](https://images2.imgbox.com/9b/f2/G9lAcnfm_o.png) |
| ![](https://images2.imgbox.com/92/51/6cKmRQws_o.png) | ![](https://images2.imgbox.com/ca/ff/SQfc9Yl7_o.png) | ![](https://images2.imgbox.com/cb/e4/LFqttgQZ_o.png) |                          -                           |

#### List Libraries

- [Bloc Concurency](https://pub.dev/packages/bloc_concurrency)
- [Device Preview](https://pub.dev/packages/device_preview)
- [Dio](https://pub.dev/packages/dio)
- [Easy Localization](https://pub.dev/packages/easy_localization)
- [Equatable](https://pub.dev/packages/equatable)
- [Extended Image](https://pub.dev/packages/extended_image)
- [Firebase Auth](https://pub.dev/packages/firebase_auth)
- [Firebase Core](https://pub.dev/packages/firebase_core)
- [Flutter Animate](https://pub.dev/packages/flutter_animate)
- [Flutter Bloc](https://pub.dev/packages/flutter_bloc)
- [Flutter Facebook Auth](https://pub.dev/packages/flutter_facebook_auth)
- [Flutter Local Notifications](https://pub.dev/packages/flutter_local_notifications)
- [Flutter Staggered GridView](https://pub.dev/packages/flutter_staggered_grid_view)
- [Flutter SVG](https://pub.dev/packages/flutter_svg)
- [formz](https://pub.dev/packages/formz)
- [Go Router](https://pub.dev/packages/go_router)
- [Google Sign In](https://pub.dev/packages/google_sign_in)
- [Hive](https://pub.dev/packages/hive)
- [Image Picker](https://pub.dev/packages/image_picker)
- [Image Cropper](https://pub.dev/packages/image_cropper)
- [Package Info Plus](https://pub.dev/packages/package_info_plus)
- [Path Provider](https://pub.dev/packages/path_provider)
- [Permission Handler](https://pub.dev/packages/permission_handler)
- [Sentry](https://pub.dev/packages/sentry)
- [Shared Preference](https://pub.dev/package/shared_preferences)
- [Smooth Page Indicator](https://pub.dev/packages/smooth_page_indicator)
- [Stream Transform](https://pub.dev/packages/stream_transform)
- [HTTP Mock Adapter](https://pub.dev/packages/http_mock_adapter)
- [Device Info Plus](https://pub.dev/packages/device_info_plus)

#### References

- [Medium](https://medium.com/@animeshjain/build-flavors-in-flutter-android-and-ios-with-different-firebase-projects-per-flavor-27c5c5dac10b)
- [Medium](https://medium.com/flutter-community/flutter-ready-to-go-e59873f9d7de)
- [bloclibrary.dev](https://bloclibrary.dev/#/flutterinfinitelisttutorial)
- [Flutter Animate](https://blog.gskinner.com/archives/2022/09/introducing-flutter-animate.html)
- [Flutter Switch Theme Mode](https://www.youtube.com/watch?v=4gA-5qhSJfM&ab_channel=NitishKumarSingh)
