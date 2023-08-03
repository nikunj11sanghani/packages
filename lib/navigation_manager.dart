import 'package:flutter/material.dart';
import 'package:flutter_packages/hero_navigation.dart';
import 'package:flutter_packages/routes.dart';
import 'package:flutter_packages/screens/animated_opacity_task.dart';
import 'package:flutter_packages/screens/cached_network.dart';
import 'package:flutter_packages/screens/hero_animation.dart';
import 'package:flutter_packages/screens/image_package.dart';
import 'package:flutter_packages/screens/image_store.dart';
import 'package:flutter_packages/screens/info_package.dart';
import 'package:flutter_packages/screens/intl_package.dart';
import 'package:flutter_packages/screens/isolate_threads/isolate_screen.dart';
import 'package:flutter_packages/screens/isolate_threads/list_view_task.dart';
import 'package:flutter_packages/screens/isolate_threads/sliver_performance.dart';
import 'package:flutter_packages/screens/isolate_threads/sliver_task.dart';
import 'package:flutter_packages/screens/isolate_threads/smooth_page_indicator_task.dart';
import 'package:flutter_packages/screens/isolate_threads/staggered_grid_view_task.dart';
import 'package:flutter_packages/screens/isolate_threads/thread_screen.dart';
import 'package:flutter_packages/screens/launch_url.dart';
import 'package:flutter_packages/screens/loading_package.dart';
import 'package:flutter_packages/screens/local_auth_task.dart';
import 'package:flutter_packages/screens/location_page.dart';
import 'package:flutter_packages/screens/picker_file.dart';
import 'package:flutter_packages/screens/player_video.dart';
import 'package:flutter_packages/screens/sqflite_task/add_data.dart';
import 'package:flutter_packages/screens/sqflite_task/data_screen.dart';
import 'package:flutter_packages/screens/store_file.dart';
import 'package:flutter_packages/screens/stored_data.dart';
import 'package:flutter_packages/screens/tween_animation.dart';
import 'package:flutter_packages/shimmer_task.dart';

class NavigationManager {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.imagePackage:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return const ImagePackage();
          },
        );
      case Routes.playerVideo:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return const PlayerVideo();
          },
        );
      case Routes.pickerFile:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return const PickerFile();
          },
        );
      case Routes.launchUrl:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return const LaunchUrl();
          },
        );
      case Routes.cachedNetwork:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return const CachedNetwork();
          },
        );
      case Routes.locationPage:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return const LocationPage();
          },
        );
      case Routes.loadingCustom:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return const LoadingCustom();
          },
        );
      case Routes.infoPackages:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return const InfoPackages();
          },
        );
      case Routes.storeFile:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return const StoreFile();
          },
        );
      case Routes.intlPackage:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return const IntlPackage();
          },
        );
      case Routes.tweenAnimation:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return const TweenAnimation();
          },
        );
      case Routes.heroAnimation:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return const HeroAnimation();
          },
        );
      case Routes.animatedOpacityTask:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return const AnimatedOpacityTask();
          },
        );
      case Routes.localAuthTask:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return const LocalAuthTask();
          },
        );
      case Routes.sliverTask:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return const SliverTask();
          },
        );
      case Routes.shimmerTask:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return const ShimmerTask();
          },
        );
      case Routes.isolateScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return const IsolateScreen();
          },
        );
      case Routes.threadScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return const ThreadScreen();
          },
        );
      case Routes.smoothPageIndicatorTask:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return const SmoothPageIndicatorTask();
          },
        );
      case Routes.staggeredGridViewTask:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return const StaggeredGridViewTask();
          },
        );
      case Routes.listViewExample:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return const ListViewExample();
          },
        );
      case Routes.sliverPerformance:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return const SliverPerformance();
          },
        );
      case Routes.heroNavigation:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return const HeroNavigation();
          },
        );
      case Routes.storedData:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return const StoredData();
          },
        );
      case Routes.imageStore:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return const ImageStore();
          },
        );
      case Routes.addData:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return AddData();
          },
        );
      case Routes.dataScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return const DataScreen();
          },
        );
      default:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
