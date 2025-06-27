import 'package:fpdart/fpdart.dart';
import 'package:loteria_app/core/constants/api_settings.dart';
import 'package:loteria_app/core/error/failure.dart';
import 'package:loteria_app/core/manager/client_manager.dart';
import 'package:loteria_app/data/set_cards/models/set_model.dart';
import 'package:loteria_app/domain/set_cards/entities/set_entity.dart';
import 'package:loteria_app/domain/set_cards/repositories/set_api_repository.dart';
import 'package:loteria_app/main.dart';

class SetApiRepositoryImpl implements SetApiRepository {
  final ApiSettings apiSettings;
  final ClientManager client;

  SetApiRepositoryImpl({required this.apiSettings, required this.client});

  @override
  Future<Either<Failure, List<SetEntity>>> obtenerSets() async {
    Uri uri = Uri.parse('${apiSettings.apiSupabaseUrl}/card_sets');
    logger.d("API URL: '${apiSettings.apiSupabaseUrl}/card_sets'");
    try {
      final response = await client.get(uri);
      if (response.statusCode == 200) {
        return right(setModelFromJson(response.body));
      }
      return left(Failure('Por el momento no es posible consultar los SETS'));
    } catch (e) {
      return left(Failure('Por el momento no es posible consultar los SETS $e'));
    }
  }
}