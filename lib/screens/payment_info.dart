import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rain/screens/profile.dart';
import 'package:rain/screens/services.dart';
import 'package:rain/services/users_auth.dart';
import 'dart:convert' as convert;
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter_beautiful_popup/main.dart';



class Payment extends StatefulWidget {





  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {

  String card_type ='';
  String card_number= '';
  String card_expiry='';
  String first_name;
  String lastName;



  Future<void> getPaymentInfo(BuildContext context) async{
    final token = Provider.of<Auth>(context);
    final authorization = token.authorization;
        
    final url = 'https://api-cfv1.rain.co.za/billing/payment_method';
    final url2 = 'https://api-cfv1.rain.co.za/profile_summary';

    final header = {
      "content-Type": "application/json",
      "apikey": "V42zqxrZP3Wdc-pPCPZ54eOgBKE-e9AyA5vblOYpc",
      "key": "6f4962c7-0706-4cf7-b7ce-0b7dc75fcc57",
      "authorization": authorization
    };

    if(authorization != null){
      final res = await  http.get(url,headers: header);
      final payment_details = res.body.toString();
      final names = await http.get(url2, headers: header);
     final check = convert.jsonDecode(payment_details);
     final cardName = convert.jsonDecode(names.body.toString()); 
      setState(() {
      card_type = check['card_type'];
      card_number = check['card_number'];
      card_expiry = check['card_expiry'];
      first_name = cardName['first_name'];
      lastName = cardName['last_name'];
    });
     
    }


}






  @override
  Widget build(BuildContext context) {

  return Scaffold(
      appBar: AppBar(
        title: Text('Payment Method'),
        centerTitle: true,
        elevation: 15.0,
        backgroundColor: Colors.blue,
        actions: <Widget>[
          FlatButton.icon(
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context)=> Services()
                    )
                );
              },
              icon: Icon(Icons.perm_identity, size: 39.0,),
              label: Text('Services'))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
              elevation: 10.0,
               color: Colors.black26,
              child: Column(
                children: <Widget>[
                  Text(
                        card_type.toString() + ' ' + 'CARD',
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                      SizedBox(height: 15.0,),
                      Row(

                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                              "Card Holder",
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                          Text(
                              first_name.toString() + ' '+ lastName.toString(),
                            style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.w600,
                                backgroundColor: Colors.grey
                            ),
                          ),

                        ],
                      ),
                      SizedBox(height: 15.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                              'Card Number',
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                          Text(
                              card_number.toString(),
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w600,
                              backgroundColor: Colors.grey
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                              'Expirey Date',
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                          Text(
                              card_expiry.toString(),
                            style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.w600,
                                backgroundColor: Colors.grey
                            ),
                          ),
                        ],
                      ),


                ],
              ),
            ),
              FloatingActionButton(
                  hoverElevation: 15.0,
                  onPressed: ()=> getPaymentInfo(context)
              )
          ],
        ),
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
