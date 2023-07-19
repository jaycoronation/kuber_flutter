import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:kuber/utils/session_manager.dart';

import '../constant/api_end_point.dart';
import '../constant/colors.dart';
import '../model/DonateResponseModel.dart';

class DonationScreen extends StatefulWidget {
  const DonationScreen({super.key});
  @override
  State<DonationScreen> createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  TextEditingController donateController = TextEditingController();
  bool customSelection = false;
  String selectedItem = "";
  SessionManager sessionManager = SessionManager();


  List<DonateResponseModel> donatePrice = [];

  @override
  void initState(){
    donatePrice.add(DonateResponseModel(isSelected: false, price: "11"));
    donatePrice.add(DonateResponseModel(isSelected: false, price: "21"));
    donatePrice.add(DonateResponseModel(isSelected: false, price: "51"));
    donatePrice.add(DonateResponseModel(isSelected: false, price: "101"));
    donatePrice.add(DonateResponseModel(isSelected: false, price: "201"));
    donatePrice.add(DonateResponseModel(isSelected: false, price: "501"));
    donatePrice.add(DonateResponseModel(isSelected: false, price: "701"));
    donatePrice.add(DonateResponseModel(isSelected: false, price: "1001"));
    donatePrice.add(DonateResponseModel(isSelected: false, price: "Custom"));
    super.initState();
  }

  Widget buildStageChip(DonateResponseModel getSet, StateSetter setStateInner) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setStateInner(() {
          for (var i = 0; i < donatePrice.length; i++)
          {
            donatePrice[i].isSelected = false;
          }

          getSet.isSelected = true;
        });

        selectedItem = getSet.price.toString();

        if(getSet.price == "Custom")
          {
            setState(() {
              customSelection = true;
            });
          }
        else
            {
              setState(() {
                customSelection = false;
              });
            }
      },
      child: Container(
        decoration: getSet.isSelected ?? false
            ? BoxDecoration(
            color: blue,
            borderRadius: BorderRadius.circular(32)
        )
            : BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(32),
            border: Border.all(width: 0.7,color: Colors.grey)
        ),
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        margin: const EdgeInsets.only(top: 6),
        child: Text(
          getSet.price.toString(),
          style: TextStyle(fontWeight: getSet!.isSelected ?? false ? FontWeight.w500 : FontWeight.w400, color: getSet?.isSelected  ?? false ? white : black, fontSize: 14),
        ),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {

    return Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child:  Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(height: 12,),
                  Center(
                    child: Container(
                      width: 50,
                      margin: const EdgeInsets.only(top: 12),
                      child: const Divider(
                        height: 2,
                        thickness: 2,
                        color: bottomSheetline,
                      ),
                    ),
                  ),
                  Container(height: 12,),
                  Wrap(
                    runSpacing: 6,
                    spacing: 6,
                    children: donatePrice.map((e) {
                      return buildStageChip(e, setState);
                    },
                    ).toList(),
                  ),
                  Container(height: 18,),
                  Visibility(
                    visible: customSelection,
                    child: Container(
                        margin: const EdgeInsets.only(top: 16),
                        child: TextField(
                          controller: donateController,
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.grey,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(color: Colors.grey)
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(color: Colors.grey,),
                            ),
                            labelText: "Enter Donation Amount",
                            labelStyle: const TextStyle(color: text_new),                                     ),
                        )
                    ),
                  ),
                  Container(height: 18,),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => UsePaypal(
                              sandboxMode: false,
                              clientId: PAYPAL_CLIENT_ID,
                              secretKey:PAYPAL_CLIENT_SECRET,
                              returnURL: "https://panditbookings.com/return",
                              cancelURL: "http://panditbookings.com/cancel",
                              transactions: [
                                {
                                  "amount": {
                                    "total": selectedItem,
                                    "currency": "USD",
                                    "details": const {
                                      "subtotal": '1',
                                      "shipping": '0',
                                      "shipping_discount": 0
                                    }
                                  },
                                  "description": "The payment transaction description.",
                                  // "payment_options": {
                                  //   "allowed_payment_method":
                                  //       "INSTANT_FUNDING_SOURCE"
                                  // },
                                  "item_list": {
                                    "items": const [
                                      {
                                        "name": "Astrology Request",
                                        "quantity": 1,
                                        "price": '1',
                                        "currency": "USD"
                                      }
                                    ],
                                    // shipping address is not required though
                                    "shipping_address": {
                                      "recipient_name": "${sessionManager.getName()} ${sessionManager.getLastName()}",
                                      "line1": "2 Gila Crescent",
                                      "line2": "",
                                      "city": "Johannesburg",
                                      "country_code": "SA",
                                      "postal_code": "2090",
                                      "phone": "+00000000",
                                      "state": 'Gauteng'
                                    },
                                  }
                                }
                              ],
                              note: "Contact us for any questions on your order.",
                              onSuccess: (Map params) async {
                                print("onSuccess: $params");
                                String paymentId = "";
                                paymentId = params['paymentId'];
                              },
                              onError: (error) {
                                print("onError: $error");
                              },
                              onCancel: (params) {
                                print('cancelled: $params');
                              }
                          ),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0), side: const BorderSide(color: light_yellow, width: 0.5)),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(light_yellow),
                    ),

                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text('Donate', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: title),),
                        ],
                      ),
                    ),
                  ),
                  Container(height: 18,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}