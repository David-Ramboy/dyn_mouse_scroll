import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'scroll_state.dart';

class DynMouseScroll extends StatelessWidget {
  final ScrollPhysics mobilePhysics;
  final int durationMS;
  final Function(BuildContext, ScrollController, ScrollPhysics) builder;
  final double changeFuturePosition;

  const DynMouseScroll({
    super.key,
    this.mobilePhysics = kMobilePhysics,
    this.durationMS = 200,
    required this.builder,
    required this.changeFuturePosition,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ScrollState>(
        create: (context) =>
            ScrollState(mobilePhysics, durationMS, changeFuturePosition),
        builder: (context, _) {
          final scrollState = context.read<ScrollState>();
          final controller = scrollState.controller;
          final physics = context.select((ScrollState s) => s.physics);
          return Listener(
            onPointerSignal: scrollState.handleDesktopScroll,
            onPointerDown: scrollState.handleTouchScroll,
            child: builder(context, controller, physics),
          );
        });
  }
}
