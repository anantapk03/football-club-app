// ignore_for_file: unused_import

import 'package:get/get_navigation/src/routes/get_route.dart';

import '../../features/detailclub/binding/detail_club_binding.dart';
import '../../features/detailclub/presentation/detail_club_screen.dart';
import '../../features/favorite/binding/favorite_binding.dart';
import '../../features/favorite/presentation/favorite_screen.dart';
import '../../features/navigation/binding/bottomnavigation_binding.dart';
import '../../features/navigation/presentation/bottom_navigation_screen.dart';
import '../../features/profile/binding/profile_binding.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';
import '../../features/teams/binding/team_binding.dart';
import '../../features/teams/presentation/team_screen.dart';
import '../../main.dart';

class AppRoute {
  static const String defaultRoute = '/';
  static const String notFound = '/notFound';
  static const String registerScreen = '/registerScreen';
  static const String loginScreen = '/loginScreen';
  static const String dummy = '/dummy';
  static const String listTeam = '/listTeam';
  static const String listCountry = '/listCountry';
  static const String home = '/home';
  static const String detail = '/detail';
  static const String favorite = '/favorite';
  static const String detailDeepLink = '/detail_deep_link';
  static const String profile = '/profile';

  static List<GetPage> pages = [
    GetPage(name: defaultRoute, page: () => const SplashScreen()),
    GetPage(
        name: listTeam, page: () => const TeamScreen(), binding: TeamBinding()),
    // GetPage(name: listCountry, page: ()=> const CountryScreen(), binding: CountryBinding()),
    GetPage(
        name: detail,
        page: () => const DetailClubScreen(),
        binding: DetailClubBinding()),
    GetPage(
        name: home,
        page: () => const BottomNavigationScreen(),
        binding: BottomnavigationBinding()),
    GetPage(
        name: favorite,
        page: () => const FavoriteScreen(),
        binding: FavoriteBinding()),
    GetPage(
        name: detailDeepLink,
        page: () => const DetailClubScreen(),
        binding: DetailClubBinding()),
    GetPage(
        name: profile,
        page: () => const ProfileScreen(),
        binding: ProfileBinding())
  ];
}
