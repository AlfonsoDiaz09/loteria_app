import 'dart:convert';

import 'package:loteria_app/core/constants/api_settings.dart';
import 'package:loteria_app/core/manager/client_manager.dart';
import 'package:loteria_app/features/card/data/dto/card_dto.dart';
import 'package:loteria_app/features/card/domain/datasources/card_remote_datasource.dart';

class CardRemoteDatasourceImpl implements CardRemoteDatasource {
  final ApiSettings apiSettings;
  final ClientManager client;

  CardRemoteDatasourceImpl({required this.apiSettings, required this.client});

  @override
  Future<List<CardDto>> getCardsBySet(String setId) async {
    final uri = Uri.parse(
        '${apiSettings.apiSupabaseUrl}/cards?set_id=eq.$setId');

    final response = await client.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return CardDto.fromList(data);
    } else {
      throw Exception('Error fetching cards');
    }
  }

  @override
  Future<void> createCards(List<Map<String, dynamic>> request) async {
    final uri = Uri.parse('${apiSettings.apiSupabaseUrl}/cards');

    final response = await client.post(
      uri,
      body: jsonEncode(request),
    );

    if (response.statusCode != 200) {
      throw Exception('Error creating cards');
    }
  }

  @override
  Future<void> updateCard(CardDto dto) async {
    final uri = Uri.parse('${apiSettings.apiSupabaseUrl}/cards?id=eq.${dto.id}');

    await client.patch(uri, body: jsonEncode(dto.toJson()));
  }
}