import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:loteria_app/core/constants/api_settings.dart';
import 'package:loteria_app/core/manager/client_manager.dart';
import 'package:loteria_app/data/set_cards/repositories/card_api_repository_impl.dart';
import 'package:loteria_app/data/set_cards/repositories/set_api_repository_impl.dart';
import 'package:loteria_app/domain/set_cards/repositories/card_api_repository.dart';
import 'package:loteria_app/domain/set_cards/repositories/set_api_repository.dart';
import 'package:loteria_app/domain/set_cards/usecases/obtener_cards.dart';
import 'package:loteria_app/domain/set_cards/usecases/obtener_default_sets.dart';
import 'package:loteria_app/features/game/presentation/bloc/deck/deck_bloc.dart';
import 'package:loteria_app/app/bloc/navigation/navigation_bloc.dart';
import 'package:loteria_app/features/game/presentation/bloc/timer/timer_bloc.dart';

import 'features/set/presentation/bloc/set/set_bloc.dart';

part 'init_dependencies.main.dart';