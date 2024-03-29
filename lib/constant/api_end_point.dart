import 'package:flutter/foundation.dart';

const String MAIN_URL = "https://www.panditbookings.com/api/index.php/";
const String WEBSITE_URL = "https://www.panditbookings.com/";
const String COUNTRY = "Country";
const String STATE = "State";
const String CITY = "City";
const String CITY_WORK = "City_Work";
const String QULIFICATION = "Qualification";
const String EXPRIENCE = "Experience";
const String API_KEY = kIsWeb ? "AIzaSyBiwi0bSUa4QTj59ojKgmS8fc_pfBb6eaU" : "AIzaSyBiwi0bSUa4QTj59ojKgmS8fc_pfBb6eaU"; // KUBER
// const String API_KEY = "AIzaSyC7HlgldL9ietWQF8Y3oHxf_LJnYPMHhDU"; // KUBER

//LOCAL
// const String PAYPAL_CLIENT_ID = "AeYZUWJt5EZkyHcf2PzpzhMjt6H-KfQ5G35B0UvNcofNDn5Ewle8kyTbYEuaAeI7vtxNNPWbZ1ZDiyMt";
// const String PAYPAL_CLIENT_SECRET = "EP9ItIeLUhZ6TnIif7aKygizoqXs-GoUSGqDSlx8wg154XZ2UV8dAcKxjSOY_g_QRLN3JwJBA6E66I3-";

//Live
const String PAYPAL_CLIENT_ID = "AUQiip1nmdXa4N_Igtsu6kG0lQOYHtq_63pb_hDcckOgQOr6kGaxHf0JwPzuyOdA4lO904urH8lkpWBy";
const String PAYPAL_CLIENT_SECRET = "EKWbMBN0C295I8y9Zd-fuestKwdq46l3Kq5Q2JOjYduKSvCVqvx1kvONKWNLXapZ2xMG0trMtOrNRfo7";
const bool SANDBOX = false;
// const String API_KEY = "AIzaSyAoqW5iG6Ez-kxsxi7RNPfP8CvFMk3yz8A"; // FOOD BOSS

/*Login*/
String generateOtp = "users_services/generateOTP";
String socialLogin = "users_services/user/social_login";
String verifyOtp = "users_services/verifyOTP";
String signUp = "mobile_services/user/signup";
String bookingList = "users_services/bookings/list";
String bookingDetails = "users_services/bookings/detail";
String login = "mobile_services/user/signin";
String likeFeeds = "admin_services/manage_feeds/like";
String forgotPassword = "services/user/forgot_password";
String deletAccount = "services/user/delete";
String getCountry = "services/get_countries";
String getCity = "services/get_city";
String getCityWork = "services/get_city_from_country";
String getState = "services/get_states";
String updateProfileForUser = "users_services/user/updateProfile";
String updateProfileForPriest = "services/user/updateProfile";
String updateProfileForTemple = "users_services/user/updateTempleProfile";
String pujaList = "users_services/puja/list";
String getUserProfileUser = "users_services/user/userProfile";
String getUserProfilePujari = "services/user/userProfile";
String getPrayerList = "services/prayers/list";
String savePrayerRequest = "services/prayer_requests/save";
String getAddressList = "users_services/address/addressBook";
String getRashiList = "services/rashi_calculator/list";
String getMatchList = "users_services/match_making/list";
String getPrayerRequestList = "services/prayer_requests/list";
String getAstrologyList = "users_services/astrology/list";
String getAstrologyDetail = "users_services/astrology/details";
String getMatchDetail = "users_services/match_making/details";
String deletePrayerRequest = "services/prayer_requests/delete";
String saveRashiRequest = "services/rashi_calculator/save";
String deleteRashiRequest = "services/rashi_calculator/delete";
String astrologySave = "users_services/astrology/save";
String addAddress = "users_services/address/newAddress";
String deleteAddress = "users_services/address/deleteAddress";
String updateAddress = "users_services/address/updateAddress";
String bookPuja = "users_services/bookings/book_now";
String matchmakingsave = "users_services/match_making/save";
String deletematch = "users_services/match_making/delete";
String astrodelete = "users_services/astrology/delete";
String bookPujaForGuestUserNew = "users_services/bookings/guest_book_puja";
String getPujaDetailstUser = "users_services/puja/detail";
String updateProfilePic = "users_services/user/uploadProfilePic";
String updateProfilePicPujari = "services/user/uploadProfilePic";
String updateProfilePicTemple = "services/user/uploadTempleProfilePic";
String changePassword = "services/user/set_password";
String getUserFeed = "admin_services/manage_feeds/list";
String getUserThoughts = "admin_services/manage_thoughts/list";

String getDonationList = "admin_services/manage_donations/list";
String getDonationDetail = "admin_services/manage_donations/details";
String donationSave = "admin_services/manage_donations/save";
String getAssignedPoojaForPujari = 'admin_services/priest_requests/list';
String reviewSave = 'services/feedbacks/save';
String updateDeviceToken = 'services/update_device_token';

/*JSON*/

String priceJson = "prices.json";
