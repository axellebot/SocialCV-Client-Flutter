import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_flutter/src/ui/commons/styles.dart';

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

  TextEditingController signUpEmailController = new TextEditingController();

  TextEditingController signUpFirstNameController = new TextEditingController();
  TextEditingController signUpLastNameController = new TextEditingController();
  TextEditingController signUpPasswordController = new TextEditingController();
  TextEditingController signUpConfirmPasswordController =
      new TextEditingController();

  @override
  void dispose() {
    print('$_tag:$dispose()');

    myFocusNodeFirstName.dispose();
    myFocusNodeLastName.dispose();
    myFocusNodeEmail.dispose();
    myFocusNodePassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('$_tag:$build');
    RegisterBloc _registerBloc = BlocProvider.of<RegisterBloc>(context);

    void _registerPressed() {
      _registerBloc.dispatch(RegisterButtonPressed(
        email: signUpEmailController.text,
        password: signUpPasswordController.text,
        fName: signUpFirstNameController.text,
        lName: signUpLastNameController.text,
      ));
    }

    return BlocListener<RegisterEvent, RegisterState>(
      bloc: _registerBloc,
      listener: (BuildContext context, RegisterState state) {
        if (state is RegisterFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppStyles.errorColor,
              content: Text('${state.error.runtimeType}'),
            ),
          );
        }
      },
      child: BlocBuilder<RegisterEvent, RegisterState>(
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
                  Center(child: Text('Register')),
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
                        hintText: 'someone@email.com',
                        labelText: 'Email',
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
                          onPressed: _toggleSignup,
                        ),
                        labelText: 'Password',
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
                          onPressed: _toggleSignupConfirm,
                        ),
                        labelText: 'Password Confirm',
                      ),
                    ),
                  ),
                  MaterialButton(
                    child: Text('REGISTER'),
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

  void _toggleSignup() {
    setState(() {
      _obscureTextSignUp = !_obscureTextSignUp;
    });
  }

  void _toggleSignupConfirm() {
    setState(() {
      _obscureTextSignUpConfirm = !_obscureTextSignUpConfirm;
    });
  }
}
