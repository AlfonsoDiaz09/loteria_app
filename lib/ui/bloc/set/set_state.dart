part of 'set_bloc.dart';

@immutable
sealed class SetState {}

final class SetInitial extends SetState {}

final class SetCargado extends SetState {
  final CardSetLocal cardSetLocal;

  SetCargado({required this.cardSetLocal});
}