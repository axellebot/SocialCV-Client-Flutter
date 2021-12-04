import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/presentation.dart';
import 'package:social_cv_client_flutter/src/presentation/commons/styles.dart';

class RegisterForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final String _tag = '$_RegisterFormState';

  final FocusNode myFocusNodePassword = FocusNode();
  final FocusNode myFocusNodeEmail = FocusNode();

  final FocusNode myFocusNodeFirstName = FocusNode();
  final FocusNode myFocusNodeLastName = FocusNode();

  bool _obscureTextSignUp = true;
  bool _obscureTextSignUpConfirm = true;

  TextEditingController signUpEmailController = TextEditingController();

  TextEditingController signUpFirstNameController = TextEditingController();
  TextEditingController signUpLastNameController = TextEditingController();
  TextEditingController signUpPasswordController = TextEditingController();
  TextEditingController signUpConfirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    print('$_tag:dispose()');

    myFocusNodeFirstName.dispose();
    myFocusNodeLastName.dispose();
    myFocusNodeEmail.dispose();
    myFocusNodePassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('$_tag:build');
    final RegisterBloc _registerBloc = BlocProvider.of<RegisterBloc>(context);

    void _registerPressed() {
      _registerBloc.add(RegistrationEvent(
        email: signUpEmailController.text,
        password: signUpPasswordController.text,
        fName: signUpFirstNameController.text,
        lName: signUpLastNameController.text,
      ));
    }

    return BlocListener<RegisterBloc, RegisterState>(
      bloc: _registerBloc,
      listener: (BuildContext context, RegisterState state) {
        if (state is RegisterFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppStyles.errorColor,
              content: ErrorRow(error: state.error),
            ),
          );
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        bloc: _registerBloc,
        builder: (BuildContext context, RegisterState state) {
          return Card(
            elevation: AppStyles.defaultCardElevation,
            child: Padding(
              padding: AppStyles.defaultCardPadding,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(CVLocalizations.of(context)!.authRegisterTitle),
                  ),
                  Padding(
                    padding: AppStyles.defaultFormInputPadding,
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Firstname',
                      ),
                    ),
                  ),
                  Padding(
                    padding: AppStyles.defaultFormInputPadding,
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Lastname',
                      ),
                    ),
                  ),
                  Padding(
                    padding: AppStyles.defaultFormInputPadding,
                    child: TextFormField(
                      controller: signUpEmailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: CVLocalizations.of(context)!.formEmailHint,
                        labelText: CVLocalizations.of(context)!.formEmailLabel,
                      ),
                    ),
                  ),
                  Padding(
                    padding: AppStyles.defaultFormInputPadding,
                    child: TextFormField(
                      controller: signUpPasswordController,
                      obscureText: _obscureTextSignUp,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(_obscureTextSignUp
                              ? MdiIcons.eyeOffOutline
                              : MdiIcons.eyeOutline),
                          onPressed: _togglePasswordVisibility,
                        ),
                        labelText:
                            CVLocalizations.of(context)!.formPasswordLabel,
                      ),
                    ),
                  ),
                  Padding(
                    padding: AppStyles.defaultFormInputPadding,
                    child: TextFormField(
                      controller: signUpConfirmPasswordController,
                      obscureText: _obscureTextSignUpConfirm,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(_obscureTextSignUpConfirm
                              ? MdiIcons.eyeOffOutline
                              : MdiIcons.eyeOutline),
                          onPressed: _togglePasswordConfirmationVisibility,
                        ),
                        labelText:
                            CVLocalizations.of(context)!.formPassword2Label,
                      ),
                    ),
                  ),
                  MaterialButton(
                    child: Text(CVLocalizations.of(context)!.authRegisterCTA),
                    onPressed:
                        state is! RegisterLoading ? _registerPressed : null,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureTextSignUp = !_obscureTextSignUp;
    });
  }

  void _togglePasswordConfirmationVisibility() {
    setState(() {
      _obscureTextSignUpConfirm = !_obscureTextSignUpConfirm;
    });
  }
}
