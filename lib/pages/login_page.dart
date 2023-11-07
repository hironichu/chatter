import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:chatter_application/main.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';

@RoutePage()
class LoginPage extends StatefulWidget {
  final void Function(AuthState isLoggedIn)? onLoginResult;
  final bool showBackButton;
  const LoginPage(
      {required super.key, this.onLoginResult, this.showBackButton = true});

  @override
  State<LoginPage> createState() => _LoginPageState();

  // const LoginPage({ required this.context });
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;

  late final TextEditingController _emailController = TextEditingController();
  late final StreamSubscription<AuthState> _authStateSubscription;

  Future<void> _signIn() async {
    if (!context.mounted) return;
    final colorScheme = Theme.of(context).colorScheme;
    try {
      setState(() {
        _isLoading = true;
      });
      debugPrint('Sending link to... ${_emailController.text.trim()}');
      await supabase.auth.signInWithOtp(
        email: _emailController.text.trim(),
        emailRedirectTo:
            kIsWeb ? null : 'app.hironichu.chatter://login-callback/',
      );
      //debug log
      debugPrint('Sent magic link to ${_emailController.text.trim()}');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Check your email for a login link!')),
        );
        _emailController.clear();
      }
    } on AuthException catch (error) {
      SnackBar(
        content: Text(error.message),
        backgroundColor: colorScheme.error,
      );
    } catch (error) {
      SnackBar(
        content: const Text('Unexpected error occurred'),
        backgroundColor: colorScheme.error,
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    _authStateSubscription =
        supabase.auth.onAuthStateChange.listen(super.widget.onLoginResult);
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _authStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        children: [
          const Text('Sign in via the magic link with your email below'),
          const SizedBox(height: 15),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          const SizedBox(height: 18),
          ElevatedButton(
            onPressed: _isLoading ? null : _signIn,
            child: Text(_isLoading ? 'Loading' : 'Send Magic Link'),
          ),
        ],
      ),
    );
  }
}
