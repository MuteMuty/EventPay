import 'dart:convert';
import 'dart:io';

import 'package:eventpay/models/user.dart';
import 'package:http/http.dart' as http;

import '../bloc/global/global_bloc.dart';
import '../models/card.dart';
import '../models/event.dart';
import '../server/routes.dart';
import '../util/either.dart';
import '../util/failures/backend_failure.dart';
import 'http_service.dart';

class BackendService {
  static BackendService? _instance;
  static BackendService get instance => _instance!;

  const BackendService._({required HttpService httpService})
      : _http = httpService;

  factory BackendService({required HttpService httpService}) {
    if (_instance != null) {
      throw StateError('BackendService already created');
    }

    _instance = BackendService._(httpService: httpService);
    return _instance!;
  }

  final HttpService _http;

  Future<Either<BackendFailure, List<EventPayEvent>>> getEvents() async {
    final GlobalBloc _globalBloc = GlobalBloc.instance;
    final http.Response? response = await _http.get(
      [
        EPServerRoute.apiAuthEvents,
      ],
      headers: <String, String>{
        'Username': _globalBloc.state.user!.username,
      },
    );
    if (response == null) return error(const UnknownBackendFailure());

    switch (response.statusCode) {
      case HttpStatus.ok:
        final List<dynamic> events = jsonDecode(response.body);

        List<EventPayEvent> eventPayEvents = [];

        for (Map<String, dynamic> event in events) {
          print("event: $event");
          eventPayEvents.add(EventPayEvent.fromJson(event));
        }

        return value(eventPayEvents);
      case HttpStatus.unauthorized:
        return error(const UnauthorizedBackendFailure());
      default:
        return error(BackendFailure.fromStatusCode(response.statusCode));
    }
  }

  Future<Either<BackendFailure, List<EventPayCard>>> getCards() async {
    final GlobalBloc _globalBloc = GlobalBloc.instance;
    final http.Response? response = await _http.get(
      [
        EPServerRoute.apiAuthCards,
      ],
      headers: <String, String>{
        'Username': _globalBloc.state.user!.username,
      },
    );
    if (response == null) return error(const UnknownBackendFailure());

    switch (response.statusCode) {
      case HttpStatus.ok:
        final List<dynamic> cards = jsonDecode(response.body);

        List<EventPayCard> eventPayCards = [];

        for (Map<String, dynamic> card in cards) {
          print("card: $card");
          eventPayCards.add(EventPayCard.fromJson(card));
        }

        return value(eventPayCards);
      case HttpStatus.unauthorized:
        return error(const UnauthorizedBackendFailure());
      default:
        return error(BackendFailure.fromStatusCode(response.statusCode));
    }
  }

  Future<Either<BackendFailure, bool>> postFillup(
      String cardNumber, double amount) async {
    final GlobalBloc _globalBloc = GlobalBloc.instance;
    final http.Response? response = await _http.post(
      [
        EPServerRoute.apiAuthTransactions,
        EPServerRoute.apiAuthTransactionsFillup,
      ],
      headers: <String, String>{
        'Username': _globalBloc.state.user!.username,
      },
      body: <String, dynamic>{
        'cardNumber': cardNumber,
        'amount': amount,
      },
    );
    if (response == null) return error(const UnknownBackendFailure());

    switch (response.statusCode) {
      case HttpStatus.ok:
        return value(jsonDecode(response.body));
      case HttpStatus.unauthorized:
        return error(const UnauthorizedBackendFailure());
      default:
        return error(BackendFailure.fromStatusCode(response.statusCode));
    }
  }
}
