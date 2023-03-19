import 'package:flutter/material.dart';
import 'package:onboard_animation/components/landed_content.dart';
import 'package:onboard_animation/components/sing_up_form.dart';

class OnboardContent extends StatefulWidget {
  const OnboardContent({super.key});

  @override
  State<OnboardContent> createState() => _OnboardContentState();
}

class _OnboardContentState extends State<OnboardContent> {
  final _onBoardPageController = PageController(initialPage: 0);

  @override
  void initState() {
    _onBoardPageController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _onBoardPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double progress = _onBoardPageController.hasClients
        ? _onBoardPageController.page ?? 0
        : 0;
    return WillPopScope(
      onWillPop: () async => false,
      //prevents Android back button and outside tap from popping it
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {}, //prevents taps inside the sheet from popping it
        onVerticalDragStart: (_) {}, //prevents dragging down from popping it
        child: SizedBox(
          height: 400 + progress * 140,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Column(
                children: [
                  const SizedBox(height: 16),
                  Expanded(
                    child: PageView(
                      controller: _onBoardPageController,
                      children: const [
                        LandingContent(),
                        SignUpForm(),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                height: 56,
                bottom: 32 + progress * 140,
                right: 16,
                child: InkWell(
                  onTap: () {
                    if (_onBoardPageController.hasClients) {
                      if (_onBoardPageController.page == null ||
                          _onBoardPageController.page == 0) {
                        _onBoardPageController.animateToPage(
                          _onBoardPageController.initialPage + 1,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      } else {
                        _onBoardPageController.animateToPage(
                          _onBoardPageController.initialPage,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      }
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        stops: [0.4, 0.8],
                        colors: [
                          Color.fromARGB(255, 239, 104, 80),
                          Color.fromARGB(255, 139, 33, 146)
                        ],
                      ),
                    ),
                    child: DefaultTextStyle(
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 96 + progress * 32,
                            child: Stack(
                              children: [
                                Opacity(
                                  opacity: 1.0 - progress,
                                  child: const Text("Get Started"),
                                ),
                                Opacity(
                                  opacity: progress,
                                  child: const Text(
                                    "Create Account",
                                    maxLines: 1,
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.chevron_right,
                            size: 24,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
