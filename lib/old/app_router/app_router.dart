import 'package:buddy_app/old/view/addEvent.dart';
import 'package:buddy_app/old/view/buddy_community_selector.dart';
import 'package:buddy_app/old/view/buyEvent.dart';
import 'package:buddy_app/old/view/createNudge.dart';
import 'package:buddy_app/old/view/emailOTP.dart';
import 'package:buddy_app/old/view/eventDetails.dart';
import 'package:buddy_app/old/view/genderPreference1.dart';
import 'package:buddy_app/old/view/greenSplash.dart';
import 'package:buddy_app/old/view/home_screen/homepage.dart';
import 'package:buddy_app/old/view/interestCapture.dart';
import 'package:buddy_app/old/view/loginEmail.dart';
import 'package:buddy_app/old/view/loginPhone.dart';
import 'package:buddy_app/old/view/onBoarding.dart';
import 'package:buddy_app/old/view/phoneOTP.dart';
import 'package:buddy_app/old/view/wallet.dart';
import 'package:buddy_app/old/view/welcome.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/event_ticket_list.dart';
import '../view/loginOptions.dart';

final GoRouter router = GoRouter(
  initialLocation: '/genderPreference1',
  errorPageBuilder: (BuildContext context, state) => MaterialPage(
    key: state.pageKey,
    child: Scaffold(
      body: Center(
        child: Text(
          'Error ${state.error}',
          style: const TextStyle(color: Colors.red),
        ),
      ),
    ),
  ),
  routes: [
    GoRoute(path: '/', builder: (context, state) => WelcomeScreen()),
    GoRoute(path: '/loginOptions', builder: (context, state) => loginOptions()),
    GoRoute(path: '/loginPhone', builder: (context, state) => loginPhone()),
    GoRoute(path: '/phoneOTP', builder: (context, state) => phoneOTP()),
    GoRoute(path: '/loginEmail', builder: (context, state) => loginEmail()),
    GoRoute(path: '/emailOTP', builder: (context, state) => emailOTP()),
    GoRoute(path: '/greenSplash', builder: (context, state) => greenSplash()),
    GoRoute(
      path: '/onBoarding',
      builder: (context, state) => OnboardingScreen(),
    ),
    GoRoute(
      path: '/interestCapture',
      builder: (context, state) => interestCapture(),
    ),
    GoRoute(
      path: '/buddyCommunitySelector',
      builder: (context, state) => buddyCommunitySelector(),
    ),
    GoRoute(
      path: '/homepage',
      builder: (context, state) {
        final index = state.extra as int;
        return homepage(landingIndex: index);
      },
    ),
    GoRoute(path: '/wallet', builder: (context, state) => wallet()),
    GoRoute(
      path: '/eventDetails',
      builder: (context, state) {
        final event = state.extra as EventTicket; // ⬅ get event
        return EventDetailPage(event: event);
      },
    ),
    GoRoute(
      path: '/buyEvent',
      builder: (context, state) {
        final event = state.extra as EventTicket; // ⬅ get event
        return buyEvent(event: event);
      },
    ),
    GoRoute(path: '/addEvent', builder: (context, state) => AddEventPage()),
    GoRoute(path: '/createNudge', builder: (context, state) => CreateNudge()),
    GoRoute(
      path: '/genderPreference1',
      builder: (context, state) {
        final nextLocation = state.extra as String;
        return GenderPreference(nextLocation: nextLocation);
      },
    ),

    // builder: (context, state) => SearchScreen(),
  ],
);
