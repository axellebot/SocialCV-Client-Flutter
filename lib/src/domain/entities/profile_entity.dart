import 'package:social_cv_client_flutter/domain.dart';

class ProfileEntity extends ElementEntity {
  String title;
  String subtitle;
  Uri picture;
  Uri cover;
  List<String> partIds;
  String type;
  String ownerId;

  @override
  String toString() => '$runtimeType{ '
      'id: $id, '
      'title: $title, '
      'subtitle: $subtitle, '
      'picture: $picture, '
      'cover: $cover, '
      'partIds: $partIds, '
      'type: $type, '
      'owner: $ownerId'
      ' }';
}
