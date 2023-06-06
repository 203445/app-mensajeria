import 'package:app_mensajeria/features/message/users/domain/entities/users.dart';

class UserModel extends User {
  UserModel({
    required String phone,
    required String data,
    required String img,
    required String name,
    required String id
  }) : super(phone: phone, data: data, img: img, name: name, id:id);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      phone: json["phone"],
      data: json["data"],
      img: json["img"],
      name: json["name"],
      id: json["id"],
    );
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      phone: user.phone,
      data: user.data,
      img: user.img,
      name: user.name,
      id: user.id,
    );
  }
}