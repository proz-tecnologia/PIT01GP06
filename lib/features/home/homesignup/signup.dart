import 'package:flutter/material.dart';
import 'package:projeto_final_flutter/features/home/homesignup/signup_controller.dart';

import '../../../theme/global/colors.dart';
import 'signup_repository.dart';
import 'signup_state.dart';

class HomeSignup extends StatefulWidget {
  const HomeSignup({super.key});

  @override
  State<HomeSignup> createState() => _HomeSignupState();
}

class _HomeSignupState extends State<HomeSignup> {
  final controller = SignUpController(HomeSignupRepository());
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nome = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    controller.notifier.addListener(() {
      if (controller.state is SignupStateError) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Erro no cadastro. Tente novamente!')));
      }
      if (controller.state is SignupStateSuccess) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/login', (route) => false);
      }
    });
  }

  @override
  void dispose() {
    _nome.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              const Text(
                  'Boas vindas! Informe seus dados abaixo para fazermos o seu cadastro.'),
              const SizedBox(
                height: 20,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Nome completo',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: _nome,
                        decoration: InputDecoration(
                          hintText: 'Insira seu nome e sobrenome',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Campo obrigatório.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Email',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: _email,
                        decoration: InputDecoration(
                          hintText: 'email@email.com',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value != null && value.isNotEmpty) {
                            if (!value.contains('@') || value.length < 8) {
                              return "Digite um email válido";
                            }
                          } else {
                            return "Campo obrigatório.";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Defina sua Senha',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: _password,
                        obscureText: _obscureTextPassword,
                        decoration: InputDecoration(
                          hintText: 'Use no mínimo 6 caracteres',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureTextPassword = !_obscureTextPassword;
                              });
                            },
                            child: Icon(_obscureTextPassword
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Informe a sua senha.';
                          } else if (value.length < 6) {
                            return 'Sua senha deve ter no mínimo 6 caracteres';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Confirme sua Senha',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: _confirmPassword,
                        obscureText: _obscureTextConfirmPassword,
                        decoration: InputDecoration(
                          hintText: 'Repita a senha definida acima',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureTextConfirmPassword =
                                    !_obscureTextConfirmPassword;
                              });
                            },
                            child: Icon(_obscureTextConfirmPassword
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                        ),
                        validator: (value) {
                          if (value != _password.text) {
                            return "As senhas digitadas não são iguais";
                          } else if (value!.isEmpty) {
                            return 'Informe a sua senha.';
                          } else if (value.length < 6) {
                            return 'Sua senha deve ter no mínimo 6 caracteres';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      MyColor.lightThemeBackgroundColor,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)))),
                              child: const Text(
                                'VOLTAR',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  controller.register(
                                      _nome.text, _email.text, _password.text);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: MyColor.darkThemeAccentColor,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)))),
                              child: const Text('CONTINUAR'),
                            ),
                          ],
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
