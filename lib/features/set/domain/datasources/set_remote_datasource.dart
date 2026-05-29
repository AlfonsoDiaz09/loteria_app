import 'package:loteria_app/features/set/data/dto/set_dto.dart';

abstract interface class SetRemoteDatasource {
  Future<List<SetDto>> getSets();

  Future<List<SetDto>> getDefaultSet();
}