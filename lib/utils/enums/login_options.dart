enum LoginOption { email, phone }

extension LoginOptionX on LoginOption {
  bool get isEmail => this == LoginOption.email;
  bool get isPhone => this == LoginOption.phone;
}