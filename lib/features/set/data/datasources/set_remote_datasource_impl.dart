import 'dart:convert';

import 'package:loteria_app/core/constants/api_settings.dart';
import 'package:loteria_app/core/manager/client_manager.dart';
import 'package:loteria_app/features/set/data/dto/set_dto.dart';
import 'package:loteria_app/features/set/domain/datasources/set_remote_datasource.dart';

class SetRemoteDatasourceImpl implements SetRemoteDatasource {
  final ApiSettings apiSettings;
  final ClientManager client;

  SetRemoteDatasourceImpl({required this.apiSettings, required this.client});

  @override
  Future<List<SetDto>> getSets() async {
    final uri = Uri.parse(
        '${apiSettings.apiSupabaseUrl}/card_sets');

    final response = await client.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return SetDto.fromList(data);
    } else {
      throw Exception('Error fetching sets');
    }
  }

  @override
  Future<List<SetDto>> getDefaultSet() async {
    final uri = Uri.parse(
        '${apiSettings.apiSupabaseUrl}/card_sets?is_default=eq.true');

    final response = await client.get(uri);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return SetDto.fromList(data);
    } else {
      throw Exception('Error fetching sets');
    }
  }
}