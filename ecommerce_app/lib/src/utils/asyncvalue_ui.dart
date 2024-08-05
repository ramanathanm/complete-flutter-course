import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ecommerce_app/src/common_widgets/alert_dialogs.dart';
import 'package:ecommerce_app/src/localization/string_hardcoded.dart';

extension AsyncvalueUi on AsyncValue {
  showAlertDialogOnError(context) {
    if (!isLoading && hasError) {
      showAlertDialog(
        context: context,
        title: 'Error'.hardcoded,
        content: error.toString(),
      );
    }
  }
}