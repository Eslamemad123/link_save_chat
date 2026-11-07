import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<T?> pushTo<T>(BuildContext context, String route, [Object? extra]) {
  return context.push<T>(route, extra: extra);
}

void pushReplacement(
  BuildContext context,
  String route, [
  Object? extra,
]) {
  context.pushReplacement(route, extra: extra);
}

void pushAndRemoveUntil(BuildContext context, String route, [Object? extra]) {
  context.go(route, extra: extra);
}

void pop<T>(BuildContext context, [T? result]) {
  context.pop(result);
}
