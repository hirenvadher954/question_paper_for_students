import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:gtu_question_paper/app/sign_in/email_sign_in_change_model.dart';
import 'package:gtu_question_paper/common_widgets/form_submit_button.dart';
import 'package:gtu_question_paper/common_widgets/show_exception_alert_dialog.dart';
import 'package:gtu_question_paper/services/auth.dart';
import 'package:provider/provider.dart';

class EmailSignInFormChangeNotifier extends StatefulWidget {
  EmailSignInFormChangeNotifier({required this.model});

  final EmailSignInChangeModel model;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<EmailSignInChangeModel>(
      create: (_) => EmailSignInChangeModel(auth: auth),
      child: Consumer<EmailSignInChangeModel>(
        builder: (_, model, __) => EmailSignInFormChangeNotifier(model: model),
      ),
    );
  }

  @override
  _EmailSignInFormChangeNotifierState createState() =>
      _EmailSignInFormChangeNotifierState();
}

class _EmailSignInFormChangeNotifierState
    extends State<EmailSignInFormChangeNotifier> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  EmailSignInChangeModel get model => widget.model;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    try {
      await widget.model.submit();
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      showExceptionAlertDialog(
        context,
        title: 'Sign in failed',
        exception: e,
      );
    }
  }

  void _emailEditingComplete() {
    final newFocus = model.emailValidator.isValid(model.email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _toggleFormType() {
    model.toggleFormType();
    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren(size) {
    return [
      Container(
        height: 400,
        child: Stack(children: <Widget>[
          Positioned(
            top: -40,
            height: 400,
            width: size.width,
            child: FadeIn(
              duration: Duration(seconds: 1),
              child: Container(
                  decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/background.png'),
                    fit: BoxFit.fill),
              )),
            ),
          ),
          Positioned(
            height: 400,
            width: size.width + 20,
            child: FadeIn(
              duration: Duration(milliseconds: 1300),
              child: Container(
                  decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/background-2.png'),
                    fit: BoxFit.fill),
              )),
            ),
          )
        ]),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeIn(
              duration: Duration(microseconds: 1500),
              child: Text(
                "Login",
                style: TextStyle(
                    color: Color.fromRGBO(49, 39, 79, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            FadeIn(
              duration: Duration(milliseconds: 1700),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(196, 135, 198, .3),
                        blurRadius: 20,
                        offset: Offset(0, 10),
                      )
                    ]),
                child: Column(
                  children: [
                    _buildEmailTextField(),
                    _buildPasswordTextField(),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.0),
            FadeIn(
              duration: Duration(milliseconds: 2000),
              child: Center(
                child: FormSubmitButton(
                  text: model.primaryButtonText,
                  onPressed: model.canSubmit ? _submit : null,
                ),
              ),
            ),
            SizedBox(height: 8.0),
            FadeIn(
              duration: Duration(milliseconds: 2400),
              child: Center(
                child: TextButton(
                  child: Text(model.secondaryButtonText),
                  onPressed: !model.isLoading ? _toggleFormType : null,
                ),
              ),
            ),
          ],
        ),
      ),
    ];
  }

  Widget _buildPasswordTextField() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: _passwordController,
        focusNode: _passwordFocusNode,
        decoration: InputDecoration(
            labelText: 'Password',
            border: InputBorder.none,
            errorText: model.passwordErrorText,
            enabled: model.isLoading == false,
            hintStyle: TextStyle(color: Colors.grey)),
        obscureText: true,
        textInputAction: TextInputAction.done,
        onChanged: model.updatePassword,
        onEditingComplete: _submit,
      ),
    );
  }

  Widget _buildEmailTextField() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[200]!))),
      child: TextField(
        controller: _emailController,
        focusNode: _emailFocusNode,
        decoration: InputDecoration(
            labelText: 'Email',
            hintText: 'test@test.com',
            errorText: model.emailErrorText,
            enabled: model.isLoading == false,
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey)),
        autocorrect: false,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        onChanged: model.updateEmail,
        onEditingComplete: () => _emailEditingComplete(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: _buildChildren(size),
    );
  }
}
