import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:intl/intl.dart';

import 'package:eventpay/widgets/vec_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_flutter/qr_flutter.dart';

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

class KarticaDetailsScreenArgs {
  final String cardNumber;

  const KarticaDetailsScreenArgs({required this.cardNumber});
}

class KarticaDetailsScreen extends StatelessWidget {
  final KarticaDetailsScreenArgs args;
  const KarticaDetailsScreen({Key? key, required this.args}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => KarticeBloc(globalBloc: GlobalBloc.instance),
        child: _KarticaDetailsScreen(
          args: args,
        ));
  }
}

class _KarticaDetailsScreen extends StatelessWidget {
  final KarticaDetailsScreenArgs args;
  const _KarticaDetailsScreen({Key? key, required this.args}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('dd. MM. yyyy');
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return BlocBuilder<KarticeBloc, KarticeState>(
      builder: (context, state) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            backgroundColor: EPColor.backgroud,
            middle: Text(
              "Super event 12",
              style: EPStyles.pageTitleTextStyle(context),
            ),
          ),
          child: BlocBuilder<KarticeBloc, KarticeState>(
            builder: (context, state) {
              if (!state.initialized && state.isSuccessful == null) {
                return const Center(
                  child: LoadingIndicator(
                    radius: 25.0,
                    dotRadius: 8.0,
                  ),
                );
              } else if (state.isSuccessful == false) {
                return Container(
                    color: EPColor.resolveColor(context, EPColor.backgroud));
              }
              if (state.cards != null) {
                // Timer.periodic(Duration(seconds: 1), (timer) {
                //   context.read<KarticeBloc>().add(Update(state));
                // });
                final card = state.cards![0];
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: h * 0.03),
                          child: GestureDetector(
                            onTap: () {
                              SizedBox(
                                height: 200,
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    SvgPicture.asset(EPImage.logo,
                                        fit: BoxFit.cover),
                                    ClipRRect(
                                      // Clip it cleanly.
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 10, sigmaY: 10),
                                        child: Container(
                                          color: Colors.grey.withOpacity(0.1),
                                          alignment: Alignment.center,
                                          child: Text('CHOCOLATE'),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(24.0)),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        card.image,
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  width: double.infinity,
                                  height: h * 0.28,
                                ),
                                Container(
                                  // margin: const EdgeInsets.symmetric(horizontal: 20),
                                  margin: EdgeInsets.only(top: h * 0.15),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                  width: h * 0.2,
                                  height: h * 0.2,
                                  child: QrImage(
                                    data: card.cardNumber,
                                    version: QrVersions.auto,
                                    size: 200.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: GestureDetector(
                          onTap: () =>
                              context.read<KarticeBloc>().add(Update(state)),
                          child: Center(
                            child: Text(
                              "${card.amount} €",
                              style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.w300,
                                color: EPColor.highlightColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(child: const SizedBox(height: 20)),
                      SliverToBoxAdapter(
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_month,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Datum",
                              style: TextStyle(
                                fontSize: 14,
                                color: EPColor.highlightColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SliverToBoxAdapter(child: const SizedBox(height: 5)),
                      SliverToBoxAdapter(
                        child: Text(
                          "${formatter.format(DateTime.parse(card.startTime))} - ${formatter.format(DateTime.parse(card.endTime))}",
                          style: TextStyle(
                            fontSize: 20,
                            color: EPColor.highlightColor,
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(child: const SizedBox(height: 20)),
                      SliverToBoxAdapter(
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_city,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            const Text(
                              "Lokacija",
                              style: TextStyle(
                                fontSize: 14,
                                color: EPColor.highlightColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SliverToBoxAdapter(child: const SizedBox(height: 2)),
                      SliverToBoxAdapter(
                        child: Text(
                          "${card.location}",
                          style: TextStyle(
                            fontSize: 20,
                            color: EPColor.highlightColor,
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.only(top: h * 0.04),
                          child: Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: VecTextShadowButton.filled(
                                  text: "Polni kartico",
                                  textStyle: EPStyles.buttonTextStyle(context),
                                  color: EPColor.orange,
                                  onPressed: () => Navigator.pushNamed(
                                      context, EPRoute.fillUpCard),
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: VecTextShadowButton.filled(
                                  color: EPColor.secondary,
                                  text: "Transakcije",
                                  textStyle: EPStyles.buttonTextStyle(context),
                                  onPressed: () {},
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: VecTextShadowButton.filled(
                                  color: EPColor.secondary,
                                  text: "Prikaži cenik",
                                  textStyle: EPStyles.buttonTextStyle(context),
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
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
