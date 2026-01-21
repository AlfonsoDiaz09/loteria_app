import 'package:fpdart/fpdart.dart';
import 'package:loteria_app/core/error/failure.dart';
import 'package:loteria_app/core/usecase/usecase.dart';
import 'package:loteria_app/data/set_cards/models/card_model.dart';
import 'package:loteria_app/domain/set_cards/repositories/card_api_repository.dart';

class ObtenerCards implements UseCase<List<CardModel>, String> {
  final CardApiRepository cardApiRepository;

  ObtenerCards({required this.cardApiRepository});

  @override
  Future<Either<Failure, List<CardModel>>> call(String setId) async {
    return await cardApiRepository.obtenerCardsBySet(setId);
  }
}