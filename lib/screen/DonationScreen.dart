import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:kuber/utils/session_manager.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

import '../constant/api_end_point.dart';
import '../constant/colors.dart';
import '../model/CommonResponseModel.dart';
import '../model/DonateResponseModel.dart';
import '../utils/app_utils.dart';
import '../utils/responsive.dart';
import '../widget/loading.dart';

class DonationScreen extends StatefulWidget {
  const DonationScreen({super.key});
  @override
  State<DonationScreen> createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  TextEditingController donateController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  bool customSelection = false;
  String selectedItem = "";
  SessionManager sessionManager = SessionManager();
  bool _isLoading = false;

  List<DonateResponseModel> donatePrice = [];

  @override
  void initState(){
    donatePrice.add(DonateResponseModel(isSelected: false, price: "\$ 11"));
    donatePrice.add(DonateResponseModel(isSelected: false, price: "\$ 21"));
    donatePrice.add(DonateResponseModel(isSelected: false, price: "\$ 51"));
    donatePrice.add(DonateResponseModel(isSelected: false, price: "\$ 101"));
    donatePrice.add(DonateResponseModel(isSelected: false, price: "\$ 201"));
    donatePrice.add(DonateResponseModel(isSelected: false, price: "\$ 501"));
    donatePrice.add(DonateResponseModel(isSelected: false, price: "\$ 701"));
    donatePrice.add(DonateResponseModel(isSelected: false, price: "\$ 1001"));
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
            color: darkbrown,
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
    return ResponsiveWidget.isSmallScreen(context)
        ? Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom),
            child:  _isLoading
                ? SizedBox(
                height: MediaQuery.of(context).size.height * 0.88,
                child: const LoadingWidget())
                : SingleChildScrollView(
                  child:  Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Container(height: 8,),
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
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: const Text(
                            "Donation",
                            style: TextStyle(
                                fontWeight: FontWeight.w900, color: darkbrown, fontSize: 18),
                          ),
                        ),
                        Container(height: 18,),
                        Wrap(
                          runSpacing: 6,
                          spacing: 6,
                          children: donatePrice.map((e) {
                            return buildStageChip(e, setState);
                          },
                          ).toList(),
                        ),



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

