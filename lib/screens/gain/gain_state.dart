part of 'gain_cubit.dart';

@immutable
abstract class GainState {}

class GainInitial extends GainState {}
class GainLoading extends GainState {}
class Gain2Loading extends GainState {}
class GainSuccessful extends GainState {}
class Gain2Successful extends GainState {}
class GainReset extends GainState {}

// class StorageInitial extends StorageState {}
