import 'package:ecommerce_app/src/features/authentication/ui/sign_in/email_password_signin_type.dart';
import 'package:ecommerce_app/src/features/authentication/ui/sign_in/string_validators.dart';
import 'package:ecommerce_app/src/localization/string_hardcoded.dart';

/// Form type for email & password authentication

/// Mixin class to be used for client-side email & password validation
mixin EmailAndPasswordValidators {
  final StringValidator emailSubmitValidator = EmailSubmitRegexValidator();
  final StringValidator passwordRegisterSubmitValidator = MinLengthStringValidator(5);
  final StringValidator passwordSignInSubmitValidator = MinLengthStringValidator(5);

  bool canSubmitEmail(String email) {
    return emailSubmitValidator.isValid(email);
  }

  bool canSubmitPassword(String password, EmailPasswordSignInFormType formType) {
    if (formType == EmailPasswordSignInFormType.register) {
      return passwordRegisterSubmitValidator.isValid(password);
    }
    return passwordSignInSubmitValidator.isValid(password);
  }

  String? emailErrorText(String email) {
    final bool showErrorText = !canSubmitEmail(email);
    final String errorText = email.isEmpty ? 'Email can\'t be empty'.hardcoded : 'Invalid email'.hardcoded;
    return showErrorText ? errorText : null;
  }

  String? passwordErrorText(String password, EmailPasswordSignInFormType formType) {
    final bool showErrorText = !canSubmitPassword(password, formType);
    final String errorText =
        password.isEmpty ? 'Password can\'t be empty'.hardcoded : 'Password is too short'.hardcoded;
    return showErrorText ? errorText : null;
  }
}

