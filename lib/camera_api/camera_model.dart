import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:theta_req_res/notifiers/camera_notifier.dart';
import 'dart:convert';
import 'package:theta_req_res/notifiers/response_notifier.dart';
import 'package:theta_req_res/notifiers/request_notifier.dart';
import 'package:theta_req_res/utils/format_json.dart';

class CameraModel extends StatelessWidget {
  const CameraModel({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () async {
        var url = 'http://192.168.1.1/osc/info';
        try {
          var fullResponse = await http.get(url);
          var body = jsonDecode(fullResponse.body);
          var model = body["model"];
          print(model);
          context
              .read<ResponseNotifier>()
              .updateResponse('You are using a $model');
          context
              .read<RequestNotifier>()
              .updateRequest('${fullResponse.request}');
          context.read<CameraNotifier>().updateModel(model);
          context.read<CameraNotifier>().setAppIntialized();
        } catch (error) {
          context
              .read<ResponseNotifier>()
              .updateResponse('request failed.\n\n Error code:\n $error');
          context
              .read<RequestNotifier>()
              .updateRequest('Request failed. \n\n Attempted URL:\n $url');
        }
      },
      child: Text('start'),
    );
  }
}
