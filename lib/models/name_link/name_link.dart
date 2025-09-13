import 'package:json_annotation/json_annotation.dart';

part 'name_link.g.dart';

@JsonSerializable()
class NameLink {
  final String name;
  final String url;

  NameLink({required this.name, required this.url});

  factory NameLink.fromJson(Map<String, dynamic> json) =>
      _$NameLinkFromJson(json);
  Map<String, dynamic> toJson() => _$NameLinkToJson(this);
}
