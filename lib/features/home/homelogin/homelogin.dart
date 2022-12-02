import 'package:flutter/material.dart';
import '../../../theme/global/colors.dart';

class HomeLogin extends StatefulWidget {
  const HomeLogin({super.key});

  @override
  State<HomeLogin> createState() => _HomeLoginState();
}

class _HomeLoginState extends State<HomeLogin> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _obscureText = true;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SizedBox(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Center(child: Image.asset('./assets/images/logo.png')),
                const SizedBox(
                  height: 20,
                ),
                const Center(
                    child: Text(
                  'Que bom te ver de novo!',
                  style: TextStyle(fontSize: 20),
                )),
                const SizedBox(
                  height: 20,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                            hintText: 'Digite seu email',
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
                          'Senha',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: _password,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            hintText: 'Digite sua senha',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: Icon(_obscureText
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
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Esqueceu a senha?',
                                textAlign: TextAlign.right,
                                style: TextStyle(color: Colors.black),
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                Navigator.pushReplacementNamed(context, 'screen');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: MyColor.darkThemeAccentColor,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(16.0)))),
                            child: const Text('ENTRAR'),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Column(children: [
                            const Text('Ou use suas redes sociais:'),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('./assets/images/facebook.png'),
                                  const SizedBox(
                                    width: 24,
                                  ),
                                  Image.asset('./assets/images/instagram.png'),
                                  const SizedBox(
                                    width: 24,
                                  ),
                                  Image.asset('./assets/images/google.png'),
                                ]),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text('Ainda não tem cadastro? Então'),
                            TextButton(
                              child: const Text('cadastre-se aqui', style: TextStyle(fontWeight: FontWeight.bold),),
                              onPressed: (){
                                 Navigator.pushNamed(context, ('signup'));
                              },
                            ),
                          ]),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
