part of 'home_bloc.dart';

@immutable
abstract class _HomeEvent {
  const _HomeEvent();
}

class _DateChangedEvent extends _HomeEvent {
  final DateTime date;
  const _DateChangedEvent(this.date);
}

class _SwapEvent extends _HomeEvent {
  const _SwapEvent();
}

class _SearchEvent extends _HomeEvent {
  final BuildContext context;
  const _SearchEvent(this.context);
}

class _UpdateFavorites extends _HomeEvent {
  const _UpdateFavorites();
}

class _RemoveFavoriteEvent extends _HomeEvent {
  final Ride ride;
  const _RemoveFavoriteEvent(this.ride);
}

class _ReorderFavoritesEvent extends _HomeEvent {
  final int oldIndex;
  final int newIndex;
  const _ReorderFavoritesEvent(this.oldIndex, this.newIndex);
}

class _FromChangedEvent extends _HomeEvent {
  const _FromChangedEvent();
}

class _DestinationChangedEvent extends _HomeEvent {
  const _DestinationChangedEvent();
}
