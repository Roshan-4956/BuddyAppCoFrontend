import 'package:buddy_app/Widgets/appBar.dart';
import 'package:buddy_app/view/locationSelection.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';

class CreateNudge extends StatefulWidget {
  const CreateNudge({super.key});

  @override
  _CreateNudgeState createState() => _CreateNudgeState();
}

class _CreateNudgeState extends State<CreateNudge> {
  final FocusNode _focusNode = FocusNode();

  final categories = ["Music", "Tech", "Sports", "Art", "Others"];
  final peopleOptions = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "10+",
  ];
  final _descController = TextEditingController();
  final _descController2 = TextEditingController();
  String? _selectedCategory;

  // New state variables for location, date, and time
  String? _selectedLocation;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _selectedPeopleRequired;
  @override
  void initState() {
    super.initState();
    // Always show keyboard on screen open
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  final _titleController = TextEditingController();

  // Method to handle location selection
  void _selectLocation() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationSelection(
          initialLocation: _selectedLocation,
          onLocationSaved: (location) {
            setState(() {
              _selectedLocation = location;
            });
          },
        ),
      ),
    );
  }

  // Method to handle date selection
  void _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      initialDate: _selectedDate ?? DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xFFF6DDE1), // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            textTheme: const TextTheme(
              bodyLarge: TextStyle(
                // normal text
                fontFamily: "Rethink Sans",
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              titleLarge: TextStyle(
                // header title (month/year)
                fontFamily: "Rethink Sans",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              labelSmall: TextStyle(
                // button text
                fontFamily: "Rethink Sans",
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black, // button text color
                textStyle: const TextStyle(
                  fontFamily: "Rethink Sans",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Method to handle time selection
  void _selectTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xFFF6DDE1), // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            textTheme: const TextTheme(
              bodyLarge: TextStyle(
                // normal text
                fontFamily: "Rethink Sans",
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              titleLarge: TextStyle(
                // header title (month/year)
                fontFamily: "Rethink Sans",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              labelSmall: TextStyle(
                // button text
                fontFamily: "Rethink Sans",
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black, // button text color
                textStyle: const TextStyle(
                  fontFamily: "Rethink Sans",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            timePickerTheme: const TimePickerThemeData(
              dayPeriodTextStyle: TextStyle(
                // header title (month/year)
                fontFamily: "Rethink Sans",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              dayPeriodColor: Color(0xFFF6DDE1),
              dialBackgroundColor: Colors.white,
              dialHandColor: Color(0xFFF6DDE1),
              dialTextColor: Colors.black,
              hourMinuteTextColor: Color(0xff1e1e1e),
              dayPeriodTextColor: Colors.black, // AM/PM text
              dayPeriodShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  // Method to check if all required fields are completed
  bool _isFormComplete() {
    return _titleController.text.trim().isNotEmpty &&
        _descController.text.trim().isNotEmpty &&
        _descController2.text.trim().isNotEmpty &&
        _selectedCategory != null &&
        _selectedPeopleRequired != null &&
        _selectedLocation != null &&
        _selectedDate != null &&
        _selectedTime != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarr(Name: "Sakshi", Location: "Gurugram"),
      // resizeToAvoidBottomInset: false, // don’t resize on keyboard
      body: FooterLayout(
        footer: SafeArea(
          child: Container(
            color: Colors.pink.shade50,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                GestureDetector(
                  onTap: _selectLocation,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset(
                      "assets/nudges/blackLoc.png",
                      scale: 4,
                      color: _selectedLocation != null
                          ? Color(0xFF1e1e1e)
                          : Color(0xFF8793A1),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: _selectDate,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset(
                      "assets/nudges/blackCal.png",
                      scale: 4,
                      color: _selectedLocation != null
                          ? Color(0xFF1e1e1e)
                          : Color(0xFF8793A1),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: _selectTime,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset(
                      "assets/nudges/blackTime.png",
                      scale: 4,
                      color: _selectedLocation != null
                          ? Color(0xFF1e1e1e)
                          : Color(0xFF8793A1),
                    ),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: _isFormComplete()
                      ? () {
                          // Handle post nudge action
                          print("Posting nudge with:");
                          print("Title: ${_titleController.text}");
                          print("Description: ${_descController.text}");
                          print("Additional: ${_descController2.text}");
                          print("Category: $_selectedCategory");
                          print("People Required: $_selectedPeopleRequired");
                          print("Location: $_selectedLocation");
                          print("Date: $_selectedDate");
                          print("Time: $_selectedTime");
                        }
                      : null,
                  child: Container(
                    width: 120,
                    height: 40,
                    decoration: BoxDecoration(
                      color: _isFormComplete()
                          ? Color(0xFF1E1E1E)
                          : Color(0xFFE0E0E0),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        "Post Nudge",
                        style: TextStyle(
                          fontFamily: "Rethink Sans",
                          color: _isFormComplete()
                              ? Color(0xFFF6DDE1)
                              : Color(0xFF9E9E9E),
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 60,
                child: Image.asset(
                  "assets/homepage/profilePic.png",
                  scale: 4,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                        controller: _titleController,
                        cursorColor: Color(0xFF1E1E1E), // Cursor color
                        style: TextStyle(
                          color: Color(0xFF8793A1),
                          fontFamily: "Rethink Sans",
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ), // Text color
                        decoration: InputDecoration(
                          hintText: 'Add event title here',
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
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFF6DDE1),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFF6DDE1),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFF6DDE1),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          _titleController.text = value;
                        },
                      ),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                        controller: _descController,
                        cursorColor: Color(0xFF1E1E1E), // Cursor color
                        style: TextStyle(
                          color: Color(0xFF8793A1),
                          fontFamily: "Rethink Sans",
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ), // Text color
                        decoration: InputDecoration(
                          hintText:
                              'Describe your event, what to expect, what to bring, any other special instructions etc.',
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
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFF6DDE1),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFF6DDE1),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFF6DDE1),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        minLines: 1,
                        maxLines: 2,

                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          _descController.text = value;
                        },
                      ),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                        controller: _descController2,
                        cursorColor: Color(0xFF1E1E1E), // Cursor color
                        style: TextStyle(
                          color: Color(0xFF8793A1),
                          fontFamily: "Rethink Sans",
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ), // Text color
                        decoration: InputDecoration(
                          hintText: 'Add event title here',
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
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFF6DDE1),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFF6DDE1),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFF6DDE1),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          _titleController.text = value;
                        },
                      ),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: DropdownButtonFormField<String>(
                        initialValue: _selectedCategory,
                        decoration: InputDecoration(
                          // labelText: "Event Category",
                          // labelStyle: const TextStyle(
                          //   fontFamily: "YourFontFamily",
                          //   fontSize: 14,
                          //   fontWeight: FontWeight.w400,
                          //   color: Colors.grey,
                          // ),
                          hintText: 'Select from the dropdown',
                          labelStyle: TextStyle(
                            color: Color(0xFF8793A1),
                            fontFamily: "Rethink Sans",
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
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
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFF6DDE1),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFF6DDE1),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFF6DDE1),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        items: categories
                            .map(
                              (c) => DropdownMenuItem(
                                value: c,
                                child: Text(
                                  c,
                                  style: TextStyle(
                                    fontFamily: "Rethink Sans",
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff8793A1),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (val) =>
                            setState(() => _selectedCategory = val),
                        dropdownColor: Colors.white, // popup background

                        style: const TextStyle(
                          fontFamily: "YourFontFamily",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: SizedBox(
                        width: 170,
                        child: DropdownButtonFormField<String>(
                          initialValue: _selectedPeopleRequired,
                          decoration: InputDecoration(
                            hintText: 'People required',
                            labelStyle: TextStyle(
                              color: Color(0xFF8793A1),
                              fontFamily: "Rethink Sans",
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                            hintStyle: TextStyle(
                              color: Color(0xFF8793A1),
                              fontFamily: "Rethink Sans",
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFF6DDE1),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFF6DDE1),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFF6DDE1),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFF6DDE1),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          items: peopleOptions
                              .map(
                                (p) => DropdownMenuItem(
                                  value: p,
                                  child: Text(
                                    p,
                                    style: TextStyle(
                                      fontFamily: "Rethink Sans",
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff8793A1),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (val) =>
                              setState(() => _selectedPeopleRequired = val),
                          dropdownColor: Colors.white,
                          style: const TextStyle(
                            fontFamily: "YourFontFamily",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
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
    );
  }
}
