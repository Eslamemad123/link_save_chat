import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future pushTo(BuildContext context, String route, [Object? extra]) {
  return context.push(route, extra: extra);
}

pushReplacement(BuildContext context, String route, [Object? extra]) {
  return context.pushReplacement(route, extra: extra);
}

PupushAndRemoveUntilsh(BuildContext context, String route, [Object? extra]) {
  return context.go(route, extra: extra);
}

Pop(BuildContext context) {
  return context.pop();
}
