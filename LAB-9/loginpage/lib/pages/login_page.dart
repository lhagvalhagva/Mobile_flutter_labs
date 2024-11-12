import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Нэвтрэх'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                // Лого эсвэл зураг
                const Icon(
                  Icons.account_circle,
                  size: 100,
                  color: Colors.blue,
                ),
                const SizedBox(height: 40),
                // И-мэйл оруулах талбар
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'И-мэйл',
                    hintText: 'И-мэйл хаягаа оруулна уу',
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'И-мэйл хаягаа оруулна уу';
                    }
                    if (!value.contains('@')) {
                      return 'Зөв и-мэйл хаяг оруулна уу';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // Нууц үг оруулах талбар
                TextFormField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    labelText: 'Нууц үг',
                    hintText: 'Нууц үгээ оруулна уу',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Нууц үгээ оруулна уу';
                    }
                    if (value.length < 6) {
                      return 'Нууц үг хамгийн багадаа 6 тэмдэгтэй байх ёстой';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                // Нууц үгээ мартсан
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Нууц үг сэргээх функц
                    },
                    child: const Text('Нууц үгээ мартсан?'),
                  ),
                ),
                const SizedBox(height: 24),
                // Нэвтрэх товч
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'И-мэйл: ${_emailController.text}\nНууц үг: ${_passwordController.text}',
                          ),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'НЭВТРЭХ',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 16),
                // Бүртгүүлэх холбоос
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Шинэ хэрэглэгч үү?'),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: const Text('Бүртгүүлэх'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}