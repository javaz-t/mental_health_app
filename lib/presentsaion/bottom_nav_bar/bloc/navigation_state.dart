part of 'navigation_bloc.dart';

@immutable
abstract class NavigationState {}

class NavigationInitial extends NavigationState {}

class NavigationChanged extends NavigationState{
final int index;
NavigationChanged({required this.index});
}
