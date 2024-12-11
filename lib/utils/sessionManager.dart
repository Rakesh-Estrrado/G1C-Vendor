import 'package:shared_preferences/shared_preferences.dart';


class SessionManager {
  static const String PREF_GENERAL = "PREF_GENERAL";
  static const String IS_LOGIN = "isLogin";
  static const String KEY_TOKEN = "token";
  static const String USER_ID = "USER_ID";
  static const String PROFILE_IMAGE = "PROFILE_IMAGE";
  static const String USER_NAME = "USER_NAME";
  static const String USER_EMAIL = "USER_EMAIL";
  static const String NOTIFICATION_COUNT = "NOTIFICATION_COUNT";
  static const String ORGANISATION_ID = "ORGANISATION_ID";
  static const String ROLE = "ROLE";
  static const String IS_ADMIN = "IS_ADMIN";

  static const String PHONE_NO = "PHONE_NO";
  static const String COUNTRY_ID = "COUNTRY_ID";
  static const String BRANCH_ID = "BRANCH_ID";
  static const String BRANCH_CODE = "BRANCH_CODE";
  static const String PHONE_CODE = "PHONE_CODE";
  static const String SELLER_ID = "SELLER_ID";
  static const String SHOWN_APP_ACCESS_MSG = "SHOWN_APP_ACCESS_MSG";
  static const String APP_IN_BETA = "APP_IN_BETA";

  SharedPreferences? _generalPref;

  SessionManager._(); // Private constructor

  static Future<SessionManager> create() async {
    final sessionManager = SessionManager._();
    await sessionManager._initPreferences();
    return sessionManager;
  }

  Future<void> _initPreferences() async {
    try {
      _generalPref = await SharedPreferences.getInstance();
    } catch (e) {
      print("Error initializing preferences: $e");
    }
  }

  bool get isLogin => _generalPref?.getBool(IS_LOGIN) ?? false;
  set isLogin(bool status) => _generalPref?.setBool(IS_LOGIN, status) ?? false;

  String get token => _generalPref?.getString(KEY_TOKEN) ?? "";
  set token(String token) => _generalPref?.setString(KEY_TOKEN, token) ?? "";

  int get userId => _generalPref?.getInt(USER_ID) ?? 0;
  set userId(int status) => _generalPref?.setInt(USER_ID, status) ?? 0;

  String get profileImage => _generalPref?.getString(PROFILE_IMAGE) ?? "";
  set profileImage(String status) => _generalPref?.setString(PROFILE_IMAGE, status) ?? "";

  int get organisationId => _generalPref?.getInt(ORGANISATION_ID) ?? 0;
  set organisationId(int status) => _generalPref?.setInt(ORGANISATION_ID, status) ?? 0;


  String get userName => _generalPref?.getString(USER_NAME) ?? "";
  set userName(String status) => _generalPref?.setString(USER_NAME, status) ?? "";

  String get role => _generalPref?.getString(ROLE) ?? "";
  set role(String status) => _generalPref?.setString(ROLE, status) ?? "";

  bool get isAdmin => _generalPref?.getBool(IS_ADMIN) ?? false;
  set isAdmin(bool status) => _generalPref?.setBool(IS_ADMIN, status) ?? false;

  String get userEmail => _generalPref?.getString(USER_EMAIL) ?? "";
  set userEmail(String status) => _generalPref?.setString(USER_EMAIL, status) ?? "";

  String get phoneNo => _generalPref?.getString(PHONE_NO) ?? "";
  set phoneNo(String status) => _generalPref?.setString(PHONE_NO, status) ?? "";

  int get countryId => _generalPref?.getInt(COUNTRY_ID) ?? 0;
  set countryId(int status) => _generalPref?.setInt(COUNTRY_ID, status) ?? 0;

  int get branchId => _generalPref?.getInt(BRANCH_ID) ?? 0;
  set branchId(int status) => _generalPref?.setInt(BRANCH_ID, status) ?? 0;

  String get branchCode => _generalPref?.getString(BRANCH_CODE) ?? "";
  set branchCode(String status) => _generalPref?.setString(BRANCH_CODE, status) ?? "";

  String get phoneCode => _generalPref?.getString(PHONE_CODE) ?? "";
  set phoneCode(String status) => _generalPref?.setString(PHONE_CODE, status) ?? "";

  String get notificationCount => _generalPref?.getString(NOTIFICATION_COUNT) ?? "";
  set notificationCount(String count) => _generalPref?.setString(NOTIFICATION_COUNT, count) ?? "";

  int get sellerId => _generalPref?.getInt(SELLER_ID) ?? 0;
  set sellerId(int id) => _generalPref?.setInt(SELLER_ID, id) ?? 0;

  bool get isAppAccessMessageShown => _generalPref?.getBool(SHOWN_APP_ACCESS_MSG)??false;
  set isAppAccessMessageShown(bool status) => _generalPref?.setBool(SHOWN_APP_ACCESS_MSG, status);

  bool get isAppBetaMessageShown => _generalPref?.getBool(APP_IN_BETA)??false;
  set isAppBetaMessageShown(bool status) => _generalPref?.setBool(APP_IN_BETA, status);
}
