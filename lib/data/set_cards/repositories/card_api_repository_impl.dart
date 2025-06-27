import 'package:fpdart/src/either.dart';
import 'package:loteria_app/core/constants/api_settings.dart';
import 'package:loteria_app/core/error/failure.dart';
import 'package:loteria_app/core/manager/client_manager.dart';
import 'package:loteria_app/data/set_cards/models/card_model.dart';
import 'package:loteria_app/domain/set_cards/repositories/card_api_repository.dart';
import 'package:loteria_app/main.dart';

class CardApiRepositoryImpl implements CardApiRepository {
  final ApiSettings apiSettings;
  final ClientManager client;

  CardApiRepositoryImpl({required this.apiSettings, required this.client});

  @override
  Future<Either<Failure, List<CardModel>>> obtenerCardsBySet(String setId) async {
    Uri uri = Uri.parse('${apiSettings.apiSupabaseUrl}/cards?set_id=eq.$setId');
    logger.d("API URL: '${apiSettings.apiSupabaseUrl}/cards?set_id=eq.$setId'");
    try {
      final response = await client.get(uri);
      if (response.statusCode == 200) {
        return right(cardModelFromJson(response.body));
      }
      return left(Failure('Por el momento no es posible consultar las CARDS'));
    } catch (e) {
      return left(Failure('Por el momento no es posible consultar las CARDS $e'));
    }
  }
}