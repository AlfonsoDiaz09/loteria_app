import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loteria_app/core/logs/logger_output.dart';
import 'package:loteria_app/init_dependencies.dart';
import 'package:loteria_app/ui/bloc/navigation/navigation_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:loteria_app/ui/router/router.dart';
import 'package:loteria_app/ui/theme/app_theme.dart';
import 'package:loteria_app/ui/utils/dimention_size.dart';

var logger = LoggerOutput().logger;

void main() async {
  await initDependencies();

  final navigationBloc = serviceLocator<NavigationBloc>();
  final routerconfig = createRouter(navigationBloc);

  runApp(MyApp(router: routerconfig));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.router});

  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    DimentionSize.init(context);
    return OrientationBuilder(
      builder: (context, orientation) {
        DimentionSize.isInitialized = false;
        DimentionSize.init(context);
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => serviceLocator<NavigationBloc>()),
          ],
          child: MaterialApp.router(
              title: 'LoteriaApp',
              theme: AppTheme.darkTheme(context),
              routerConfig: router,
            ),
        );
      }
    );
  }
}
