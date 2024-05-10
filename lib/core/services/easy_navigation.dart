import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class EasyNavigation {
  static Future<void> push({
    required BuildContext context,
    required Widget page,
    PageTransitionType type = PageTransitionType.fade,
  }) async {
    await Navigator.push(
      context,
      PageTransition(
        child: page,
        type: type,
        duration: const Duration(microseconds: 100),
        reverseDuration: const Duration(microseconds: 100),
      ),
    );
  }
}


