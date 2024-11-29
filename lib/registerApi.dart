import 'package:flutter/material.dart';
import 'package:application_musique/api/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _lastNameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _adressController = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _cityController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _agreeToTerms = false;
  @override
  void dispose() {
    _lastNameController.dispose();
    _firstNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );
      try {
        // ignore: avoid_print
        print(
            "${_firstNameController.text}, ${_lastNameController.text},${_emailController.text},${_passwordController.text} ");
        int result = await registerUser(
            _firstNameController.text,
            _lastNameController.text,
            _emailController.text,
            _passwordController.text,
            ["user"]);
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
        if (result == 201) {
          const user = FlutterSecureStorage();
          await user.write(key: 'name', value: _firstNameController.text);
          await user.write(key: 'lastName', value: _lastNameController.text);
          await user.write(key: 'email', value: _emailController.text);
          await user.write(key: 'password', value: _passwordController.text);
          await user.write(key: 'adress', value: _adressController.text);
          await user.write(
              key: 'postalCode', value: _postalCodeController.text);
          await user.write(key: 'city', value: _cityController.text);
          showDialog(
            // ignore: use_build_context_synchronously
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Inscription réussie'),
              content: Text(
                  'Bonjour, ${_firstNameController.text} ${_lastNameController.text}!'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () => {
                    Navigator.of(context).pop(),
                    Navigator.of(context).pushReplacementNamed('/')
                  },
                ),
              ],
            ),
          );
        } else {
          showDialog(
            // ignore: use_build_context_synchronously
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Échec de l\'inscription'),
              content: Text(
                  'Une erreur est survenue: ${result.toString()}. Veuillez réessayer.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          );
        }
      } catch (e) {
        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Erreur'),
            content: Text('Erreur lors de l\'inscription: $e'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _lastNameController,
              decoration: const InputDecoration(
                labelText: 'Nom',
                border: OutlineInputBorder(),
                errorStyle: TextStyle(color: Color.fromARGB(255, 196, 43, 160)),
                errorBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 196, 43, 160)),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 196, 43, 160)),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer votre nom';
                } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                  return 'Veuillez n\'utiliser que des lettres';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _firstNameController,
              decoration: const InputDecoration(
                labelText: 'Prénom',
                border: OutlineInputBorder(),
                errorStyle: TextStyle(color: Color.fromARGB(255, 196, 43, 160)),
                errorBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 196, 43, 160)),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 196, 43, 160)),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer votre prénom';
                } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                  return 'Veuillez n\'utiliser que des lettres';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _adressController,
              decoration: const InputDecoration(
                labelText: 'Adresse',
                border: OutlineInputBorder(),
                errorStyle: TextStyle(color: Color.fromARGB(255, 196, 43, 160)),
                errorBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 196, 43, 160)),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 196, 43, 160)),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer votre adresse';
                } else if (!RegExp(r'^[a-zA-Z0-9\s,\\-]+$').hasMatch(value)) {
                  return 'Veuillez entrer une adresse valide (lettres, chiffres, espaces, virgules, tirets et apostrophes seulement)';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _postalCodeController,
              decoration: const InputDecoration(
                labelText: 'Code Postal',
                border: OutlineInputBorder(),
                errorStyle: TextStyle(color: Color.fromARGB(255, 196, 43, 160)),
                errorBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 196, 43, 160)),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 196, 43, 160)),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer votre code postal';
                } else if (!RegExp(r'^\d{5}$').hasMatch(value)) {
                  return 'Veuillez entrer un code postal valide (5 chiffres)';
                }

                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _cityController,
              decoration: const InputDecoration(
                labelText: 'Ville',
                border: OutlineInputBorder(),
                errorStyle: TextStyle(color: Color.fromARGB(255, 196, 43, 160)),
                errorBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 196, 43, 160)),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 196, 43, 160)),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer votre ville';
                } else if (!RegExp(r'^[a-zA-ZÀ-ÖØ-öø-ÿ\s\\-]+$').hasMatch(value)) {
                  return 'Veuillez entrer un nom de ville valide (lettres, espaces, tirets ou apostrophes uniquement)';
                }

                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer un email';
                } else if (!RegExp(
                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                    .hasMatch(value)) {
                  return 'Veuillez entrer un email valide';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Mot de passe',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer un mot de passe';
                }
                if (value.length < 12) {
                  return 'Le mot de passe doit contenir au moins 12 caractères';
                }
                if (!RegExp(r'(?=.*[a-z])').hasMatch(value)) {
                  return 'Le mot de passe doit contenir au moins une minuscule';
                }
                if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
                  return 'Le mot de passe doit contenir au moins une majuscule';
                }
                if (!RegExp(r'(?=.*\d)').hasMatch(value)) {
                  return 'Le mot de passe doit contenir au moins un chiffre';
                }
                if (!RegExp(r'(?=.*[\W])').hasMatch(value)) {
                  // \W signifie tout caractère qui n'est pas une lettre ou un chiffre
                  return 'Le mot de passe doit contenir au moins un caractère spécial';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _confirmPasswordController,
              decoration: const InputDecoration(
                labelText: 'Confirmez le mot de passe',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez confirmer votre mot de passe';
                } else if (value != _passwordController.text) {
                  return 'Les mots de passe ne correspondent pas';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            CheckboxListTile(
              title: const Text('Accepter les termes et conditions'),
              value: _agreeToTerms,
              onChanged: (bool? newValue) {
                setState(() {
                  _agreeToTerms = newValue!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _agreeToTerms ? _submitForm : null,
              child: const Center(child: Text('S\'inscrire')),
            ),
          ],
        ),
      ),
    );
  }
}
