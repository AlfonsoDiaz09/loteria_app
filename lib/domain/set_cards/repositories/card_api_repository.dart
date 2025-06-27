import 'package:fpdart/fpdart.dart';
import 'package:loteria_app/core/error/failure.dart';
import 'package:loteria_app/data/set_cards/models/card_model.dart';

abstract interface class CardApiRepository {

  Future<Either<Failure, List<CardModel>>> obtenerCardsBySet(String setId);
}