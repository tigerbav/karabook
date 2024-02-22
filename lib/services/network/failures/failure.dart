import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:karabookapp/generated/locale_keys.g.dart';

class Failure extends Equatable {
  Failure([String? errorMessage])
      : errorMessage = errorMessage ?? LocaleKeys.something_went_wrong.tr();

  /// Message to display for user
  final String errorMessage;

  factory Failure.from(dynamic e, dynamic trace) {
    debugPrint('FAILURE: $e${trace.toString().isEmpty ? '' : "\n\n$trace"}');
    return Failure();
  }

  @override
  List<Object?> get props => [errorMessage];
}
