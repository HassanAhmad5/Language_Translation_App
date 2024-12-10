class MostPhrases {
  final int ?id;
  final int ?catId;
  final String ?phrases;
  final String ?audio;

  MostPhrases({
    this.id,
    this.catId,
    this.phrases,
    this.audio
  });

  factory MostPhrases.fromJson(Map<String, dynamic> json){
    return MostPhrases(
        id: json['id'],
        catId: json['catID'],
        phrases: json['phrase'],
        audio: json['audio']
    );
  }
}