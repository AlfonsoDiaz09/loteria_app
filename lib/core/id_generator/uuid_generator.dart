import 'package:uuid/uuid.dart';
import 'id_generator.dart';

class UuidGenerator implements IdGenerator {
  final Uuid _uuid;

  const UuidGenerator(this._uuid);

  @override
  String generate() => _uuid.v4();
}
