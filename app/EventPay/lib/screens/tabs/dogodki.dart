import 'package:eventpay/widgets/dogodek_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../bloc/dogodki/dogodki_bloc.dart';
import '../../router/routes.dart';
import '../../services/backend_service.dart';
import '../../style/colors.dart';
import '../../style/images.dart';
import '../../style/styles.dart';
import '../dogodki_details.dart';
import '../loading_indicator.dart';

class DogodkiTab extends StatelessWidget {
  const DogodkiTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DogodkiBloc>(
      create: (context) => DogodkiBloc(backendService: BackendService.instance),
      child: const _DogodkiTab(),
    );
  }
}

class _DogodkiTab extends StatelessWidget {
  const _DogodkiTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('dd. MM. yyyy');
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor: EPColor.backgroud,
          middle: Text(
            "Dogodki",
            style: EPStyles.pageTitleTextStyle(context),
          ),
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
            return ListView.builder(
              itemCount: state.cards!.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    DogodekCard(
                      datum: formatter.format(
                          DateTime.parse(state.cards![index].startDate)),
                      kraj: state.cards![index].location,
                      naslov: state.cards![index].eventName,
                      slika: state.cards![index].image,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          EPRoute.dogodkiDetailsScreen,
                          arguments: DogodkiDetailsScreenArgs(
                            index: index,
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                );
              },
            );
          },
        ));
  }
}
