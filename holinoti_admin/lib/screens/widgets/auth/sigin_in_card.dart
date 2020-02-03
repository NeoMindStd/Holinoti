import 'package:flutter/material.dart';
import 'package:holinoti_admin/bloc/auth_bloc.dart';
import 'package:holinoti_admin/constants/strings.dart' as Strings;
import 'package:holinoti_admin/constants/enums.dart' as Enums;
import 'package:holinoti_admin/screens/widgets/global/center_card.dart';

class SignInCard extends StatelessWidget {
  final AuthBloc _authBloc;

  SignInCard(this._authBloc);

  @override
  Widget build(BuildContext context) {
    final TextEditingController accountController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    final TextFormField accountField = TextFormField(
      decoration: InputDecoration(
          labelText: Strings.AuthPage.ACCOUNT,
          hasFloatingPlaceholder: true
      ),
      controller: accountController,
    );
    final TextFormField passwordField = TextFormField(
      decoration: InputDecoration(
          labelText: Strings.AuthPage.PASSWORD,
          hasFloatingPlaceholder: true
      ),
      controller: passwordController,
    );

    return Column(
      children: <Widget>[
        CenterCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  Strings.GlobalPage.SIGN_IN,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              accountField,
              SizedBox(
                height: 20,
              ),
              passwordField,
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MaterialButton(
                    onPressed: () {},
                    child: Text(Strings.AuthPage.FORGOT_YOUR_PASSWORD),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  FlatButton(
                    child: Text(Strings.GlobalPage.SIGN_IN),
                    color: Color(0xFF4B9DFE),
                    textColor: Colors.white,
                    padding: EdgeInsets.only(
                        left: 38, right: 38, top: 15, bottom: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    onPressed: () => _authBloc.signIn(
                      context,
                      account: accountController.text,
                      password: passwordController.text,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Text(
              Strings.AuthPage.DO_YOU_HAVE_NOT_AN_ACCOUNT,
              style: TextStyle(color: Colors.grey),
            ),
            FlatButton(
              onPressed: () { _authBloc.setAuthMode(Enums.AuthMode.signUp); },
              textColor: Colors.black87,
              child: Text(Strings.GlobalPage.SIGN_UP),
            )
          ],
        )
      ],
    );
  }
}