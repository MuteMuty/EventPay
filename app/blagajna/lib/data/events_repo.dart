import 'dart:convert';

import 'package:blagajna/data/login_repo.dart';
import 'package:blagajna/data/models/event_model.dart';
import 'package:blagajna/data/models/order_post_model.dart';
import 'package:blagajna/data/url_constants.dart';
import 'package:dio/dio.dart';

class EventsRepo {
  Future<List<EventModel>> getEvents() async {
    try {
      var dio = Dio();

      var response = await Dio().get(
          UrlConstants.baseUrl + UrlConstants.eventsUrl,
          options: Options(
              contentType: "application/json",
              headers: {'WorkerUsername': LoginRepo.username}));
      var responseBody = response.data;
      List<EventModel> models = [];
      for (var x in responseBody) {
        models.add(EventModel.fromJson(x));
      }
      return models;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> postTransaction(OrderPostModel model) async {
    model = model;
    try {
      var response = await Dio().post(
        UrlConstants.baseUrl + UrlConstants.orderUrl,
        data: model.toJson(),
        options: Options(
          contentType: "application/json",
        ),
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
