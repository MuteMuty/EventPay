import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/global/global_bloc.dart';
import '../../../bloc/profil/profil_bloc.dart';
import '../../router/routes.dart';
import '../../services/backend_service.dart';
import '../../style/colors.dart';
import '../../style/styles.dart';
import '../../util/failures/backend_failure.dart';
import '../../widgets/vec_button.dart';
import '../loading_indicator.dart';
import '../sign_in.dart';

final GlobalBloc _globalBloc = GlobalBloc.instance;

class ProfilTab extends StatelessWidget {
  const ProfilTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfilBloc(
        backendService: BackendService.instance,
        globalBloc: _globalBloc,
      ),
      child: const _ProfilTab(),
    );
  }
}

class _ProfilTab extends StatelessWidget {
  const _ProfilTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProfilBloc bloc = BlocProvider.of<ProfilBloc>(context);
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: EPColor.backgroud,
        middle: Text(
          "Profil",
          style: EPStyles.pageTitleTextStyle(context),
        ),
      ),
      child: BlocBuilder<ProfilBloc, ProfilState>(
        builder: (context, state) {
          print("profil state: ${state.user}");
          if (state.isLoading) {
            return const Center(
              child: LoadingIndicator(
                dotRadius: 8,
                radius: 24,
              ),
            );
          }
          if (state.initialized == false || state.failure != null) {
            return const SizedBox();
          }
          return Stack(
            children: [
              Positioned(
                bottom: 24,
                left: 18,
                right: 18,
                child: VecTextShadowButton.filled(
                  textStyle: EPStyles.buttonTextStyle(context),
                  text: "Log out",
                  color: EPColor.orange,
                  onPressed: () async {
                    _globalBloc.reset();
                    Navigator.of(context, rootNavigator: true)
                        .pushReplacementNamed(
                      EPRoute.signIn,
                      arguments: SignInScreenArgs(
                        username: '',
                        password: '',
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
