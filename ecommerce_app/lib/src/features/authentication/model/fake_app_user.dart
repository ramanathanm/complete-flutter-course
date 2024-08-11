import 'package:ecommerce_app/src/features/authentication/model/app_user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fake_app_user.freezed.dart';
part 'fake_app_user.g.dart';

/// Fake user class used to simulate a user account on the backend
@freezed
class FakeAppUser with _$FakeAppUser {
  const factory FakeAppUser({
    required String email,
    required String uid,
    required String password,
  }) = _FakeAppUser;

  factory FakeAppUser.fromJson(Map<String, dynamic> json) => _$FakeAppUserFromJson(json);

  static AppUser toAppUser(FakeAppUser user) => AppUser( email: user.email, uid: user.uid);
}
