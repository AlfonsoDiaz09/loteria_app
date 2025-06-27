import 'package:fpdart/fpdart.dart';
import 'package:loteria_app/core/error/failure.dart';
import 'package:loteria_app/domain/set_cards/entities/set_entity.dart';

abstract interface class SetApiRepository {

  Future<Either<Failure, List<SetEntity>>> obtenerSets();
}