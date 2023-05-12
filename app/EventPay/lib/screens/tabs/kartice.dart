import 'package:eventpay/services/backend_service.dart';
import 'package:eventpay/widgets/vec_button.dart';
import 'package:eventpay/widgets/vec_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/global/global_bloc.dart';
import '../../../bloc/kartice/kartice_bloc.dart';
import '../../../router/routes.dart';
import '../../../style/colors.dart';
import '../../../style/images.dart';
import '../../../style/styles.dart';
import '../../router/router.dart';
import '../loading_indicator.dart';

class KarticeTab extends StatelessWidget {
  const KarticeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<KarticeBloc>(
      create: (context) => KarticeBloc(globalBloc: GlobalBloc.instance),
      child: const _KarticeTab(),
    );
  }
}

class _KarticeTab extends StatelessWidget {
  const _KarticeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor: EPColor.backgroud,
          middle: Text(
            "Kartice",
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
            return ListView.builder(
              itemCount: state.cards!.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    EPCard(
                      title: state.cards![index].eventName,
                      money: state.cards![index].amount,
                      pic: state.cards![index].image,
                      onTap: () {
                        context.read<KarticeBloc>().emit(state.copyWith(selectedCard: state.cards![index]));
                        Navigator.pushNamed(
                          context,
                          "/karticaDetailsScreen",
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
