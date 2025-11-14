import 'package:buddy_app/old/Widgets/appBar.dart';
import 'package:buddy_app/old/Widgets/navBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../constants/event_ticket_list.dart';

class buyEvent extends ConsumerStatefulWidget {
  final EventTicket event;

  const buyEvent({super.key, required this.event});

  @override
  ConsumerState<buyEvent> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends ConsumerState<buyEvent> {
  late int _count;
  @override
  void initState() {
    super.initState();
    _count = 1;
  }

  void _increment() {
    setState(() {
      _count++;
    });
  }

  void _decrement() {
    if (_count > 0) {
      setState(() {
        _count--;
      });
    }
  }

  String? _selected = "Myself";
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final event = widget.event;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarr(
        Name: "Sakshi",
        Location: "Delhi",
      ), // your reusable appbar

      body: Stack(
        children: [
          Positioned.fill(
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Image.asset("assets/community/buyEventBG.png", scale: 1),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Banner Image
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Background ticket image
                        Image.asset(event.type.ticketAsset, fit: BoxFit.fill),

                        // Details overlay
                        Padding(
                          padding: const EdgeInsets.fromLTRB(60, 20, 0, 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(padding: EdgeInsets.only(top: 10)),
                              // Title + Icon
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    event.title,
                                    style: TextStyle(
                                      fontFamily: "Bebas Neue",
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1E1E1E),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Image.asset(event.type.iconAsset, scale: 4),
                                ],
                              ),
                              const SizedBox(height: 0),

                              // Venue
                              Text(
                                "Venue  ${event.venue}",
                                style: TextStyle(
                                  fontSize: 8,
                                  fontFamily: "Rethink Sans",
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF1E1E1E),
                                ),
                              ),
                              const SizedBox(height: 4),

                              // Date
                              Text(
                                "Date   ${event.date}",
                                style: TextStyle(
                                  fontSize: 8,
                                  fontFamily: "Rethink Sans",
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF1E1E1E),
                                ),
                              ),
                              const SizedBox(height: 10),

                              // Price
                              Text(
                                "₹${event.price}",
                                style: TextStyle(
                                  fontFamily: "Bebas Neue",
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1E1E1E),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Category
                        Text(
                          "You are getting this ticket for:",
                          style: TextStyle(
                            fontFamily: "Rethink Sans",
                            fontSize: 16,
                            fontVariations: [FontVariation("wght", 1000)],
                            color: Color(0xFF555555),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Transform.scale(
                              scale: .75, // Flutter's default radio is ~20px
                              child: Radio<String>(
                                value: "Myself",
                                groupValue: _selected,
                                onChanged: (value) {
                                  setState(() => _selected = value);
                                },
                                fillColor:
                                    WidgetStateProperty.resolveWith<Color>((
                                      states,
                                    ) {
                                      if (states.contains(
                                        WidgetState.selected,
                                      )) {
                                        return Color(0xFF323232);
                                      }
                                      return Color(0xFF323232);
                                    }),
                                visualDensity: VisualDensity.compact,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                              ),
                            ),
                            SizedBox(width: 2),
                            Text(
                              "Myself",
                              style: TextStyle(
                                fontFamily: "Rethink Sans",
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1E1E1E),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Transform.scale(
                              scale: .75, // Flutter's default radio is ~20px
                              child: Radio<String>(
                                value: "Someone else",
                                groupValue: _selected,
                                onChanged: (value) {
                                  setState(() => _selected = value);
                                },
                                fillColor:
                                    WidgetStateProperty.resolveWith<Color>((
                                      states,
                                    ) {
                                      if (states.contains(
                                        WidgetState.selected,
                                      )) {
                                        return Color(0xFF323232);
                                      }
                                      return Color(0xFF323232);
                                    }),
                                visualDensity: VisualDensity.compact,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                              ),
                            ),
                            SizedBox(width: 2),
                            Text(
                              "Someone else",
                              style: TextStyle(
                                fontFamily: "Rethink Sans",
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1E1E1E),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 38),

                        // Title
                        Text(
                          "Enter Receiver's Contact Details",
                          style: const TextStyle(
                            fontFamily: "Rethink Sans",
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 13),
                        IntlPhoneField(
                          cursorColor: Color(0xFF1E1E1E),
                          decoration: InputDecoration(
                            labelText: 'Enter Phone Number',
                            labelStyle: TextStyle(color: Color(0xFF1E1E1E)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: Color(0xFFF6DDE1),
                                width: 20,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: Color(0xFFF6DDE1),
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: Color(0xFFF6DDE1),
                                width: 2,
                              ),
                            ),
                            focusColor: Color(0xFFF6DDE1),
                          ),
                          initialCountryCode: 'IN',
                          onChanged: (phone) {
                            print('Phone number: ${phone.completeNumber}');
                          },
                        ),
                        SizedBox(height: 16),
                        Text(
                          "Enter Receiver's Name",
                          style: const TextStyle(
                            fontFamily: "Rethink Sans",
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 13),
                        TextFormField(
                          controller: emailController,
                          cursorColor: Color(0xFF1E1E1E), // Cursor color
                          style: TextStyle(
                            color: Color(0xFF8793A1),
                            fontFamily: "Rethink Sans",
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ), // Text color
                          decoration: InputDecoration(
                            hintText: 'First Name & Last Name',
                            hintStyle: TextStyle(
                              color: Color(0xFF8793A1),
                              fontFamily: "Rethink Sans",
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ), // Label text color
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFF6DDE1),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFF6DDE1),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFF6DDE1),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFF6DDE1),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            emailController.text = value;
                          },
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.only(left: 16, right: 16),
                          child: Text(
                            "Confirmation and payment details will be sent to the above contact number",
                            style: TextStyle(
                              fontFamily: "Rethink Sans",
                              fontSize: 12,
                              color: Color(0xFF8793A1),
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "No of tickets",
                              style: TextStyle(
                                fontFamily: "Rethink Sans",
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1E1E1E),
                              ),
                            ),
                            Container(
                              height: 26,
                              width: 81,
                              decoration: BoxDecoration(
                                color: Color(0xFFF6DDE1),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: _decrement,
                                    child: Icon(
                                      Icons.remove,
                                      color: Color(0xFF8793A1),
                                      size: 15,
                                    ),
                                  ),
                                  Text(
                                    '$_count',
                                    style: TextStyle(
                                      fontFamily: "Rethink Sans",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: _increment,
                                    child: Icon(
                                      Icons.add,
                                      color: Color(0xFF8793A1),
                                      size: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 34),
                        GestureDetector(
                          child: Container(
                            width: (MediaQuery.of(context).size.width) - 30,
                            height: 55,
                            decoration: BoxDecoration(
                              color: Color(0xFF1E1E1E),
                              borderRadius: BorderRadius.circular(
                                20,
                              ), // Rounded corners
                            ),
                            child: Center(
                              child: Text(
                                'Pay ₹${event.price}',
                                style: const TextStyle(
                                  fontFamily: "Rethink Sans",
                                  color: Color(0xFFF6DDE1),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // Bottom Price Bar
      bottomNavigationBar: navBar(),
    );
  }
}
