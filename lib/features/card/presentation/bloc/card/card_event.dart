part of 'card_bloc.dart';

@immutable
sealed class CardEvent {}

class SearchCards extends CardEvent {
  final String setId;

  SearchCards({required this.setId});
}