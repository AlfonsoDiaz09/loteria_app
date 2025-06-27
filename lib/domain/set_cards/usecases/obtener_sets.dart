import 'package:fpdart/fpdart.dart';
import 'package:loteria_app/core/error/failure.dart';
import 'package:loteria_app/core/usecase/usecase.dart';
import 'package:loteria_app/domain/set_cards/entities/set_entity.dart';
import 'package:loteria_app/domain/set_cards/repositories/set_api_repository.dart';

class ObtenerSets implements UseCase<List<SetEntity>, NoParams> {
  final SetApiRepository setApiRepository;

  ObtenerSets({required this.setApiRepository});

  @override
  Future<Either<Failure, List<SetEntity>>> call(NoParams params) async {
    return await setApiRepository.obtenerSets();
  }
}