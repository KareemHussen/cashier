

import 'package:flutter/cupertino.dart';

@immutable
abstract class MainState {}

class MainInitial extends MainState {}
class MainLoading extends MainState {}
class MainLoaded extends MainState {}
class MainError extends MainState {}
class MainChanged extends MainState {}
// class MainInitial extends MainState {}