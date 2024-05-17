// import '../../../../app.dart';

import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:connect_me/config/extensions/extensions.dart';
import 'package:connect_me/src/onboarding/Presentation/screens/check_auth_state_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants/image_constants.dart';
import '../../../../config/constants/screens_constants.dart';
import '../../../../config/theme/theme.dart';
import '../../../utils/utils.dart';
import '../../Infrastructure/repository/auth_repo_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    ref.read(analyticsProvider).logAppOpen();

    navigateToNexToScreen().then((_) {
      pushReplacement(
        context,
        const CheckAuthStateScreen(
          key: ValueKey('check_auth_state_screen'),
        ),
        ref: ref,
        routeName: ScreenName.checkAuthStateScreen,
      );
    });
    super.initState();
  }

  Future<void> navigateToNexToScreen() async {
    return await Future.delayed(const Duration(milliseconds: 2000));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            bottom: context.sizeHeight(0.43),
            right: context.sizeWidth(0.0001),
            left: context.sizeWidth(0.0001),
            child: FadeInRightBig(
              child: Image.asset(
                ImagesConstant.appLogoBrown,
                fit: BoxFit.contain,
                height: 200,
                width: 200,
              ),
            ),
          ),
          Positioned(
            bottom: context.sizeHeight(0.4),
            left: context.sizeWidth(0.2),
            child: FadeInLeft(
              child: const AutoSizeText(
                'Connect Me',
                style: TextStyle(
                  fontFamily: 'Kenia',
                  fontWeight: AppFontWeight.w600,
                  fontSize: 25,
                ),
                textScaleFactor: 2.3,
                maxLines: 1,
              ),
            ),
          )
        ],
      ),
    );
  }
}
