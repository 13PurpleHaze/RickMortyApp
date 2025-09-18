import 'package:json_annotation/json_annotation.dart';

import '../../domain/domain.dart';

part 'name_link_model.g.dart';

@JsonSerializable()
class NameLinkModel extends NameLink {
  NameLinkModel({required super.name, required super.url});

  factory NameLinkModel.fromJson(Map<String, dynamic> json) =>
      _$NameLinkModelFromJson(json);
  Map<String, dynamic> toJson() => _$NameLinkModelToJson(this);
}
