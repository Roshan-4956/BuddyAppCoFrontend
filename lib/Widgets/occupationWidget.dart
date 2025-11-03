import 'package:flutter/material.dart';

class OccupationSelection extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const OccupationSelection({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  final List<_OccupationOption> options = const [
    _OccupationOption("Undergraduate Student", Icons.school),
    _OccupationOption("Postgraduate Student", Icons.school),
    _OccupationOption("Fresher", Icons.computer),
    _OccupationOption("Entry Level Professional", Icons.engineering),
    _OccupationOption("Mid Level Professional", Icons.work),
    _OccupationOption("Other", Icons.cancel_presentation),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16),
        Text(
          "what best describes your\noccupation?",
          textAlign: TextAlign.center,

          style: TextStyle(
            fontSize: 16,
            fontFamily: "Rethink Sans",
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 14),
        ...List.generate(options.length, (index) {
          final selected = selectedIndex == index;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: () => onChanged(index),
              child: Container(
                height: 40,

                decoration: BoxDecoration(
                  color: Color(0xFFE9F4FF),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: selected ? Color(0xFF53A9FF) : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 10),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black87,
                      radius: 16,
                      child: Icon(options[index].icon, size: 20),
                    ),
                    SizedBox(width: 18),
                    Expanded(
                      child: Text(
                        options[index].title,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontFamily: "Rethink Sans",
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 14),
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: selected ? Color(0xFF53A9FF) : Colors.black26,
                          width: 1,
                        ),
                        color: selected
                            ? Color(0xFF53A9FF).withOpacity(0.26)
                            : Colors.transparent,
                      ),
                      child: selected
                          ? Center(
                              child: Icon(
                                Icons.check,
                                color: Color(0xFF53A9FF),
                                size: 10,
                              ),
                            )
                          : null,
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}

class _OccupationOption {
  final String title;
  final IconData icon;
  const _OccupationOption(this.title, this.icon);
}
