import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class js extends StatelessWidget {
  const js({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String _phoneNumber = '';
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(13),
            ],
            decoration: InputDecoration(
              labelText: 'Phone Number',
              hintText: 'Enter a Tanzanian phone number',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a phone number';
              }
              final tanzanianRegex = RegExp(r'^\+255\d{9}$');
              if (!tanzanianRegex.hasMatch(value)) {
                return 'Please enter a valid Tanzanian phone number';
              }
              return null;
            },
            onSaved: (value) {
              _phoneNumber = value!;
            },
          ),
        ],
      ),
    );
  }
}
