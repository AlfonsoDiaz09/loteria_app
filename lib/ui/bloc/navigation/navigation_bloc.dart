import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loteria_app/main.dart';
import 'package:loteria_app/ui/router/router.dart';

part 'navigation_state.dart';
part 'navigation_event.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationState.initial()) {
    on<NavigationEvent>((event, emit) {

    });

    on<NavigateTo>((event, emit) {
      emit(state.copyWith(navigateTo: event.route, isPushNavigation: event.isPush));
    });

    on<RouteChanged>((event, emit) {
      logger.i('CurrentRoute: ${event.route}');
      emit(state.copyWith(currentRoute: event.route, navigateTo: null, isPushNavigation: false));
    });
  }
}