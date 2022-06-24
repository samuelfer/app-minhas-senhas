import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:minhas_senhas/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  bool _verSenha = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.stretch, //Deixa tudo bem largo
              children: [
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    label: Text('E-mail'),
                    hintText: 'seuemail@mail.com',
                  ),
                  validator: (email) {
                    if (email == null || email.isEmpty) {
                      print('Entrei');
                      return 'Digite seu email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _senhaController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !_verSenha,
                  decoration: InputDecoration(
                    label: Text('Senha'),
                    hintText: '*********',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _verSenha
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_off_outlined,
                      ),
                      onPressed: () {
                        setState(() {
                          _verSenha = !_verSenha;
                        });
                      },
                    ),
                  ),
                  validator: (senha) {
                    if (senha == null || senha.isEmpty || senha.length < 5) {
                      return 'Digite sua senha';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      logar();
                    }
                  },
                  child: const Text('Entrar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  logar() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();

    var url = Uri.parse('ulr');
    var response = await http.post(url,
        body: {'username': _emailController, 'password': _senhaController});

    if (response.statusCode == 200) {
      String token = json.decode(response.body)['token'];
      await _sharedPreferences.setString('token', 'Token $token');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('E-mail ou senha inválidos'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
