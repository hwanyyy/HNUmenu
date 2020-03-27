import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

final String apiUrl = "http://hansikdang.startsomething.us/this-week";
List<Menu> handleBody(http.Response response) {
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final results = data;
    final List<Menu> menus = [];
    results.forEach((m) {
      final menu = Menu.fromJson(m);
      menus.add(menu);
    });
    return menus; // 카드의 갯수(아침, 점심, 저녁)

  } else {
    throw Exception("Can't get menus");
  }
}

Future<List<Menu>> mon() async {
  final String url = '$apiUrl' +'monday';
  final response = await http.get(url);
//  print(response.body);
  return handleBody(response);
}

Future<List<Menu>> tue() async {
  final String url = '$apiUrl'+'tuesday';
  final response = await http.get(url);
//  print(response.body);
  return handleBody(response);
}

Future<List<Menu>> wed() async {
  final String url = '$apiUrl'+'wednesday';
  final response = await http.get(url);
//  print(response.body);
  return handleBody(response);
}

Future<List<Menu>> thu() async {
  final String url = '$apiUrl'+'thursday';
  final response = await http.get(url);
//  print(response.body);
  return handleBody(response);
}

Future<List<Menu>> fri() async {
  final String url = '$apiUrl'+'friday';
  final response = await http.get(url);
//  print(response.body);
  return handleBody(response);
}

class Menu{
  // id는 조식 / 중식 / 석식
  final Map<String, dynamic> id;

  Menu({this.id});

  factory Menu.fromJson(Map<String, dynamic> json){

    return Menu(
      id: json
    );
  }
}