class ArticlesDetailsData {
  final String id;
  final String designation;
  final String categories;
  final String quantite;
  final String photo;
  final String prix;
  final String date;

  ArticlesDetailsData({
    required this.id,
    required this.designation,
    required this.categories,
    required this.quantite,
    required this.photo,
    required this.prix,
    required this.date,
  });

  factory ArticlesDetailsData.fromJson(Map<String, dynamic> json) {
    return ArticlesDetailsData(
      id: json['id'] as String,
      designation: json['designation'] as String,
      categories: json['categories'] as String,
      quantite: json['quantite'] as String,
      photo: json['photo'] as String,
      prix: json['prix'] as String,
      date: json['date'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals, unnecessary_new
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['designation'] = designation;
    data['categories'] = categories;
    data['quantite'] = quantite;
    data['photo'] = photo;
    data['prix'] = prix;
    data['date'] = date;
    return data;
  }
}
