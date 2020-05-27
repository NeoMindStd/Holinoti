import 'dart:async';

import 'package:flutter/material.dart';
import 'package:holinoti_admin/bloc/auth_bloc.dart';
import 'package:holinoti_admin/bloc/facility_input_bloc.dart';
import 'package:holinoti_admin/bloc/home_bloc.dart';
import 'package:holinoti_admin/constants/enums.dart' as Enums;
import 'package:holinoti_admin/constants/nos.dart' as Nos;
import 'package:holinoti_admin/constants/strings.dart' as Strings;
import 'package:holinoti_admin/data/facility.dart';
import 'package:holinoti_admin/data/user.dart';
import 'package:holinoti_admin/utils/data_manager.dart';
import 'package:holinoti_admin/utils/http_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:http_auth/http_auth.dart' as http_auth;
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class SplashPage extends StatelessWidget {
  Future autoLogIn() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      String account = prefs.getString(Strings.Preferences.ACCOUNT);
      String password = prefs.getString(Strings.Preferences.PASSWORD);

      if (account == null || password == null) return;

      DataManager().client = http_auth.BasicAuthClient(
        account,
        password,
      );
      http.Response userResponse = await DataManager().client.post(
        Strings.HttpApis.LOGIN_URI,
        headers: {
          Strings.HttpApis.HEADER_NAME_CONTENT_TYPE:
              Strings.HttpApis.HEADER_VALUE_CONTENT_TYPE
        },
      );

      var decodedUserResponse = HttpDecoder.utf8Response(userResponse);
      print('Response: $decodedUserResponse');
      decodedUserResponse['authority'] = Enums.fromString(
          Enums.Authority.values, decodedUserResponse['authority']);

      DataManager().currentUser = User.fromJson(decodedUserResponse);
      print('Login: ${DataManager().currentUser}');
    } catch (e) {
      print(e);
    }
  }

  loadData(BuildContext context) async {
    await DataManager().queryPosition();
    print("========Where========");
    print(DataManager().currentPosition);
    print("====================");
    if ((await SharedPreferences.getInstance())
            .getBool(Strings.Preferences.IS_AUTO_LOGIN_MODE) ??
        true) {
      await autoLogIn();
    } else {}

    if (DataManager().currentUser != null &&
        DataManager().currentUser.id != Nos.Global.NOT_ASSIGNED_ID) {
      await AuthBloc.loadFacilities();
    } else {
      http.Response facilitiesResponse = await http.get(
        "http://holinoti.tk:8080/holinoti/facilities/x=${DataManager().currentPosition.longitude}/y=${DataManager().currentPosition.latitude}/distance_m=500",
        headers: {
          Strings.HttpApis.HEADER_NAME_CONTENT_TYPE:
              Strings.HttpApis.HEADER_VALUE_CONTENT_TYPE
        },
      );
      var decodedFacilitiesResponse =
          HttpDecoder.utf8Response(facilitiesResponse);
      print(decodedFacilitiesResponse);
      for (var facilityResponse in decodedFacilitiesResponse) {
        try {
          DataManager().addFacility(Facility.fromJson(facilityResponse));
        } catch (e) {
          print(e);
        }
      }
      print("queryByPosition: ${DataManager().facilities}");
    }

    onDoneLoading(context);
  }

  onDoneLoading(BuildContext context) async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HomePage(HomeBloc(), FacilityInputBloc())));
  }

  @override
  Widget build(BuildContext context) {
    loadData(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage(Strings.Assets.TEMP_IMAGE_L),
        ),
      ),
    );
  }
}
