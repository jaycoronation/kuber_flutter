import 'package:flutter/material.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';

import '../widget/GradientTextButton.dart';
import 'api_end_point.dart';
import 'colors.dart';

GradientTextButton getCommonButton(String text, bool isLoading, VoidCallback onPressed){
  return GradientTextButton(text: text,onPressed: onPressed,isLoading: isLoading,);
}

Widget getBackArrow(){
  return Container(
    alignment: Alignment.centerLeft,
    margin: const EdgeInsets.all(4),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Image.asset('assets/images/ic_back_arrow.png', width: 48, height: 48,),
    ),
  );
}

Widget getTitle(String title){
  return Text(
    title,
    textAlign: TextAlign.start,
    style: const TextStyle(fontWeight: FontWeight.w600, color: darkbrown, fontSize: 20),
  );
}

final FlutterGooglePlacesSdk _places = FlutterGooglePlacesSdk(API_KEY);
List<AutocompletePrediction> locationPredictions = [];
TextEditingController locationSearchController = TextEditingController();

void showLocationDialog(BuildContext context, TextEditingController controller) {
  locationSearchController.clear();
  locationPredictions = [];

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (dialogContext) {
      return StatefulBuilder(
        builder: (context, updateState) {
          return Dialog.fullscreen(
            child: SafeArea(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8,),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.pop(dialogContext);
                          },
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          "Select Location",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8,),
                    child: TextField(
                      cursorColor: black,
                      controller: locationSearchController,
                      autofocus: true,
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                        hintText: "Search location",
                        prefixIcon: const Icon(Icons.search, color: black,),
                        suffixIcon: locationSearchController.text.isNotEmpty
                            ? IconButton(
                          icon: const Icon(Icons.clear, color: black,),
                          onPressed: () {
                            locationSearchController.clear();
                            updateState(() {
                              locationPredictions = [];
                            });
                          },
                        ): null,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: black,),),
                      ),
                      onChanged: (value) {
                        placesDialogNew(
                          value,
                          updateState,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: locationPredictions.isEmpty
                    ? const Center(
                      child: Text(
                        "Search for a location",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                    ) : ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 8,),
                      itemCount: locationPredictions.length,
                      separatorBuilder: (context, index) {
                        return const Divider(height: 1,);
                      },
                      itemBuilder: (context, index) {
                        final prediction =
                        locationPredictions[index];

                        return ListTile(
                          leading: const Icon(Icons.location_on_outlined, color: lightGrey,),
                          minLeadingWidth: 10,
                          title: Text(
                            prediction.fullText,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 14, color: blackLight, fontWeight: FontWeight.w500),
                          ),
                          onTap: () {
                            final selectedAddress = prediction.fullText;
                            // Set selected address
                            controller.text = selectedAddress;
                            // Close dialog
                            Navigator.pop(dialogContext);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

Future<void> placesDialogNew(String query, StateSetter updateState,) async {
  final searchText = query.trim();

  if (searchText.isEmpty)
  {
    updateState(() {
      locationPredictions = [];
    });
    return;
  }

  try
  {
    final result = await _places.findAutocompletePredictions(searchText, countries: [],);
    updateState(() {
      locationPredictions = result.predictions;
    });
  }
  catch (e)
  {
    debugPrint("findAutocompletePredictions error: $e",);
  }
}