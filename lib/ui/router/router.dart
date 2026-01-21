import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:loteria_app/ui/bloc/navigation/navigation_bloc.dart';
import 'package:loteria_app/ui/pages/game_page/game_page.dart';

final GlobalKey<NavigatorState>navigatorKey = GlobalKey();

abstract class AppRoutes {
  static const game = '/game';
}

abstract class LoaderIds {
  static const gameLoader = 'game_loader';
}

GoRouter createRouter(NavigationBloc navigationBloc) {
  final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: AppRoutes.game,
    routes: [
      GoRoute(
        path: AppRoutes.game,
        name: AppRoutes.game,
        builder: (_, __) => GamePage(),
      ),
    ]
  );

  router.routerDelegate.addListener(() {
    final currentName = router.state.name;
    if (currentName != null) {
      navigationBloc.add(RouteChanged(currentName));
    }
  });

  return router;
}