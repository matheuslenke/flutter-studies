class Pessoa {
  String? nome;
  String? _cpf;

  String? get cpf {
    return _cpf;
  }

  set cpf(String? novoCPF) {
    this._cpf = novoCPF;
  }
}
