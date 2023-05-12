import 'dart:io';
import 'dart:ui';

import 'package:eventpay/models/event.dart';
import 'package:eventpay/widgets/vec_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../bloc/dogodki/dogodki_bloc.dart';
import '../bloc/global/global_bloc.dart';
import '../bloc/kartice/kartice_bloc.dart';
import '../models/card.dart';
import '../router/routes.dart';
import '../services/backend_service.dart';
import '../style/colors.dart';
import '../style/images.dart';
import '../style/styles.dart';
import '../util/failures/backend_failure.dart';
import '../util/failures/failure.dart';
import '../util/failures/validation_failure.dart';
import '../widgets/vec_card.dart';
import 'loading_indicator.dart';

class DogodkiDetailsScreenArgs {
  final int index;

  const DogodkiDetailsScreenArgs({required this.index});
}

class DogodkiDetailsScreen extends StatelessWidget {
  final DogodkiDetailsScreenArgs args;
  const DogodkiDetailsScreen({Key? key, required this.args}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            DogodkiBloc(backendService: BackendService.instance),
        child: _DogodkiDetailsScreen(
          args: args,
        ));
  }
}

class _DogodkiDetailsScreen extends StatelessWidget {
  final DogodkiDetailsScreenArgs args;
  const _DogodkiDetailsScreen({Key? key, required this.args}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('dd. MM. yyyy');
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return BlocBuilder<DogodkiBloc, DogodkiState>(
      builder: (context, state) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            backgroundColor: Colors.transparent,
            // middle: Text(
            //   "Super event 12",
            //   style: EPStyles.pageTitleTextStyle(context),
            // ),
          ),
          child: BlocBuilder<DogodkiBloc, DogodkiState>(
            builder: (context, state) {
              if (!state.initialized) {
                return const Center(
                  child: LoadingIndicator(
                    radius: 25.0,
                    dotRadius: 8.0,
                  ),
                );
              }
              if (state.cards != null) {
                final card = state.cards![args.index];
                return Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            card.image,
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: EPColor.almostBlack.withOpacity(0.45)),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(bottom: h * 0.04, right: w * 0.04),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            card.eventName,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "${formatter.format(DateTime.parse(card.startDate))} - ${formatter.format(DateTime.parse(card.endDate))}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.calendar_month,
                                color: Colors.white,
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                card.location,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.location_city,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                );
              }
              return Container();
            },
          ),
        );
      },
    );
  }
}

String getBackendFailureMessage(Failure failure) {
  if (failure is PreconditionFailedBackendFailure) {
    return "You don't have a vehicle added!";
  } else {
    return "Something went wrong. Please try again later.";
  }
}

String getValidationMessage(Failure failure) {
  if (failure is AddressValidationFailure) {
    return "Please enter valid address";
  } else if (failure is DateValidationFailure) {
    return "Please enter valid date";
  } else if (failure is IntegerParsingFailure) {
    return "Please enter valid number of available seats";
  } else if (failure is PriceValidationFailure) {
    return "Please enter a valid price";
  } else {
    return "Unknown error";
  }
}
