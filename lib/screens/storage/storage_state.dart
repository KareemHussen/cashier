part of 'storage_cubit.dart';

@immutable
abstract class StorageState {}

class StorageInitial extends StorageState {}
class StorageLoading extends StorageState {}
class StorageSuccessful extends StorageState {}
// class StorageInitial extends StorageState {}
