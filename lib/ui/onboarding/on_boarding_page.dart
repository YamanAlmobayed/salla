import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:salla/ui/index/cubit/app_cubit.dart';
import 'package:salla/ui/onboarding/widgets/on_boarding_item.dart';
import 'package:salla/utils/router/routes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../widgets/default_text_button.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  bool _isLast = false;
  final boardController = PageController();

  @override
  void dispose() {
    boardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          DefaultTextButton(
              onPressed: () {
                context.read<AppCubit>().onBoardingSubmit(context);

                context.pushReplacementNamed(AppRoutes().login);
              },
              text: 'SKIP')
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (index) {
                  if (index == context.read<AppCubit>().onboarding.length - 1) {
                    setState(() {
                      _isLast = true;
                    });
                  } else {
                    setState(() {
                      _isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) => OnBoardingItem(
                    model: context.read<AppCubit>().onboarding[index]),
                itemCount: context.read<AppCubit>().onboarding.length,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardController,
                    effect: const ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: Colors.blue,
                      dotHeight: 10,
                      dotWidth: 10,
                      expansionFactor: 4,
                      spacing: 5,
                    ),
                    count: context.read<AppCubit>().onboarding.length),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (_isLast) {
                      context.read<AppCubit>().onBoardingSubmit(context);
                      context.pushReplacementNamed(AppRoutes().login);
                    } else {
                      boardController.nextPage(
                          duration: const Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
