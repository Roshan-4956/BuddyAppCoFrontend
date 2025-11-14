import 'package:buddy_app/old/Widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class AddEventPage extends ConsumerStatefulWidget {
  const AddEventPage({super.key});

  @override
  ConsumerState<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends ConsumerState<AddEventPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  final _descController = TextEditingController();
  final _locationController = TextEditingController();
  final _attendeesController = TextEditingController();
  final _priceController = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _selectedCategory;

  List<String> uploadedImages = [];

  final categories = ["Music", "Tech", "Sports", "Art", "Others"];
  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _locationController.dispose();
    _attendeesController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarr(Name: "Sakshi", Location: "Faridabad"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            // Upload photos
            GestureDetector(
              onTap: () {
                // TODO: image picker
                if (uploadedImages.length < 3) {
                  setState(() {
                    uploadedImages.add("dummy_image.png");
                  });
                }
              },
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/community/upload.png", scale: 4),
                      SizedBox(height: 8),
                      Text(
                        "upload up to 3 photos",
                        style: TextStyle(
                          fontFamily: "Rethink Sans",
                          fontSize: 12,
                          color: Color(0xFF8793A1),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            uploadedImages.isEmpty
                ? SizedBox(height: 0)
                : Row(
                    children: uploadedImages
                        .map(
                          (img) => Stack(
                            children: [
                              Container(
                                margin: const EdgeInsets.all(8),
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey.shade300,
                                ),
                                child: Image.asset(
                                  "assets/community/redeye.png",
                                  scale: 1,
                                ),
                              ),
                              Positioned(
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      uploadedImages.remove(img);
                                    });
                                  },
                                  child: Image.asset(
                                    "assets/community/cross.png",
                                    scale: 4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Event Title",
                style: TextStyle(
                  fontFamily: "Rethink Sans",
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1e1e1e),
                  fontSize: 12,
                ),
              ),
            ),
            SizedBox(height: 11),
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
                    borderSide: BorderSide(color: Color(0xFFF6DDE1), width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFF6DDE1), width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFF6DDE1), width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFF6DDE1), width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  _titleController.text = value;
                },
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Event Description",
                style: TextStyle(
                  fontFamily: "Rethink Sans",
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1e1e1e),
                  fontSize: 12,
                ),
              ),
            ),
            SizedBox(height: 11),
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
                    borderSide: BorderSide(color: Color(0xFFF6DDE1), width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFF6DDE1), width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFF6DDE1), width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFF6DDE1), width: 2),
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
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Event Date",
                          style: TextStyle(
                            fontFamily: "Rethink Sans",
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1e1e1e),
                            fontSize: 12,
                          ),
                        ),
                      ),
                      SizedBox(height: 11),
                      Padding(
                        padding: EdgeInsets.only(left: 16, right: 4),
                        child: TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
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
                            // labelText: "Event Date",
                            hintStyle: TextStyle(
                              color: Color(0xFF8793A1),
                              fontSize: 12,
                              fontFamily: "Rethink Sans",
                              fontWeight: FontWeight.w600,
                            ),
                            hintText: "dd/mm/yyyy",
                            suffixIcon: GestureDetector(
                              child: Image.asset(
                                "assets/community/pinkCal.png",
                                scale: 4,
                              ),
                              onTap: () async {
                                DateTime? picked = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2100),
                                  initialDate: DateTime.now(),
                                  builder: (context, child) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme: ColorScheme.light(
                                          primary: Color(
                                            0xFFF6DDE1,
                                          ), // header background color
                                          onPrimary:
                                              Colors.white, // header text color
                                          onSurface:
                                              Colors.black, // body text color
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
                                            foregroundColor: Colors
                                                .black, // button text color
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
                              },
                            ),
                          ),
                          controller: TextEditingController(
                            text: _selectedDate == null
                                ? ""
                                : DateFormat(
                                    "dd/MM/yyyy",
                                  ).format(_selectedDate!),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Event Time",
                          style: TextStyle(
                            fontFamily: "Rethink Sans",
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1e1e1e),
                            fontSize: 12,
                          ),
                        ),
                      ),
                      SizedBox(height: 11),
                      Padding(
                        padding: EdgeInsets.only(right: 16, left: 4),
                        child: TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
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
                            // labelText: "Event Date",
                            hintStyle: TextStyle(
                              color: Color(0xFF8793A1),
                              fontSize: 12,
                              fontFamily: "Rethink Sans",
                              fontWeight: FontWeight.w600,
                            ),
                            // labelText: "Event Time",
                            hintText: "hh:mm:ss",
                            suffixIcon: GestureDetector(
                              child: Image.asset(
                                "assets/community/pinkTime.png",
                                scale: 4,
                              ),
                              onTap: () async {
                                TimeOfDay? picked = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                  builder: (context, child) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme: ColorScheme.light(
                                          primary: Color(
                                            0xFFF6DDE1,
                                          ), // header background color
                                          onPrimary:
                                              Colors.white, // header text color
                                          onSurface:
                                              Colors.black, // body text color
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
                                            foregroundColor: Colors
                                                .black, // button text color
                                            textStyle: const TextStyle(
                                              fontFamily: "Rethink Sans",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        timePickerTheme:
                                            const TimePickerThemeData(
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
                                              hourMinuteTextColor: Color(
                                                0xff1e1e1e,
                                              ),
                                              dayPeriodTextColor:
                                                  Colors.black, // AM/PM text

                                              dayPeriodShape:
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                          Radius.circular(8),
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
                                    _selectedTime = picked;
                                  });
                                }
                              },
                            ),
                          ),
                          controller: TextEditingController(
                            text: _selectedTime == null
                                ? ""
                                : _selectedTime!.format(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Event Category",
                style: TextStyle(
                  fontFamily: "Rethink Sans",
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1e1e1e),
                  fontSize: 12,
                ),
              ),
            ),
            SizedBox(height: 11),
            // Category
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
                    borderSide: BorderSide(color: Color(0xFFF6DDE1), width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFF6DDE1), width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFF6DDE1), width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFF6DDE1), width: 2),
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
                onChanged: (val) => setState(() => _selectedCategory = val),
                dropdownColor: Colors.white, // popup background

                style: const TextStyle(
                  fontFamily: "YourFontFamily",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Event Location",
                style: TextStyle(
                  fontFamily: "Rethink Sans",
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1e1e1e),
                  fontSize: 12,
                ),
              ),
            ),
            SizedBox(height: 11),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                controller: _locationController,
                cursorColor: Color(0xFF1E1E1E), // Cursor color
                style: TextStyle(
                  color: Color(0xFF8793A1),
                  fontFamily: "Rethink Sans",
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ), // Text color
                decoration: InputDecoration(
                  hintText: 'Enter the location',
                  hintStyle: TextStyle(
                    color: Color(0xFF8793A1),
                    fontFamily: "Rethink Sans",
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ), // Label text color
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFF6DDE1), width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFF6DDE1), width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFF6DDE1), width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFF6DDE1), width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),

                keyboardType: TextInputType.text,
                onChanged: (value) {
                  _locationController.text = value;
                },
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "No of Attendees",
                          style: TextStyle(
                            fontFamily: "Rethink Sans",
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1e1e1e),
                            fontSize: 12,
                          ),
                        ),
                      ),
                      SizedBox(height: 11),
                      Padding(
                        padding: EdgeInsets.only(left: 16, right: 4),
                        child: TextFormField(
                          controller: _attendeesController,
                          cursorColor: Color(0xFF1E1E1E), // Cursor color
                          style: TextStyle(
                            color: Color(0xFF8793A1),
                            fontFamily: "Rethink Sans",
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ), // Text color
                          decoration: InputDecoration(
                            hintText: 'Eg: 80',
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
                            _attendeesController.text = value;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Price in ",
                          style: TextStyle(
                            fontFamily: "Rethink Sans",
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1e1e1e),
                            fontSize: 12,
                          ),
                        ),
                      ),
                      SizedBox(height: 11),
                      Padding(
                        padding: EdgeInsets.only(left: 4, right: 16),
                        child: TextFormField(
                          controller: _priceController,
                          cursorColor: Color(0xFF1E1E1E), // Cursor color
                          style: TextStyle(
                            color: Color(0xFF8793A1),
                            fontFamily: "Rethink Sans",
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ), // Text color
                          decoration: InputDecoration(
                            hintText: 'Eg. 500',
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
                            _priceController.text = value;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Event Guidelines
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xffF3F4F5),
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    8,
                    (i) => const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        "• Linkin Park makes their long-awaited debut in India",
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: "Rethink Sans",
                          color: Color(0xFF8793A1),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              child: Center(
                child: Container(
                  width: (MediaQuery.of(context).size.width) - 30,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Color(0xFF1E1E1E),
                    borderRadius: BorderRadius.circular(20), // Rounded corners
                  ),
                  child: Center(
                    child: const Text(
                      'Create Event',
                      style: TextStyle(
                        fontFamily: "Rethink Sans",
                        color: Color(0xFFF6DDE1),
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Create Button
            const SizedBox(height: 8),
            Center(
              child: Row(
                children: [
                  Expanded(child: Container()),
                  Image.asset("assets/community/alert.png", scale: 4),
                  SizedBox(width: 6),
                  Text(
                    "You will receive the details on WhatsApp ",
                    style: TextStyle(
                      fontFamily: "Rethink Sans",
                      color: Color(0xff8793A1),
                      fontSize: 12,
                    ),
                  ),
                  Expanded(child: Container()),
                ],
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
