import 'package:fpdart/fpdart.dart';
import 'package:loteria_app/core/error/failure.dart';
import 'package:loteria_app/features/set/domain/entities/set_entity.dart';

import '../repositories/set_repository.dart';

class GetAllSets {
  final SetRepository repository;

  GetAllSets({required this.repository});

  Future<Either<Failure, List<SetEntity>>> call() {
    return repository.getSets();
  }
}