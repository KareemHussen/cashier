

import 'package:flutter/cupertino.dart';

@immutable
abstract class ExampleState {}

class ExampleInitial extends ExampleState {}
class ExampleLoading extends ExampleState {}
class ExampleLoaded extends ExampleState {}
class ExampleError extends ExampleState {}
class ExampleChanged extends ExampleState {}
// class ExampleInitial extends ExampleState {}