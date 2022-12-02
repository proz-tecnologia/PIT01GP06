import 'package:dio/dio.dart';
import 'homelogin_model.dart';

abstract class HomeLoginRepository {
  Future<bool> createUser(User model);
  Future<bool> getLogin(String email, String pwd);
  Future<List<User>> getUsers();
}

class ExternalApiRepository implements HomeLoginRepository {
  final _dio = Dio(
    BaseOptions(baseUrl: "http://10.0.2.2:3031"),
  );

  @override
  Future<List<User>> getUsers() async {
    await Future.delayed(const Duration(seconds: 1));
    try {
      final response = await _dio.get("/users");
      if (response.statusCode == 200) {
        final decoded = List.from(response.data);
        final users = decoded.map((e) => User.fromMap(e)).toList();
        return users;
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> getLogin(String email, String pwd) async {
    await Future.delayed(const Duration(seconds: 1));
    try {
      final response = await _dio.get("/users");
      if (response.statusCode == 200) {
        final decoded = List.from(response.data);
        final users = decoded.map((e) => User.fromMap(e)).toList();
        if (verificaLista(email, pwd, users)) {
          return true;
        }
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> createUser(User model) async {
    await Future.delayed(const Duration(seconds: 1));

    try {
      final response = await _dio.post(
        "/users",
        data: model.toMap(),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  bool verificaLista(String email, String pwd, List<User> listaUser) {
    for (User i in listaUser) {
      if (i.email == email && i.pwd == pwd) {
        return true;
      }
    }
    return false;
  }
}
