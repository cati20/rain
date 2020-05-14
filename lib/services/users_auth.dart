import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:collection';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'dart:convert' as convert;



class Auth with ChangeNotifier {

  String authorization = null;
  String error = null;


  Future<String> userLogin(String email, String password) async{
    final url = 'https://api-cfv1.rain.co.za/auth/token';
    final header = {
      "Content-Type": "application/json",
      "apikey": "V42zqxrZP3Wdc-pPCPZ54eOgBKE-e9AyA5vblOYpc",
      "key": "6f4962c7-0706-4cf7-b7ce-0b7dc75fcc57"
    };

    final params = {"auth":{"email":email,"password":password}};
    final body = convert.jsonEncode(params);
    final res = await http.post(url, headers: header, body: body);
    if(res.statusCode == 200){
      final auth = res.headers['authorization'];
       authorization = auth;
    }else{
      error = res.body.toString();
    }
   
    notifyListeners();

  }







}
