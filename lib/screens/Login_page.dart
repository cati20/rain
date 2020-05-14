import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rain/screens/payment_info.dart';
import 'package:rain/services/users_auth.dart';


class Login extends StatefulWidget {





  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String get _email => _emailController.text;
  String get _password => _passwordController.text;


  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> userLogin(BuildContext context) async{
    final token = Provider.of<Auth>(context);
    if(_email == null || _email == '' || _email.length < 5){
      PlatformException(
        message: 'Please enter a valid email',

      );
    }else if (_password == null || _password.length < 5){

    }else{
      token.userLogin(_email, _password);
      if(token.authorization != null){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Payment()
            )
        );
      }
    }

  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Rain Login'),
        centerTitle: true,
        elevation: 15.0,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Login with Email and Password ',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15.0,),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'tmhlongo@gmail.com',
                  labelText: 'email',
                  prefixIcon: Icon(Icons.email, size: 30.0, color: Colors.blue,),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0) ),
                  focusColor: Colors.lightBlueAccent
                ),
                textInputAction: TextInputAction.next,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 8.0,),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'password',
                    prefixIcon: Icon(Icons.vpn_key, size: 30.0, color: Colors.blue,),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0) ),
                    focusColor: Colors.lightBlueAccent
                ),
                textInputAction: TextInputAction.done,
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
              ),
              SizedBox(height: 8.0,),
              RaisedButton(
                color: Colors.blue,
                child: Text(
                    'Login',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18.0
                  ),
                ),
                onPressed: () => userLogin(context),
              )
            ],

          ),
        ),
      ) ,
      ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
