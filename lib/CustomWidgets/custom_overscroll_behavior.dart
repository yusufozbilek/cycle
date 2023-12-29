import 'package:flutter/material.dart';

class CustomOverscrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context,
      Widget child,
      ScrollableDetails details,
      ) {
    return GlowingOverscrollIndicator(
      axisDirection: AxisDirection.down,
      color: Colors.green, // Set the desired overscroll color here
      child: child,
    );
  }
}