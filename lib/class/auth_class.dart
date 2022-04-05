abstract class AuthAbstract {
  final String email = "";
  final String pw = "";
}

class SignUpInfo extends AuthAbstract {
  final String name;

  final bool isMale;

  @override
  final String email;

  @override
  final String pw;

  SignUpInfo({required this.name, required this.isMale, required this.email, required this.pw});

}

class LoginInfo extends AuthAbstract {
  @override
  final String email;

  @override
  final String pw;

  LoginInfo({required this.email, required this.pw});
}