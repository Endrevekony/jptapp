import 'package:flutter/material.dart';
import 'package:jptapp/features/settings/change_language/app_localization.dart';
import 'package:jptapp/features/settings/pages/settings_page.dart';

class LanguageDropDown extends StatefulWidget{
  @override
  _LanguageDropDownState createState() {
    return _LanguageDropDownState();
  }
}

class _LanguageDropDownState extends State<LanguageDropDown> {
  String _value = allTranslations.currentLanguage;
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      items: [
        DropdownMenuItem<String>(
          child: Text('English'),
          value: 'en',
        ),
        DropdownMenuItem<String>(
          child: Text('Magyar'),
          value: 'hu',
        ),
        DropdownMenuItem<String>(
          child: Text('Srpski'),
          value: 'rs',
        ),
      ],
      onChanged: (String value) {
        setState(() async{

          _value = value;
          await allTranslations.setNewLanguage(_value);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
              Settings()),);
        },);
      },
      hint: Text(_value),
      value: _value,
    );
  }
}
