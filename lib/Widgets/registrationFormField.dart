import 'package:flutter/material.dart';

import '../constants/city_state_list.dart';

class RegistrationFormFields extends StatelessWidget {
  final TextEditingController fullNameController;
  final TextEditingController dobController;
  final TextEditingController addressController;
  final String selectedState;
  final String selectedCity;
  final void Function(BuildContext context) onSelectDate;
  final void Function(String?) onStateChanged;
  final void Function(String?) onCityChanged;

  const RegistrationFormFields({
    super.key,
    required this.fullNameController,
    required this.dobController,
    required this.addressController,
    required this.selectedState,
    required this.selectedCity,
    required this.onSelectDate,
    required this.onStateChanged,
    required this.onCityChanged,
  });

  InputDecoration _inputDecoration(String hint) => InputDecoration(
    hintText: hint,
    // labelText: hint,
    // labelStyle: TextStyle(color: Color(0xFF8793A1), fontSize: 9, fontFamily: "Rethink Sans", fontWeight: FontWeight.w600),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0x788D8DFF)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0x788D8DFF)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0x788D8DFF), width: 1.5),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    hintStyle: TextStyle(
      color: Color(0xFF8793A1),
      fontSize: 12,
      fontFamily: "Rethink Sans",
      fontWeight: FontWeight.w600,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuItem<String>> stateItems = states
        .map<DropdownMenuItem<String>>(
          (s) => DropdownMenuItem<String>(
            value: s,
            child: Text(
              s,
              style: TextStyle(
                color: Color(0xFF8793A1),
                fontSize: 12,
                fontFamily: "Rethink Sans",
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        )
        .toList();

    final List<DropdownMenuItem<String>> cityItems =
        (selectedState.isNotEmpty && cities[selectedState] != null)
        ? cities[selectedState]!
              .map<DropdownMenuItem<String>>(
                (c) => DropdownMenuItem<String>(
                  value: c,
                  child: Text(
                    c,
                    style: TextStyle(
                      color: Color(0xFF8793A1),
                      fontSize: 12,
                      fontFamily: "Rethink Sans",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
              .toList()
        : <DropdownMenuItem<String>>[];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Enter Full Name',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 9,
            fontFamily: "Rethink Sans",
          ),
        ),
        SizedBox(height: 8),
        SizedBox(
          height: 41,
          child: TextFormField(
            controller: fullNameController,
            decoration: _inputDecoration("First Name & Last Name"),
          ),
        ),
        SizedBox(height: 20),

        Text(
          'Enter DOB',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 9,
            fontFamily: "Rethink Sans",
          ),
        ),
        SizedBox(height: 8),
        SizedBox(
          height: 41,
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: dobController,
                  decoration: _inputDecoration("dd/mm/yyyy"),
                  keyboardType: TextInputType.datetime,
                ),
              ),
              SizedBox(width: 12),
              Container(
                height: 38,
                width: 38,
                decoration: BoxDecoration(
                  color: Color(0xFF8D8DFF),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xFFd8d8fc)),
                ),
                child: Center(
                  child: IconButton(
                    icon: Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: () => onSelectDate(context),
                    tooltip: "Pick Date",
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),

        Text(
          'Select State',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 9,
            fontFamily: "Rethink Sans",
          ),
        ),
        SizedBox(height: 8),
        SizedBox(
          height: 41,
          child: DropdownButtonFormField<String>(
            initialValue: selectedState.isNotEmpty ? selectedState : null,
            items: stateItems,
            onChanged: onStateChanged,
            decoration: _inputDecoration("Select from the dropdown"),
            hint: Text(
              "Select from the dropdown",
              style: TextStyle(
                color: Color(0xFF8793A1),
                fontSize: 12,
                fontFamily: "Rethink Sans",
                fontWeight: FontWeight.w600,
              ), // <-- custom style here!
            ),

            // menuMaxHeight: 50,
          ),
        ),
        SizedBox(height: 20),

        Text(
          'Select City',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 9,
            fontFamily: "Rethink Sans",
          ),
        ),
        SizedBox(height: 8),
        SizedBox(
          height: 41,

          child: DropdownButtonFormField<String>(
            initialValue:
                selectedCity.isNotEmpty &&
                    cityItems.any((item) => item.value == selectedCity)
                ? selectedCity
                : null,
            items: selectedState.isEmpty
                ? [
                    DropdownMenuItem<String>(
                      value: "",
                      child: Text(
                        "Select a state first",
                        style: TextStyle(
                          color: Color(0xFF8793A1),
                          fontSize: 12,
                          fontFamily: "Rethink Sans",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ]
                : cityItems,
            onChanged: selectedState.isEmpty ? null : onCityChanged,
            decoration: _inputDecoration("Select from the dropdown"),
            disabledHint: Text(
              "Select a state first",
              style: TextStyle(
                color: Color(0xFF8793A1),
                fontSize: 12,
                fontFamily: "Rethink Sans",
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SizedBox(height: 20),

        Text(
          'Enter Address',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 9,
            fontFamily: "Rethink Sans",
          ),
        ),
        SizedBox(height: 8),
        SizedBox(
          height: 41,
          child: TextFormField(
            controller: addressController,
            decoration: _inputDecoration("Enter full address here"),
            minLines: 1,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
