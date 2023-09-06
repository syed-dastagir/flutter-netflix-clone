import 'package:flutter/material.dart';
import 'package:watchit/view/main_screen/main_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/logo.png',
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (builder) {
                          return const MainScreen();
                        }));
                      },
                      child: Text(
                        'Skip',
                        style: textTheme.labelMedium,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Unlimited movies, TV shows, and more.',
                      style: textTheme.displayLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                        style: textTheme.titleMedium,
                        textAlign: TextAlign.center,
                        'Watch anywhere. Cancel anytime. Tap the link below to get started.'),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    alignment: Alignment.bottomCenter,
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red),
                              onPressed: () {
                                print('tapped on sign in button');
                              },
                              child: Text(
                                'Sign In',
                                style: textTheme.labelMedium!
                                    .copyWith(color: Colors.white),
                              )),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Don\'t have an account? ',
                                textAlign: TextAlign.right,
                                style: textTheme.labelSmall,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                ' Register',
                                textAlign: TextAlign.right,
                                style: textTheme.labelMedium!
                                    .copyWith(color: Colors.red),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
