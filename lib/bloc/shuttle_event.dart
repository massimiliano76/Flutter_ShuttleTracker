part of 'shuttle_bloc.dart';

abstract class ShuttleEvent extends Equatable {
  const ShuttleEvent();
}

class GetShuttleMap extends ShuttleEvent {
  const GetShuttleMap();
  @override
  List<Object> get props => null;
}