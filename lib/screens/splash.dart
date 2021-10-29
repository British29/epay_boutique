import 'package:e_pay/screens/accueil.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    var d = const Duration(seconds: 3);
    Future.delayed(d, () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) {
          return const AccueilPage(
          
          );
        }),
        (route) => false,
      );
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'VOTRE COMMANDE EST EN COURS DE TRAITEMENT',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: HexColor('#23ab7a'),
                  ),
                ),
              ),
              // ignore: avoid_unnecessary_containers
              Container(
                child: Center(
                  child: Image.asset(
                    'assets/gifs/verify.gif',
                    height: MediaQuery.of(context).size.height * 0.55,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
