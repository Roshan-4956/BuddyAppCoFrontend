import 'package:buddy_app/old/Widgets/appBar.dart';
import 'package:flutter/material.dart';

class LocationSelection extends StatefulWidget {
  final String? initialLocation;
  final Function(String) onLocationSaved;

  const LocationSelection({
    super.key,
    this.initialLocation,
    required this.onLocationSaved,
  });

  @override
  _LocationSelectionState createState() => _LocationSelectionState();
}

class _LocationSelectionState extends State<LocationSelection> {
  final _locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialLocation != null) {
      _locationController.text = widget.initialLocation!;
    }
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarr(Name: "Sakshi", Location: "Gurugram"),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Location",
              style: TextStyle(
                fontFamily: "Rethink Sans",
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E1E1E),
                fontSize: 18,
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _locationController,
              cursorColor: Color(0xFF1E1E1E),
              style: TextStyle(
                color: Color(0xFF8793A1),
                fontFamily: "Rethink Sans",
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
              decoration: InputDecoration(
                hintText: 'Enter the location',
                hintStyle: TextStyle(
                  color: Color(0xFF8793A1),
                  fontFamily: "Rethink Sans",
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
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
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                if (_locationController.text.trim().isNotEmpty) {
                  widget.onLocationSaved(_locationController.text.trim());
                  Navigator.pop(context);
                }
              },
              child: Container(
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                  color: Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    'Save Location',
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
          ],
        ),
      ),
    );
  }
}
