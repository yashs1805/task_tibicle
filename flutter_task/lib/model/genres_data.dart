import 'package:json_annotation/json_annotation.dart';
part 'genres_data.g.dart';

@JsonSerializable(explicitToJson: true)

class GenresData {
  GenresData({
    this.id,
    this.name
  });

  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
 


  static fromJson(Map<String, dynamic> json) =>
      _$GenresDataFromJson(json);

  Map<String, dynamic> toJson() => _$GenresDataToJson(this);

}

