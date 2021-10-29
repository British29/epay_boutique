import 'dart:convert';

import 'package:e_pay/screens/accueil.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

bool _obscureText = true;

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _keyForm = GlobalKey<FormState>();

  void connexion() async {
    if (_keyForm.currentState!.validate()) {
      // ignore: unused_local_variable
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var url = Uri.parse(
          "http://firewall-agency.com/odilon/boutiqueFlutter/login.php");
      var reponse = await http.post(url, body: {
        "email": email.text,
        "password": password.text,
      });

      var data = json.decode(reponse.body);
      // ignore: avoid_print
      print(json.decode(reponse.body));
      if (data == 'Success') {
        sharedPreferences.setString('email', email.text);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AccueilPage(),
          ),
        );
      } else {
        Fluttertoast.showToast(
          msg: 'Email ou mot de passe incorrect',
          backgroundColor: Colors.red,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _keyForm,
          child: Center(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 110,
                ),
                Text(
                  'Connectez-vous',
                  style: TextStyle(
                      color: HexColor("#00BCD4"),
                      fontWeight: FontWeight.bold,
                      fontSize: 40),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 40, right: 40),
                  child: TextFormField(
                    controller: email,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Ce champs est vide';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.alternate_email),
                        hintText: 'Votre email'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 40, right: 40),
                  child: TextFormField(
                    controller: password,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Ce champ est vide';
                      }
                      return null;
                    },
                    autofocus: false,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      fillColor: Colors.red,
                      prefixIcon: const Icon(Icons.lock),
                      hintText: 'Mot de passe',
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          semanticLabel: _obscureText ? 'voir' : 'cacher',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: ButtonTheme(
                    buttonColor: HexColor("#00BCD4"),
                    minWidth: MediaQuery.of(context).size.width,
                    height: 55,
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      onPressed: () async {
                        connexion();
                      },
                      child: const Text(
                        'Connexion',
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 101,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
