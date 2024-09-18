// utils/validators.dart

class Validators {
  // Valida se o campo não está vazio
  static String? validateNotEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo não pode estar vazio';
    }
    return null;
  }

  // Valida se o e-mail tem formato válido
  static String? validateEmail(String? value) {
    const emailPattern = r'^.+@.+\..+$';
    final regex = RegExp(emailPattern);
    if (value == null || !regex.hasMatch(value)) {
      return 'Insira um e-mail válido';
    }
    return null;
  }

  // Valida se a senha tem pelo menos 6 caracteres
  static String? validatePassword(String? value) {
    if (value == null || value.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres';
    }
    return null;
  }

  // Valida se a senha e a confirmação da senha são iguais
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value != password) {
      return 'As senhas não coincidem';
    }
    return null;
  }
}
