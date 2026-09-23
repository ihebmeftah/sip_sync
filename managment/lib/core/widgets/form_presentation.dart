import 'package:flutter/material.dart';

import '../theme/app_tokens.dart';

/// Wide layouts keep create/edit in dialogs; compact uses full-screen routes.
bool useFormDialog(BuildContext context) {
  return MediaQuery.sizeOf(context).width >= AppBreakpoints.expanded;
}
