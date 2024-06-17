import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

class LangOption extends StatefulWidget {
  @override
  LangState createState() => LangState();
}

class LangState extends State<LangOption> {
  String? _selectedLang;

  @override
  void initState() {
    super.initState();
    _loadLanguagePreference();
  }

  Future<void> _loadLanguagePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedLang = prefs.getString('lang') ?? 'En';
    });
  }

  Future<void> _saveLanguagePreference(String lang) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('lang', lang);
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        hint: Text(
          "En",
          style: GoogleFonts.notoSansEthiopic(),
        ),
        value: _selectedLang,
        onChanged: (String? newValue) {
          setState(() {
            _selectedLang = newValue;
            _saveLanguagePreference(newValue!);
          });
        },
        items:
            <String>['En', 'አማ'].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: GoogleFonts.notoSansEthiopic(),
            ),
          );
        }).toList(),
      ),
    );
  }
}
