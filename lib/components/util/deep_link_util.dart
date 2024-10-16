import 'dart:async';

import 'package:get/get.dart';
import 'package:uni_links/uni_links.dart';

import '../../features/detailclub/presentation/detail_club_controller.dart';
import '../config/app_route.dart';

class DeepLinkUtil {
  StreamSubscription? _sub;

  void initialDeepLinking() {
    _handleIncomingLinks();
    handleInitialLink();
  }

  Future<void> handleInitialLink() async {
    try {
      final initialLink = await getInitialLink();
      if (initialLink != null) {
        _processDeepLink(initialLink);
      }
    } catch (e) {
      print("Gagal menangkap initial link : $e");
    }
  }

  void _handleIncomingLinks() {
    _sub = uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        _processDeepLink(uri.toString());
      }
    }, onError: (err) {
      print("Gagal menangkap incoming link: $err");
    });
  }

  void _processDeepLink(String link) {
    if (Get.currentRoute != AppRoute.defaultRoute) {
      final uri = Uri.parse(link);
      if (uri.pathSegments.contains("detail_deep_link")) {
        _handleDeepLinkToDetail(uri);
      }
      if (uri.pathSegments.contains("/")) {
        Get.toNamed(AppRoute.home);
      }
    }
  }

  void _handleDeepLinkToDetail(Uri uri) {
    final id = uri.pathSegments.last;
    print('id : $id');
    print("Current route : ${Get.currentRoute}");
    if (Get.currentRoute == AppRoute.detail) {
      DetailClubController controller = Get.find<DetailClubController>();
      controller.id.value = id;
      controller.loadDetailClub(id);
    } else {
      Get.toNamed(AppRoute.detail, arguments: id);
    }
  }

  String? tapLinkWhenInTerminated(String link) {
    final uri = Uri.parse(link);
    if (uri.pathSegments.contains("detail_deep_link")) {
      final id = uri.pathSegments.last.toString();
      return id;
    } else {
      return null;
    }
  }

  Future<String?> handleInitialLinkOnTerminated() async {
    try {
      final initialLink = await getInitialLink();
      if (initialLink != null) {
        final data = tapLinkWhenInTerminated(initialLink);
        return data;
      } else {
        return null;
      }
    } catch (e) {
      print("Gagal menangkap initial link : $e");
      return null;
    }
  }

  void dispose() {
    _sub?.cancel();
  }
}
