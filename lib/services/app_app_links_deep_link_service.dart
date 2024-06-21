import "dart:async";

import "package:app_links/app_links.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/utils/app_logger.dart";
import "package:customer/utils/app_routes.dart";
import "package:customer/utils/app_session.dart";
import "package:get/get.dart";

class AppAppLinksDeepLinkService extends GetxService {
  factory AppAppLinksDeepLinkService() {
    return _singleton;
  }

  AppAppLinksDeepLinkService._internal();
  static final AppAppLinksDeepLinkService _singleton =
      AppAppLinksDeepLinkService._internal();

  final AppLinks _appLinks = AppLinks();
  late StreamSubscription<Uri> subscription;

  @override
  void onInit() {
    super.onInit();

    unawaited(initDeepLinks());
  }

  @override
  void onClose() {
    unawaited(subscription.cancel());

    super.onClose();
  }

  Future<void> initDeepLinks() async {
    final Uri appLink = await _appLinks.getInitialLink() ?? Uri();
    AppLogger().info(message: "appLinks: uri: $appLink");

    if (appLink.toString().isNotEmpty) {
      await furtherProcedure(uri: appLink);
    } else {}

    subscription = _appLinks.uriLinkStream.listen(
      (Uri event) async {
        final Uri appLink = event;

        AppLogger().info(message: "uriLinkStream: uri: $appLink");

        if (appLink.toString().isNotEmpty) {
          await furtherProcedure(uri: appLink);
        } else {}
      },
      // ignore: always_specify_types
      onError: (error, stackTrace) {
        AppLogger().error(
          message: "Exception caught",
          error: error,
          stackTrace: stackTrace,
        );
      },
      cancelOnError: false,
      onDone: () async {
        AppLogger().info(message: "initDeepLinks: subscription: onDone called");
        await subscription.cancel();
      },
    );
    return Future<void>.value();
  }

  Future<void> furtherProcedure({required Uri uri}) async {
    String route = "";
    String arguments = "";
    final bool hasLoggedIn = AppSession().isUserLoggedIn();

    if (uri.pathSegments.isNotEmpty) {
      final bool hasRoute = uri.pathSegments.asMap().containsKey(0);
      final bool hasArguments = uri.pathSegments.asMap().containsKey(1);

      if (hasRoute) {
        final bool isValidRoute = AppRoutes()
            .getPages()
            .where(
              (GetPage<dynamic> element) {
                return element.name == "/${uri.pathSegments[0]}";
              },
            )
            .toList()
            .isNotEmpty;

        if (isValidRoute) {
          route = "/${uri.pathSegments[0]}";
        } else {}
      } else {}

      if (hasArguments) {
        arguments = uri.pathSegments[1];
      } else {}
    } else {}

    if (route.isEmpty && !hasLoggedIn) {
      await AppNavService().pushNamedAndRemoveUntil(
        // destination: AppRoutes().languageSelectionScreen,
        destination: await AppSession().initialRoute(),
        arguments: <String, dynamic>{},
      );
    } else if (route.isEmpty && hasLoggedIn) {
      await AppSession().performSignIn();
    } else if (route.isNotEmpty && hasLoggedIn) {
      await AppNavService().pushNamed(
        destination: route,
        arguments: arguments.isEmpty
            ? <String, dynamic>{}
            : <String, dynamic>{"id": arguments},
      );

      await AppSession().performSignIn();
    } else if (route.isNotEmpty && !hasLoggedIn) {
      await AppNavService().pushNamedAndRemoveUntil(
        // destination: AppRoutes().languageSelectionScreen,
        destination: await AppSession().initialRoute(),
        arguments: arguments.isEmpty
            ? <String, dynamic>{}
            : <String, dynamic>{"id": arguments},
      );
    } else {}
    return Future<void>.value();
  }
}
