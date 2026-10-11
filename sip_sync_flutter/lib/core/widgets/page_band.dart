import 'package:flutter/material.dart';

import '../theme/app_tokens.dart';

/// Centers a bar at the same max width as the page content.
class PageBand extends StatelessWidget {
  const PageBand({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      heightFactor: 1,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: AppBreakpoints.pageMax),
        child: child,
      ),
    );
  }
}