                        Container(
                            margin: const EdgeInsets.only(top: 16),
                            child: TextField(
                              textAlignVertical: TextAlignVertical.top,
                              // expands: true,
                              maxLines: 4,
                              controller: reasonController,
                              keyboardType: TextInputType.text,
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
                                hintText: "Reason For Donation",
                                hintStyle: const TextStyle(color: text_new),
                              ),
                            )
                        ),
                        Container(height: 22,),
                        const Align(
                            alignment: Alignment.centerRight,
                            child: Text("* Donation amount is in USD", style: TextStyle(color: lighttxtGrey),)
                        ),
                        Container(height: 8,),

                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) => UsePaypal(
                                    sandboxMode: SANDBOX,
                                    clientId: PAYPAL_CLIENT_ID,
                                    secretKey:PAYPAL_CLIENT_SECRET,
                                    returnURL: "https://panditbookings.com/return",
                                    cancelURL: "http://panditbookings.com/cancel",
                                    transactions: [
                                      {
                                        "amount": {
                                          "total": selectedItem == "Custom" ? donateController.value.text : selectedItem.replaceAll("\$ ", ""),
                                          "currency": "USD",
                                          "details": {
                                            "subtotal": selectedItem == "Custom" ? donateController.value.text : selectedItem.replaceAll("\$ ", ""),
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
                                          "items": [
                                            {
                                              "name": "Donation",
                                              "quantity": 1,
                                              "price": selectedItem == "Custom" ? donateController.value.text : selectedItem.replaceAll("\$ ", ""),
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
                                      callsDonationAPI(paymentId);
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
          )
        : Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child:  _isLoading
              ? SizedBox(
              height: MediaQuery.of(context).size.height * 0.88,
              child: const LoadingWidget())
              : SingleChildScrollView(
                child:  Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, right: 18),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(height: 8,),
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
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: const Text(
                              "Donation",
                              style: TextStyle(
                                  fontWeight: FontWeight.w900, color: darkbrown, fontSize: 18),
                            ),
                          ),
                          Container(height: 18,),
                          Wrap(
                            runSpacing: 6,
                            spacing: 6,
                            children: donatePrice.map((e) {
                              return buildStageChip(e, setState);
                            },
                            ).toList(),
                          ),
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
                                    labelStyle: const TextStyle(color: text_new),
                                  ),
                                )
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.only(top: 16),
                              child: TextField(
                                textAlignVertical: TextAlignVertical.top,
                                // expands: true,
                                maxLines: 4,
                                controller: reasonController,
                                keyboardType: TextInputType.text,
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
                                  hintText: "Reason For Donation",
                                  hintStyle: const TextStyle(color: text_new),
                                ),
                              )
                          ),
                          Container(height: 22,),
                          const Align(
                              alignment: Alignment.centerRight,
                              child: Text("* Donation amount is in USD", style: TextStyle(color: lighttxtGrey),)
                          ),
                          Container(height: 8,),

                          TextButton(
                            onPressed: () {
                             /* Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) => UsePaypal(
                                      sandboxMode: SANDBOX,
                                      clientId: PAYPAL_CLIENT_ID,
                                      secretKey:PAYPAL_CLIENT_SECRET,
                                      returnURL: "https://panditbookings.com/return",
                                      cancelURL: "http://panditbookings.com/cancel",
                                      transactions: [
                                        {
                                          "amount": {
                                            "total": selectedItem == "Custom" ? donateController.value.text : selectedItem.replaceAll("\$ ", ""),
                                            "currency": "USD",
                                            "details": {
                                              "subtotal": selectedItem == "Custom" ? donateController.value.text : selectedItem.replaceAll("\$ ", ""),
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
                                            "items": [
                                              {
                                                "name": "Donation",
                                                "quantity": 1,
                                                "price": selectedItem == "Custom" ? donateController.value.text : selectedItem.replaceAll("\$ ", ""),
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
                                        callsDonationAPI(paymentId);
                                      },
                                      onError: (error) {
                                        print("onError: $error");
                                      },
                                      onCancel: (params) {
                                        print('cancelled: $params');
                                      }
                                  ),
                                ),
                              );*/
                              createPayPalPayment();
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
                                  Padding(
                                    padding: EdgeInsets.only(top: 8.0, bottom: 8),
                                    child: Text('Donate', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: title),),
                                  ),
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

  Future<void> createPayPalPayment() async {
    setState(() {
      _isLoading = true;
    });
    Uri url = Uri.parse("");
    if (SANDBOX)
    {
      url = Uri.parse('https://api.sandbox.paypal.com/v1/payments/payment');
    }
    else
    {
      url = Uri.parse('https://api.paypal.com/v1/payments/payment');
    }
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Basic ${base64Encode(utf8.encode('$PAYPAL_CLIENT_ID:$PAYPAL_CLIENT_SECRET'))}', // Use your access token here
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'intent': 'sale',
        'payer': {
          'payment_method': 'paypal',
        },
        'transactions': [
          {
            "amount": {
              "total": selectedItem == "Custom" ? donateController.value.text : selectedItem.replaceAll("\$ ", ""),
              "currency": "USD",
              "details": {
                "subtotal": selectedItem == "Custom" ? donateController.value.text : selectedItem.replaceAll("\$ ", ""),
                "shipping": '0',
                "shipping_discount": 0
              }
            },
            "description": "The Payment is for user to pay donation.",
            "item_list": {
              "items": [
                {
                  "name": "Donation",
                  "quantity": 1,
                  "price": selectedItem == "Custom" ? donateController.value.text : selectedItem.replaceAll("\$ ", ""),
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
        'redirect_urls': {
          'return_url': 'https://www.panditbookings.com/kuber/sucess',
          'cancel_url': 'https://www.panditbookings.com/kuber/failed',
        },
      }),
    );

    print(jsonDecode(response.body));

    if (response.statusCode == 201) {
      final paymentResponse = json.decode(response.body);

      final approvalUrl = paymentResponse['links']
          .firstWhere((link) => link['rel'] == 'approval_url')['href'];

      html.window.open(approvalUrl,"_self");

      var url = html.window.location.href;

      if (url.contains("sucess"))
        {
          print("Done");
        }


      setState(() {
        _isLoading = false;
      });
      // Redirect the user to the approval URL to complete the payment
      // You can use webview or window.open to achieve this
    } else {
      // Handle error
    }
  }

  callsDonationAPI(String paymentId) async {
    setState(() {
      _isLoading = true;
    });
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(MAIN_URL + donationSave);

    Map<String, String> jsonBody = {
      'reason_for_donation': reasonController.value.text,
      'amount': selectedItem == "Custom" ? donateController.value.text : selectedItem.replaceAll("\$ ", ""),
      'first_name': sessionManager.getName().toString(),
      'last_name': sessionManager.getLastName().toString(),
      'email': sessionManager.getEmail().toString(),
      'contact_no': sessionManager.getPhone().toString(),
      'user_id': sessionManager.getUserId().toString()
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var astroResponse = CommonResponseModel.fromJson(user);

    if (statusCode == 200 && astroResponse.success == 1) {
      setState(() {
        _isLoading = false;
      });
      afterMethod();

    }
    else
    {
      setState(() {
        _isLoading = false;
      });
      showToast(astroResponse.message, context);
    }
  }

  void afterMethod() {
    Navigator.pop(context, true);
  }


}