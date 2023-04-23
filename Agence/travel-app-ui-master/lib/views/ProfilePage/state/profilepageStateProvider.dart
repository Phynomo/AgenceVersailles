import 'package:flutter/material.dart';
import 'package:travelappui/utils/restAPI.dart';

class ProfilePageStateProvider extends ChangeNotifier {

  RESTAPI api = RESTAPI();

  Future<dynamic> updatePfp(data, context) async {
    return await api.updatePfp(data, context);

  }
}
