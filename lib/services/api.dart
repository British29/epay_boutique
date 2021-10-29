import 'dart:convert';

import 'package:e_pay/models/recommandationimage.dart';
import 'package:http/http.dart' as http;

Future<List<RecommandationArticle>> fetchArticlesData() async {
  var url = Uri.parse(
      "http://firewall-agency.com/odilon/boutiqueFlutter/affichageArticles.php");
  var reponse = await http.get(url);

  if (reponse.statusCode == 200) {
    final items = json.decode(reponse.body).cast<Map<String, dynamic>>();

    List<RecommandationArticle> articlesRecommandations =
        items.map<RecommandationArticle>((json) {
      return RecommandationArticle.fromJson(json);
    }).toList();

    return articlesRecommandations;
  } else {
    throw Exception('Échec du chargement des données depuis le serveur');
  }
}
