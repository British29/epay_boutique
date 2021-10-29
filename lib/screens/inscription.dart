import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:e_pay/screens/login.dart';

class InscriptionPage extends StatefulWidget {
  const InscriptionPage({Key? key}) : super(key: key);

  @override
  _InscriptionPageState createState() => _InscriptionPageState();
}

String pswd = '';
String confPswd = '';
bool _obscureText = true;

class _InscriptionPageState extends State<InscriptionPage> {
  final _keyForm = GlobalKey<FormState>();
  TextEditingController nomPrenom = TextEditingController();
  TextEditingController adresse = TextEditingController();
  TextEditingController numero = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController motDePasse = TextEditingController();

  Future inscrption() async {
    if (_keyForm.currentState!.validate()) {
      var url = Uri.parse(
          "http://firewall-agency.com/odilon/boutiqueFlutter/register.php");
      var reponse = await http.post(url, body: {
        "nom": nomPrenom.text,
        "adresse": adresse.text,
        "numero": numero.text,
        "email": email.text,
        "password": motDePasse.text,
      });
      var data = json.decode(reponse.body);
      // ignore: avoid_print
      print(json.decode(reponse.body));
      if (data == 'Error') {
        Fluttertoast.showToast(
          msg: 'Inscription a échoué',
          backgroundColor: Colors.red,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        //  ignore: avoid_print
        print('inscription reussie');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _keyForm,
            child: Column(
              children: <Widget>[
                Text(
                  'Inscription',
                  style: TextStyle(
                      color: HexColor("#00BCD4"),
                      fontWeight: FontWeight.bold,
                      fontSize: 40),
                ),
                // const SizedBox(
                //   height: 10,
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 50, right: 50),
                  child: TextFormField(
                    controller: nomPrenom,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Ajouter un nom & prenoms';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: 'Nom & prenoms'),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 50, right: 50),
                  child: TextFormField(
                    controller: email,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Ajouter une addresse email';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.alternate_email_sharp),
                        hintText: 'Adresse Email'),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 50, right: 50),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: numero,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Ajouter un numéro';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.phone_android),
                        hintText: 'Numéro de Telephone'),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 50, right: 50),
                  child: TextFormField(
                    controller: adresse,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Ajouter une adresse';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.home_outlined),
                        hintText: 'Adresse'),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 40, right: 40),
                  // ignore: avoid_unnecessary_containers
                  child: Container(
                    child: TextFormField(
                      controller: motDePasse,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock_open_outlined),
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
                      validator: (val) => val!.length < 7
                          ? 'Mot de passe trop court ou ajouter des chiffres, Lettres et caractères spéciaux'
                          : null,
                      onChanged: (val) => pswd = val,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 40, right: 40),
                  // ignore: avoid_unnecessary_containers
                  child: Container(
                    child: TextFormField(
                      autofocus: false,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock_open_outlined),
                        hintText: 'répéter le mot de passe',
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
                      onChanged: (val) => confPswd = val,
                      validator: (val) =>
                          confPswd != pswd ? 'Mot de passe pas conforme' : null,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: ButtonTheme(
                      buttonColor: HexColor("#00BCD4"),
                      minWidth: MediaQuery.of(context).size.width,
                      height: 55,
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                        onPressed: () {
                          inscrption();
                        },
                        child: const Text(
                          "S'inscrire",
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                      )),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
