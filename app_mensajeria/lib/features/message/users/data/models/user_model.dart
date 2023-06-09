import 'package:app_mensajeria/features/message/users/domain/entities/users.dart';

class UserModel extends User {
  UserModel({
    required String data,
    required String img,
    required String name,
    required String id,
    required String firebaseId
  }) : super(data: data, img: img, name: name, id:id, firebaseId: firebaseId);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      data: json["data"],
      img: json["img"],
      name: json["name"],
      id: json["id"],
      firebaseId: json["firebaseId"],
    );
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      data: user.data,
      img: user.img,
      name: user.name,
      id: user.id,
      firebaseId: user.firebaseId
    );
  }
}