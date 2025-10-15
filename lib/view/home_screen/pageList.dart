import 'package:buddy_app/constants/event_type_class.dart';
import 'package:buddy_app/constants/nudge_model.dart';
import 'package:buddy_app/view/home_screen/community.dart';
import 'package:buddy_app/view/home_screen/events.dart';
import 'package:buddy_app/view/home_screen/home.dart';
import 'package:buddy_app/view/home_screen/nudge.dart';
import 'package:flutter/material.dart';

import '../../constants/event_ticket_list.dart';

final List<Widget> pages = [
  home(
    profiles: [
      ProfileCard(
        name: "Sakshi Thombre",
        age: 21,
        description: "I love eating golgappe and chat almost all the time ",
        cityOfOrigin: "Jabalpur",
        yearsInCity: 5,
        whatILove:
            "I love the people here, the vibe is something that you can catch up on easily and make new friends",
        occupation: "I work as a UI Designer at NewBridge Fintech technologies",
        interests: ["Sports"],
        imageUrl: "assets/onboarding/avatar_1.png",
      ),
      ProfileCard(
        name: "Sakshi Thombre",
        age: 21,
        description: "I love eating golgappe and chat almost all the time ",
        cityOfOrigin: "Jabalpur",
        yearsInCity: 5,
        whatILove:
            "I love the people here, the vibe is something that you can catch up on easily and make new friends",
        occupation: "I work as a UI Designer at NewBridge Fintech technologies",
        interests: ["Sports"],
        imageUrl: "assets/onboarding/avatar_1.png",
      ),
      ProfileCard(
        name: "Sakshi Thombre",
        age: 21,
        description: "I love eating golgappe and chat almost all the time ",
        cityOfOrigin: "Jabalpur",
        yearsInCity: 5,
        whatILove:
            "I love the people here, the vibe is something that you can catch up on easily and make new friends",
        occupation: "I work as a UI Designer at NewBridge Fintech technologies",
        interests: ["Sports"],
        imageUrl: "assets/onboarding/avatar_1.png",
      ),
    ],
  ),
  CommunityPage(
    allEvents: [
      EventTicket(
        about:
            "Lollapalooza India 2026 is set to electrify Mumbai at the Mahalaxmi Race Course on January 24–25, 2026, featuring over 40 artists spread across four stages, The festival’s headliners include the legendary Linkin Park—marking their first-ever performance in India—alongside Playboi Carti, Yungblud, and ",
        whatsNew: [
          "Linkin Park makes their long-awaited debut in India",
          "Playboi Carti brings an explosive show",
          "over 40 international and Indian acts",
          "#LollaForChange initiative",
        ],
        title: "POTTERY WORKSHOP",
        venue: "Mahalaxmi Race Course, Mumbai",
        date: "12th Jan 2025",
        price: 1250,
        time: "4:30",
        bookedSeats: 65,
        totalSeats: 100,
        pic: "assets/events/eventPic.png",
        type: EventStyles.of(EventType.sports_fitness),
      ),
      EventTicket(
        about:
            "Lollapalooza India 2026 is set to electrify Mumbai at the Mahalaxmi Race Course on January 24–25, 2026, featuring over 40 artists spread across four stages, The festival’s headliners include the legendary Linkin Park—marking their first-ever performance in India—alongside Playboi Carti, Yungblud, and ",
        whatsNew: [
          "Linkin Park makes their long-awaited debut in India",
          "Playboi Carti brings an explosive show",
          "over 40 international and Indian acts",
          "#LollaForChange initiative",
        ],
        title: "POTTERY WORKSHOP",
        venue: "Mahalaxmi Race Course, Mumbai",
        date: "12th Jan 2025",
        price: 1250,
        time: "4:30",
        bookedSeats: 65,
        totalSeats: 100,
        pic: "assets/events/eventPic2.png",
        type: EventStyles.of(EventType.sports_fitness),
      ),
    ],
    popularEvents: [
      EventTicket(
        about:
            "Lollapalooza India 2026 is set to electrify Mumbai at the Mahalaxmi Race Course on January 24–25, 2026, featuring over 40 artists spread across four stages, The festival’s headliners include the legendary Linkin Park—marking their first-ever performance in India—alongside Playboi Carti, Yungblud, and ",
        whatsNew: [
          "Linkin Park makes their long-awaited debut in India",
          "Playboi Carti brings an explosive show",
          "over 40 international and Indian acts",
          "#LollaForChange initiative",
        ],
        title: "POTTERY WORKSHOP",
        venue: "Mahalaxmi Race Course, Mumbai",
        date: "12th Jan 2025",
        price: 1250,
        time: "4:30",
        bookedSeats: 65,
        totalSeats: 100,
        pic: "assets/events/eventPic.png",
        type: EventStyles.of(EventType.art_design),
      ),
      EventTicket(
        about:
            "Lollapalooza India 2026 is set to electrify Mumbai at the Mahalaxmi Race Course on January 24–25, 2026, featuring over 40 artists spread across four stages, The festival’s headliners include the legendary Linkin Park—marking their first-ever performance in India—alongside Playboi Carti, Yungblud, and ",
        whatsNew: [
          "Linkin Park makes their long-awaited debut in India",
          "Playboi Carti brings an explosive show",
          "over 40 international and Indian acts",
          "#LollaForChange initiative",
        ],
        title: "POTTERY WORKSHOP",
        venue: "Mahalaxmi Race Course, Mumbai",
        date: "12th Jan 2025",
        price: 1250,
        time: "4:30",
        bookedSeats: 65,
        totalSeats: 100,
        pic: "assets/events/eventPic2.png",
        type: EventStyles.of(EventType.sports_fitness),
      ),
    ],
  ),
  NudgePage(
    nudges: [
      Nudge(
        id: "id",
        title: "Sightseeing",
        description: "description",
        location: "Koramangala, Bangalore",
        dateTime: DateTime(2025),
        category: "category",
        postedBy: "Sakshi Thombre",
        attendeesCount: 69,
        status: "status",
      ),
      Nudge(
        id: "id",
        title: "title",
        description: "description",
        location: "location",
        dateTime: DateTime(2025),
        category: "category",
        postedBy: "postedBy",
        attendeesCount: 69,
        status: "status",
      ),
    ],
    ongoingNudges: [
      NudgeRequests(
        id: "id",
        title: "Flat Hunting for two people in Bangalore",
        description: "description",
        location: "location",
        dateTime: DateTime(2025),
        category: "category",
        postedBy: "postedBy",
        attendeesCount: 69,
        status: "status",
        requests: [
          Requestor(
            name: "Khush Gupta",
            age: 22,
            interests: [
              EventStyles.of(EventType.music),
              EventStyles.of(EventType.art_design),
              EventStyles.of(EventType.books_literature),
            ],
            pic: "assets/nudges/dummyRequestor.png",
          ),
          Requestor(
            name: "Khush Gupta",
            age: 22,
            interests: [
              EventStyles.of(EventType.music),
              EventStyles.of(EventType.art_design),
              EventStyles.of(EventType.books_literature),
            ],
            pic: "assets/nudges/dummyRequestor.png",
          ),
          Requestor(
            name: "Khush Gupta",
            age: 22,
            interests: [
              EventStyles.of(EventType.music),
              EventStyles.of(EventType.art_design),
              EventStyles.of(EventType.books_literature),
            ],
            pic: "assets/nudges/dummyRequestor.png",
          ),
        ],
      ),
      NudgeRequests(
        id: "id",
        title: "title",
        description: "description",
        location: "location",
        dateTime: DateTime(2025),
        category: "category",
        postedBy: "postedBy",
        attendeesCount: 69,
        status: "status",
        requests: [
          Requestor(
            name: "Khush Gupta",
            age: 22,
            interests: [
              EventStyles.of(EventType.music),
              EventStyles.of(EventType.art_design),
              EventStyles.of(EventType.books_literature),
            ],
            pic: "assets/nudges/dummyRequestor.png",
          ),
        ],
      ),
      NudgeRequests(
        id: "id",
        title: "title",
        description: "description",
        location: "location",
        dateTime: DateTime(2025),
        category: "category",
        postedBy: "postedBy",
        attendeesCount: 69,
        status: "status",
        requests: [
          Requestor(
            name: "Khush Gupta",
            age: 22,
            interests: [
              EventStyles.of(EventType.music),
              EventStyles.of(EventType.art_design),
              EventStyles.of(EventType.books_literature),
            ],
            pic: "assets/nudges/dummyRequestor.png",
          ),
        ],
      ),
    ],
    Expired: [
      NudgeRequests(
        id: "id",
        title: "title",
        description: "description",
        location: "location",
        dateTime: DateTime(2025),
        category: "category",
        postedBy: "postedBy",
        attendeesCount: 69,
        status: "status",
        requests: [
          Requestor(
            name: "Khush Gupta",
            age: 22,
            interests: [
              EventStyles.of(EventType.music),
              EventStyles.of(EventType.art_design),
              EventStyles.of(EventType.books_literature),
            ],
            pic: "assets/nudges/dummyRequestor.png",
          ),
        ],
      ),
      NudgeRequests(
        id: "id",
        title: "title",
        description: "description",
        location: "location",
        dateTime: DateTime(2025),
        category: "category",
        postedBy: "postedBy",
        attendeesCount: 69,
        status: "status",
        requests: [
          Requestor(
            name: "Khush Gupta",
            age: 22,
            interests: [
              EventStyles.of(EventType.music),
              EventStyles.of(EventType.art_design),
              EventStyles.of(EventType.books_literature),
            ],
            pic: "assets/nudges/dummyRequestor.png",
          ),
        ],
      ),
      NudgeRequests(
        id: "id",
        title: "title",
        description: "description",
        location: "location",
        dateTime: DateTime(2025),
        category: "category",
        postedBy: "postedBy",
        attendeesCount: 69,
        status: "status",
        requests: [
          Requestor(
            name: "Khush Gupta",
            age: 22,
            interests: [
              EventStyles.of(EventType.music),
              EventStyles.of(EventType.art_design),
              EventStyles.of(EventType.books_literature),
            ],
            pic: "assets/nudges/dummyRequestor.png",
          ),
        ],
      ),
    ],
    Sent: [
      Nudge(
        id: "id",
        title: "title",
        description: "description",
        location: "location",
        dateTime: DateTime(2025),
        category: "category",
        postedBy: "postedBy",
        attendeesCount: 69,
        status: "status",
      ),
    ],
  ),
  Center(child: Text('Events')),
  events(
    presentEvents: [
      EventTicket(
        about:
            "Lollapalooza India 2026 is set to electrify Mumbai at the Mahalaxmi Race Course on January 24–25, 2026, featuring over 40 artists spread across four stages, The festival’s headliners include the legendary Linkin Park—marking their first-ever performance in India—alongside Playboi Carti, Yungblud, and ",
        whatsNew: [
          "Linkin Park makes their long-awaited debut in India",
          "Playboi Carti brings an explosive show",
          "over 40 international and Indian acts",
          "#LollaForChange initiative",
        ],
        title: "POTTERY WORKSHOP",
        venue: "Mahalaxmi Race Course, Mumbai",
        date: "12th Jan 2025",
        price: 1250,
        time: "4:30",
        bookedSeats: 65,
        totalSeats: 100,
        pic: "assets/events/eventPic2.png",
        type: EventStyles.of(EventType.sports_fitness),
      ),
      EventTicket(
        about:
            "Lollapalooza India 2026 is set to electrify Mumbai at the Mahalaxmi Race Course on January 24–25, 2026, featuring over 40 artists spread across four stages, The festival’s headliners include the legendary Linkin Park—marking their first-ever performance in India—alongside Playboi Carti, Yungblud, and ",
        whatsNew: [
          "Linkin Park makes their long-awaited debut in India",
          "Playboi Carti brings an explosive show",
          "over 40 international and Indian acts",
          "#LollaForChange initiative",
        ],
        title: "POTTERY WORKSHOP",
        venue: "Mahalaxmi Race Course, Mumbai",
        date: "12th Jan 2025",
        price: 1250,
        time: "4:30",
        bookedSeats: 65,
        totalSeats: 100,
        pic: "assets/events/eventPic2.png",
        type: EventStyles.of(EventType.sports_fitness),
      ),
    ],
    pastEvents: [
      EventTicket(
        about:
            "Lollapalooza India 2026 is set to electrify Mumbai at the Mahalaxmi Race Course on January 24–25, 2026, featuring over 40 artists spread across four stages, The festival’s headliners include the legendary Linkin Park—marking their first-ever performance in India—alongside Playboi Carti, Yungblud, and ",
        whatsNew: [
          "Linkin Park makes their long-awaited debut in India",
          "Playboi Carti brings an explosive show",
          "over 40 international and Indian acts",
          "#LollaForChange initiative",
        ],
        title: "POTTERY WORKSHOP",
        venue: "Mahalaxmi Race Course, Mumbai",
        date: "12th Jan 2025",
        price: 1250,
        time: "4:30",
        bookedSeats: 65,
        totalSeats: 100,
        pic: "assets/events/eventPic2.png",
        type: EventStyles.of(EventType.sports_fitness),
      ),
      EventTicket(
        about:
            "Lollapalooza India 2026 is set to electrify Mumbai at the Mahalaxmi Race Course on January 24–25, 2026, featuring over 40 artists spread across four stages, The festival’s headliners include the legendary Linkin Park—marking their first-ever performance in India—alongside Playboi Carti, Yungblud, and ",
        whatsNew: [
          "Linkin Park makes their long-awaited debut in India",
          "Playboi Carti brings an explosive show",
          "over 40 international and Indian acts",
          "#LollaForChange initiative",
        ],
        title: "POTTERY WORKSHOP",
        venue: "Mahalaxmi Race Course, Mumbai",
        date: "12th Jan 2025",
        price: 1250,
        time: "4:30",
        bookedSeats: 65,
        totalSeats: 100,
        pic: "assets/events/eventPic2.png",
        type: EventStyles.of(EventType.sports_fitness),
      ),
    ],
    myPresentEvents: [
      EventTicket(
        about:
            "Lollapalooza India 2026 is set to electrify Mumbai at the Mahalaxmi Race Course on January 24–25, 2026, featuring over 40 artists spread across four stages, The festival’s headliners include the legendary Linkin Park—marking their first-ever performance in India—alongside Playboi Carti, Yungblud, and ",
        whatsNew: [
          "Linkin Park makes their long-awaited debut in India",
          "Playboi Carti brings an explosive show",
          "over 40 international and Indian acts",
          "#LollaForChange initiative",
        ],
        title: "POTTERY WORKSHOP",
        venue: "Mahalaxmi Race Course, Mumbai",
        date: "12th Jan 2025",
        price: 1250,
        time: "4:30",
        bookedSeats: 65,
        totalSeats: 100,
        pic: "assets/events/eventPic2.png",
        type: EventStyles.of(EventType.sports_fitness),
      ),
      EventTicket(
        about:
            "Lollapalooza India 2026 is set to electrify Mumbai at the Mahalaxmi Race Course on January 24–25, 2026, featuring over 40 artists spread across four stages, The festival’s headliners include the legendary Linkin Park—marking their first-ever performance in India—alongside Playboi Carti, Yungblud, and ",
        whatsNew: [
          "Linkin Park makes their long-awaited debut in India",
          "Playboi Carti brings an explosive show",
          "over 40 international and Indian acts",
          "#LollaForChange initiative",
        ],
        title: "POTTERY WORKSHOP",
        venue: "Mahalaxmi Race Course, Mumbai",
        date: "12th Jan 2025",
        price: 1250,
        time: "4:30",
        bookedSeats: 65,
        totalSeats: 100,
        pic: "assets/events/eventPic2.png",
        type: EventStyles.of(EventType.sports_fitness),
      ),
    ],
    myPastEvents: [
      EventTicket(
        about:
            "Lollapalooza India 2026 is set to electrify Mumbai at the Mahalaxmi Race Course on January 24–25, 2026, featuring over 40 artists spread across four stages, The festival’s headliners include the legendary Linkin Park—marking their first-ever performance in India—alongside Playboi Carti, Yungblud, and ",
        whatsNew: [
          "Linkin Park makes their long-awaited debut in India",
          "Playboi Carti brings an explosive show",
          "over 40 international and Indian acts",
          "#LollaForChange initiative",
        ],
        title: "POTTERY WORKSHOP",
        venue: "Mahalaxmi Race Course, Mumbai",
        date: "12th Jan 2025",
        price: 1250,
        time: "4:30",
        bookedSeats: 65,
        totalSeats: 100,
        pic: "assets/events/eventPic2.png",
        type: EventStyles.of(EventType.sports_fitness),
      ),
      EventTicket(
        about:
            "Lollapalooza India 2026 is set to electrify Mumbai at the Mahalaxmi Race Course on January 24–25, 2026, featuring over 40 artists spread across four stages, The festival’s headliners include the legendary Linkin Park—marking their first-ever performance in India—alongside Playboi Carti, Yungblud, and ",
        whatsNew: [
          "Linkin Park makes their long-awaited debut in India",
          "Playboi Carti brings an explosive show",
          "over 40 international and Indian acts",
          "#LollaForChange initiative",
        ],
        title: "POTTERY WORKSHOP",
        venue: "Mahalaxmi Race Course, Mumbai",
        date: "12th Jan 2025",
        price: 1250,
        time: "4:30",
        bookedSeats: 65,
        totalSeats: 100,
        pic: "assets/events/eventPic2.png",
        type: EventStyles.of(EventType.sports_fitness),
      ),
    ],
  ),
];
