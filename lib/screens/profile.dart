import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rain/screens/payment_info.dart';
import 'package:rain/services/users_auth.dart';
import 'dart:convert' as convert;
import 'dart:async';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {





  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  String username ='';
  String firstname= '';
  String surname='';
  String phone = '';
  String id_num = '';
  int four ;
  int five ;



  Future<void> getPaymentInfo(BuildContext context) async{
    final token = Provider.of<Auth>(context);
    final authorization  = token.authorization;

    

     final url = 'https://api-cfv1.rain.co.za/profile_summary';

     final header = {
       "content-Type": "application/json",
       "apikey": "V42zqxrZP3Wdc-pPCPZ54eOgBKE-e9AyA5vblOYpc",
       "key": "6f4962c7-0706-4cf7-b7ce-0b7dc75fcc57",
       "authorization": authorization
     };

     if(authorization != null){
       final res = await  http.get(url,headers: header);
       final payment_details = res.body.toString();
       final check = convert.jsonDecode(payment_details);


    setState(() {
      username = check['username'];
      firstname =  check['first_name'];
      surname =  check['last_name'];
      phone=  check['phone'];
      id_num = check['id_number'];
      four = check['available_sims'];
      five = check['available_5Gsims'];
    });


  }
}  






  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        elevation: 15.0,
        backgroundColor: Colors.blue,
        actions: <Widget>[
          FlatButton.icon(
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context)=> Payment()
                    )
                );
              },
              icon: Icon(Icons.perm_identity, size: 39.0,),
              label: Text('services'))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 18.0,bottom: 8.0),
                child: Card(
                    elevation: 10.0,
                    color: Colors.black26,
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Client Profile',
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                        SizedBox(height: 15.0,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(

                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "username",
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                              Text(
                                username.toString(),
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600,
                                ),
                              ),

                            ],
                          ),
                        ),
                        SizedBox(height: 15.0),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'First Name',
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                              Text(
                                firstname.toString(),
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15.0,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Surname',
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                              Text(
                                surname.toString(),
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15.0),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'ID Number',
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                              Text(
                                id_num.toString(),
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15.0,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Cellphone',
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                              Text(
                                phone.toString(),
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15.0,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                '4G sim available',
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                              Text(
                                four.toString(),
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15.0,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                '5G avaliable sims',
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                              Text(
                                five.toString(),
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15.0,),
                      ],
                    )

                ),
              ),
              FloatingActionButton(
                  hoverElevation: 15.0,
                  onPressed: ()=> getPaymentInfo(context)
              )
            ],

          ),
        ),
      ) ,
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
