import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rain/screens/payment_info.dart';
import 'package:rain/screens/profile.dart';
import 'package:rain/services/users_auth.dart';
import 'dart:convert' as convert;
import 'dart:async';
import 'package:http/http.dart' as http;
 import 'package:getflutter/getflutter.dart';


class Services extends StatefulWidget {





  @override
  _ServicesState createState() => _ServicesState();
}

class _ServicesState extends State<Services> {


  String total_usage = '100.00';
  String spend_limit = null;
  String spend_limit_avaliable = null;
  String service_reference = null;
  String offpeak_usage = null;
  String sim_name =  null;
  String current_speed = null;
  String activation_date = '22 june 1990 25123';



  Future<void> getUserServices(BuildContext context) async{
    final token = Provider.of<Auth>(context);
    final authorization = token.authorization;

    final url = 'https://api-cfv1.rain.co.za/services';

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
      total_usage = check['services'][0]['total_usage'];
       spend_limit = check['services'][0]['spend_limit_initial'];
       spend_limit_avaliable = check['services'][0]['spend_limit_available'];
       service_reference = check['services'][0]['service_reference'];
       sim_name =  check['services'][0]['name'];
       current_speed = check['services'][0]['current_speed'];
       offpeak_usage = check['services'][0]['offpeak_usage'];
       activation_date = check['services'][0]['activation_date'];
       });

  }
}  






  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Services'),
        centerTitle: true,
        elevation: 15.0,
        backgroundColor: Colors.blue,
        actions: <Widget>[
          FlatButton.icon(
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context)=> Profile()
                    )
                );
              },
              icon: Icon(Icons.perm_identity, size: 39.0,),
              label: Text('Profile'))
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
                padding: const EdgeInsets.only(top: 18.0,bottom: 8.0, left: 8.0, right: 8.0 ),
                child: Card(
                    elevation: 10.0,
                    color: Colors.black26,
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Client Services',
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
                                "sim name",
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                              Text(
                                sim_name.toString(),
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
                                'Sim Number',
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                              Text(
                                service_reference.toString(),
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
                                'Total Usage',
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                              total_usage == null ? Text('0') :
                              Text(
                                total_usage.substring(0,2) + 'GB',
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
                                'Spend Limit',
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                              Text(
                                'R' +spend_limit.toString(),
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
                                'Available Spend Limit',
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                              Text(
                                'R'+ spend_limit_avaliable.toString(),
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
                                'Speed',
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                              Text(
                                current_speed.toString(),
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
                                'Sim Activation Date',
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                              Text(
                                activation_date.substring(0,10),
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
                  onPressed: ()=> getUserServices(context)
              ),
        GFProgressBar(
     percentage: 0.8,
     lineHeight: 20,
     alignment: MainAxisAlignment.spaceBetween,
     child: const Text('82%', textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
     leading  : Icon( Icons.sentiment_dissatisfied, color: GFColors.DANGER),
     trailing: Icon( Icons.sentiment_satisfied, color: GFColors.SUCCESS),
     backgroundColor: Colors.black26,
     progressBarColor: GFColors.INFO,
     animation: true
        )

            ],

          ),
        ),
      ) ,
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
