
import 'dart:ffi';

import 'package:kuber/model/VerifyOtpResponseModel.dart';
import 'package:kuber/utils/session_manager_methods.dart';

class SessionManager {
  /*
  "user_id": "18",
  "name": "Jay Mistry",
  "email": "jay.m@coronation.in",
  "phone": "7433036724",
  "dob": "04 Jun 2018",
  "referral_code": "YQB427",
  "has_login_pin": true,
  "image": "https://apis.roboadviso.com/assets/uploads/profiles/profile_1626788768_98.jpg"
*/
  final String isLoggedIn = "isLoggedIn";
  final String userId = "user_id";
  final String firstName = "first_name";
  final String lastName = "last_name";
  final String email = "email";
  final String mobileNumber = "mobile";
  final String birthdate = "birthdate";
  final String gender = "gender";
  final String genederLabel = "gender_label";
  final String address = "address";
  final String country = "country";
  final String city = "city";
  final String state = "state";
  final String countryId = "country_id";
  final String cityId = "city_id";
  final String stateId = "state_id";
  final String countryName = "country_name";
  final String cityName = "city_name";
  final String stateName = "state_name";
  final String image = "profile_pic";
  final String isPujari = "isPujari";
  final String isTemple = "isTemple";
  final String isSocial = "isSocial";
  final String countryCode = "countryCode";
  final String userType = "userType";

  //set data into shared preferences...
  Future createLoginSession(Profile getSet) async {
    await SessionManagerMethods.setBool(isLoggedIn, true);
    await SessionManagerMethods.setString(userId, getSet.userId.toString());
    await SessionManagerMethods.setString(firstName, getSet.firstName ?? "");
    await SessionManagerMethods.setString(lastName, getSet.lastName ?? "");
    await SessionManagerMethods.setString(email, getSet.email ?? "");
    await SessionManagerMethods.setString(mobileNumber, getSet.mobile.toString());
    await SessionManagerMethods.setString(birthdate, getSet.birthdate.toString());
    await SessionManagerMethods.setString(address, getSet.address.toString());
    await SessionManagerMethods.setString(countryId, getSet.countryId.toString());
    await SessionManagerMethods.setString(cityId, getSet.cityId.toString());
    await SessionManagerMethods.setString(stateId, getSet.stateId.toString());
    await SessionManagerMethods.setString(countryName, getSet.countryName.toString());
    await SessionManagerMethods.setString(countryCode, getSet.countryCode.toString());
    await SessionManagerMethods.setString(cityName, getSet.cityName.toString());
    await SessionManagerMethods.setString(stateName, getSet.stateName.toString());
    await SessionManagerMethods.setString(image, getSet.profilePic.toString());
    await SessionManagerMethods.setBool(isSocial,false);
    await SessionManagerMethods.setString(userType, getSet.type.toString());

  }

  Future<void> setType(String apitype)
  async {
    await SessionManagerMethods.setString(userType, apitype);
  }

  String? getType() {
    return SessionManagerMethods.getString(userType);
  }

  bool? checkIsLoggedIn() {
    return SessionManagerMethods.getBool(isLoggedIn);
  }

  bool? getIsTemple() {
    return SessionManagerMethods.getBool(isTemple);
  }

  bool? getIsPujrai() {
    return SessionManagerMethods.getBool(isPujari);
  }

  String? getUserId() {
    return SessionManagerMethods.getString(userId);
  }

  String? getCountryCode() {
    return SessionManagerMethods.getString(countryCode);
  }

  Future<void> setName(String apiFirstName)
  async {
    await SessionManagerMethods.setString(firstName, apiFirstName);
  }

  Future<void> setUserId(String apiUserId)
  async {
    await SessionManagerMethods.setString(userId, apiUserId);
  }


  String? getName() {
    return SessionManagerMethods.getString(firstName);
  }

  Future<void> setLastName(String apiLastName)
  async {
    await SessionManagerMethods.setString(lastName, apiLastName);
  }

  String? getLastName() {
    return SessionManagerMethods.getString(lastName);
  }

  Future<void> setEmail(String apiEmail)
  async {
    await SessionManagerMethods.setString(email, apiEmail);
  }

  String? getEmail() {
    return SessionManagerMethods.getString(email);
  }

  Future<void> setPhone(String apiMobileNumber)
  async {
    await SessionManagerMethods.setString(mobileNumber, apiMobileNumber);
  }

  String? getPhone() {
    return SessionManagerMethods.getString(mobileNumber);
  }

  Future<void> setDob(String apiBirthDate)
  async {
    await SessionManagerMethods.setString(birthdate, apiBirthDate);
  }

  String? getDob() {
    return SessionManagerMethods.getString(birthdate);
  }

  Future<void> setGender(String apiGender)
  async {
    await SessionManagerMethods.setString(gender, apiGender);
  }

  String? getGender() {
    return SessionManagerMethods.getString(gender);
  }

  Future<void> setgenderLabel(String apiGenederLabel)
  async {
    await SessionManagerMethods.setString(genederLabel, apiGenederLabel);
  }

  String? getGenderLabel() {
    return SessionManagerMethods.getString(genederLabel);
  }

  Future<void> setAddress(String apiAddress)
  async {
    await SessionManagerMethods.setString(address, apiAddress);
  }

  String? getAddress() {
    return SessionManagerMethods.getString(address);
  }

  Future<void> setCountry(String apiCountry)
  async {
    await SessionManagerMethods.setString(country, apiCountry);
  }

  String? getCountry() {
    return SessionManagerMethods.getString(country);
  }

  Future<void> setCity(String apiCity)
  async {
    await SessionManagerMethods.setString(city, apiCity);
  }

  String? getCity() {
    return SessionManagerMethods.getString(city);
  }

  Future<void> setState(String apiState)
  async {
    await SessionManagerMethods.setString(state, apiState);
  }

  String? getState() {
    return SessionManagerMethods.getString(state);
  }

  Future<void> setCountryId(String apiCountryId)
  async {
    await SessionManagerMethods.setString(countryId, apiCountryId);
  }

  String? getCountryId() {
    return SessionManagerMethods.getString(countryId);
  }

  Future<void> setCityId(String apiCityId)
  async {
    await SessionManagerMethods.setString(cityId, apiCityId);
  }

  String? getCityId() {
    return SessionManagerMethods.getString(cityId);
  }

  Future<void> setStateId(String apiStateId)
  async {
    await SessionManagerMethods.setString(stateId, apiStateId);
  }

  String? getStateId() {
    return SessionManagerMethods.getString(stateId);
  }

  Future<void> setImage(String apiImage)
  async {
    await SessionManagerMethods.setString(image, apiImage);
  }

  String? getImagePic() {
    return SessionManagerMethods.getString(image);
  }


}