import 'package:fpdart/fpdart.dart';
import 'package:loteria_app/core/error/failure.dart';
import 'package:loteria_app/data/set_cards/models/set_model.dart';

abstract interface class SetApiRepository {

  Future<Either<Failure, List<SetModel>>> obtenerDefaultSets();
}