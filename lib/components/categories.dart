import 'package:e_pay/screens/viewcategories.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  String categorieArticle = "";

  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width * 0.99,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
            child: ButtonTheme(
              buttonColor: Colors.redAccent,
              // ignore: deprecated_member_use
              child: OutlineButton(
                onPressed: () {
                  setState(() {
                    categorieArticle = 'Chaussure';
                    // ignore: avoid_print
                    print(categorieArticle);
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DifferentCategories(
                        cat: categorieArticle,
                      ),
                    ),
                  );
                },
                highlightedBorderColor: Colors.redAccent,
                borderSide: const BorderSide(
                  color: Colors.redAccent,
                ),
                child: Text(
                  'Chaussure',
                  style: TextStyle(color: HexColor("#00BCD4"), fontSize: 21),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
            child: ButtonTheme(
              buttonColor: Colors.white,
              // ignore: deprecated_member_use
              child: OutlineButton(
                onPressed: () {
                  setState(() {
                    categorieArticle = 'Sac';
                    // ignore: avoid_print
                    print(categorieArticle);
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DifferentCategories(
                        cat: categorieArticle,
                      ),
                    ),
                  );
                },
                highlightedBorderColor: Colors.cyanAccent,
                borderSide: const BorderSide(
                  color: Colors.cyanAccent,
                ),
                child: const Text(
                  'Sac',
                  style: TextStyle(color: Colors.black, fontSize: 21),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
            child: ButtonTheme(
              buttonColor: Colors.white,
              // ignore: deprecated_member_use
              child: OutlineButton(
                onPressed: () {
                  setState(() {
                    categorieArticle = 'Montre';
                    // ignore: avoid_print
                    print(categorieArticle);
                  });

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DifferentCategories(
                        cat: categorieArticle,
                      ),
                    ),
                  );
                },
                highlightedBorderColor: Colors.cyanAccent,
                borderSide: const BorderSide(
                  color: Colors.blueAccent,
                ),
                child: const Text(
                  'Montre',
                  style: TextStyle(color: Colors.black, fontSize: 21),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
            child: ButtonTheme(
              buttonColor: Colors.white,
              // ignore: deprecated_member_use
              child: OutlineButton(
                onPressed: () {
                  setState(() {
                    categorieArticle = 'ordinateur';
                    // ignore: avoid_print
                    print(categorieArticle);
                  });

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DifferentCategories(
                        cat: categorieArticle,
                      ),
                    ),
                  );
                },
                highlightedBorderColor: Colors.yellowAccent,
                borderSide: const BorderSide(
                  color: Colors.yellowAccent,
                ),
                child: const Text(
                  'ordinateur',
                  style: TextStyle(color: Colors.black, fontSize: 21),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
