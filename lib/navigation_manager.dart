import 'package:flutter/material.dart';
import 'package:flutter_packages/hero_navigation.dart';
import 'package:flutter_packages/routes.dart';
import 'package:flutter_packages/screens/animated_opacity_task.dart';
import 'package:flutter_packages/screens/cached_network.dart';
import 'package:flutter_packages/screens/form_screen.dart';
import 'package:flutter_packages/screens/hero_animation.dart';
import 'package:flutter_packages/screens/image_package.dart';
import 'package:flutter_packages/screens/image_store.dart';
import 'package:flutter_packages/screens/info_package.dart';
import 'package:flutter_packages/screens/intl_package.dart';
import 'package:flutter_packages/screens/launch_url.dart';
import 'package:flutter_packages/screens/loading_package.dart';
import 'package:flutter_packages/screens/local_auth_task.dart';
import 'package:flutter_packages/screens/location_page.dart';
import 'package:flutter_packages/screens/phone_screen.dart';
import 'package:flutter_packages/screens/picker_file.dart';
import 'package:flutter_packages/screens/picker_image.dart';
import 'package:flutter_packages/screens/pin_code_screen.dart';
import 'package:flutter_packages/screens/player_video.dart';
import 'package:flutter_packages/screens/sliver_task.dart';
import 'package:flutter_packages/screens/store_file.dart';
import 'package:flutter_packages/screens/stored_data.dart';
import 'package:flutter_packages/screens/tween_animation.dart';
import 'package:flutter_packages/shimmer_task.dart';

class NavigationManager {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.pickerImage:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const PickerImage(),
        );
      case Routes.imagePackage:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const ImagePackage(),
        );
      case Routes.playerVideo:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const PlayerVideo(),
        );
      case Routes.pickerFile:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const PickerFile(),
        );
      case Routes.launchUrl:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const LaunchUrl(),
        );
      case Routes.cachedNetwork:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const CachedNetwork(),
        );
      case Routes.locationPage:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const LocationPage(),
        );
      case Routes.loadingCustom:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const LoadingCustom(),
        );
      case Routes.infoPackages:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const InfoPackages(),
        );
      case Routes.storeFile:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const StoreFile(),
        );
      case Routes.intlPackage:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const IntlPackage(),
        );
      case Routes.tweenAnimation:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const TweenAnimation(),
        );
      case Routes.heroAnimation:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const HeroAnimation(),
        );
      case Routes.animatedOpacityTask:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const AnimatedOpacityTask(),
        );
      case Routes.localAuthTask:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const LocalAuthTask(),
        );
      case Routes.sliverTask:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const SliverTask(),
        );
      case Routes.shimmerTask:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const ShimmerTask(),
        );
      case Routes.phoneScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const PhoneScreen(),
        );
      case Routes.formScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const FormScreen(),
        );
      case Routes.heroNavigation:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const HeroNavigation(),
        );
      case Routes.storedData:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const StoredData(),
        );
      case Routes.imageStore:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const ImageStore(),
        );
      case Routes.pinCodeScreen:
        Map<String, dynamic>? args =
            settings.arguments as Map<String, dynamic>?;
        final currentText = args!['currentText'];
        final verificationId = args['verificationId'];
        final phoneNumber = args['phoneNumber'];
        return MaterialPageRoute(
            settings: settings,
            builder: (context) => PinCodeScreen(
                  currentText: currentText,
                  verificationId: verificationId,
                  phoneNumber: phoneNumber,
                ));
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() =>
      MaterialPageRoute(builder: (_) => const ImagePackage());
}
