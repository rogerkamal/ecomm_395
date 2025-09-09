import 'dart:math' as math;
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../utils/app_routes.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final _formKey = GlobalKey<FormState>();

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();

  bool _obscure = true;
  bool _agree = false;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 18),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    if (!_agree) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please accept the Terms & Privacy Policy'),
        ),
      );
      return;
    }

    String email = _email.text;
    String name = _name.text;
    String pass = _password.text;

   /* FirebaseAuth mAuth = FirebaseAuth.instance;
    try {
      UserCredential userCred = await mAuth.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      if (userCred.user != null) {
        ///navigate to home
        ///navigate back to login

        ///create new user in firestore users collection
        FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
        await firebaseFirestore.collection("users").doc(userCred.user!.uid).set({
          "name" : name,
          "email" : email,
          "pass" : pass,
          "createdAt" : DateTime.now().millisecondsSinceEpoch
        });

        print("User created in firestore");

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Account created successfully!!')),
        );

        Navigator.pushReplacementNamed(context, AppRoutes.signin);

      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('The password provided is too weak.')),
        );
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('The account already exists for that email.')),
        );
      }
      _loading =true;
    } catch (e) {
      print(e);
    }*/

    setState(() => _loading = false);

   /* setState(() => _loading = false);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Row(
            children: const [
              Icon(Icons.verified_rounded),
              SizedBox(width: 8),
              Text('Account created successfully!'),
            ],
          ),
        ),
      );*//*
    }*/
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              /*color: Colors.blueGrey*/
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  "https://images.unsplash.com/photo-1504672281656-e4981d70414b?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Animated gradient blobs
          AnimatedBuilder(
            animation: _controller,
            builder: (_, __) => CustomPaint(
              size: size,
              painter: _NeonBlobPainter(_controller.value),
            ),
          ),

          // Grid shimmer overlay for "futuristic" feel
          _FaintGridOverlay(),

          // Foreground content
          Center(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final maxW = math.min(constraints.maxWidth, 980.0);
                final cardW = math.min(520.0, maxW - 32);
                return ConstrainedBox(
                  constraints: BoxConstraints.tightFor(width: cardW),
                  child: _GlassCard(
                    child: Form(
                      key: _formKey,
                      child: AutofillGroup(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Logo / Title Row
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ShaderMask(
                                      shaderCallback: (rect) =>
                                          const LinearGradient(
                                            colors: [
                                              Color(0xFF5B8CFF),
                                              Color(0xFF9B5BFF),
                                              Color(0xFF00E5A8),
                                            ],
                                          ).createShader(rect),
                                      child: const Icon(
                                        Icons.bolt_rounded,
                                        size: 34,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      'Create your account',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.w800,
                                            letterSpacing: 0.2,
                                          ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 18),
                                const _SubtitleTag(
                                  text: 'Ultra-modern • Secure • Lightning fast',
                                ),
                                const SizedBox(height: 22),
                            
                                // Name
                                _FTextField(
                                  controller: _name,
                                  label: 'Full Name',
                                  icon: Icons.person_outline_rounded,
                                  autofillHints: const [AutofillHints.name],
                                  validator: (v) =>
                                      (v == null || v.trim().length < 3)
                                      ? 'Please enter your full name'
                                      : null,
                                ),
                                const SizedBox(height: 14),
                            
                                // Email
                                _FTextField(
                                  controller: _email,
                                  label: 'Email',
                                  icon: Icons.alternate_email_rounded,
                                  keyboardType: TextInputType.emailAddress,
                                  autofillHints: const [AutofillHints.email],
                                  validator: (v) {
                                    final emailRx = RegExp(
                                      r'^[\w\.\-]+@([\w\-]+\.)+[a-zA-Z]{2,}$',
                                    );
                                    return (v == null || !emailRx.hasMatch(v))
                                        ? 'Enter a valid email'
                                        : null;
                                  },
                                ),
                                const SizedBox(height: 14),
                            
                                // Password
                                _FTextField(
                                  controller: _password,
                                  label: 'Password',
                                  icon: Icons.lock_outline_rounded,
                                  obscure: _obscure,
                                  onToggleObscure: () =>
                                      setState(() => _obscure = !_obscure),
                                  autofillHints: const [
                                    AutofillHints.newPassword,
                                  ],
                                  validator: (v) {
                                    if (v == null || v.length < 8) {
                                      return 'Min 8 characters';
                                    }
                                    final hasNum = v.contains(RegExp(r'\d'));
                                    final hasUpper = v.contains(RegExp(r'[A-Z]'));
                                    final hasLower = v.contains(RegExp(r'[a-z]'));
                                    final hasSym = v.contains(
                                      RegExp(r'[!@#\$%^&*(),.?":{}|<>_\-\+=]'),
                                    );
                                    if (!(hasNum &&
                                        hasUpper &&
                                        hasLower &&
                                        hasSym)) {
                                      return 'Use upper, lower, number & symbol';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 8),
                                _PasswordStrengthBar(text: _password.text),
                                const SizedBox(height: 14),
                            
                                // Confirm
                                _FTextField(
                                  controller: _confirm,
                                  label: 'Confirm Password',
                                  icon: Icons.verified_user_outlined,
                                  obscure: true,
                                  autofillHints: const [
                                    AutofillHints.newPassword,
                                  ],
                                  validator: (v) => (v != _password.text)
                                      ? 'Passwords do not match'
                                      : null,
                                ),
                                const SizedBox(height: 12),
                            
                                // Terms + remember
                                Row(
                                  children: [
                                    Checkbox(
                                      value: _agree,
                                      onChanged: (v) =>
                                          setState(() => _agree = v ?? false),
                                    ),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: Wrap(
                                        spacing: 6,
                                        runSpacing: 4,
                                        children: [
                                          const Text('I agree to the'),
                                          _Link('Terms', onTap: () {}),
                                          const Text('&'),
                                          _Link('Privacy Policy', onTap: () {}),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                            
                                // Sign up button
                                SizedBox(
                                  width: double.infinity,
                                  height: 52,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      shape: WidgetStatePropertyAll(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                      ),
                                      overlayColor: const WidgetStatePropertyAll(
                                        Colors.white12,
                                      ),
                                      elevation: const WidgetStatePropertyAll(0),
                                      backgroundColor: WidgetStatePropertyAll(
                                        Colors.white.withOpacity(0.06),
                                      ),
                                    ),
                                    onPressed: _loading ? null : _submit,
                                    child: AnimatedSwitcher(
                                      duration: const Duration(milliseconds: 300),
                                      child: _loading
                                          ? const SizedBox(
                                              key: ValueKey('loading'),
                                              width: 22,
                                              height: 22,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2.4,
                                              ),
                                            )
                                          : ShaderMask(
                                              key: const ValueKey('text'),
                                              shaderCallback: (r) =>
                                                  const LinearGradient(
                                                    colors: [
                                                      Color(0xFF5B8CFF),
                                                      Color(0xFF9B5BFF),
                                                      Color(0xFF00E5A8),
                                                    ],
                                                  ).createShader(r),
                                              child: const Text(
                                                'Create Account',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16,
                                                  letterSpacing: 0.2,
                                                ),
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 14),
                            
                                // Divider
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 1,
                                        color: Colors.white12,
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                      ),
                                      child: Text(
                                        'or continue with',
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 1,
                                        color: Colors.white12,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 14),
                            
                                // Social auth buttons (dummy)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    _SocialBtn(
                                      icon: Icons.g_mobiledata_rounded,
                                      label: 'Google',
                                    ),
                                    SizedBox(width: 5),
                                    _SocialBtn(
                                      icon: Icons.apple_rounded,
                                      label: 'Apple',
                                    ),
                                    SizedBox(width: 5),
                                    _SocialBtn(
                                      icon: Icons.facebook_rounded,
                                      label: 'Fb',
                                    ),
                                  ],
                                ),
                            
                                const SizedBox(height: 18),
                                // Already have account
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Already have an account?',
                                      style: TextStyle(color: Colors.white70),
                                    ),
                                    const SizedBox(width: 6),
                                    _Link('Sign in', onTap: () {
                                      Navigator.pushReplacementNamed(context, AppRoutes.signin);
                                    }),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Glassmorphism card with blur & subtle border
class _GlassCard extends StatelessWidget {
  final Widget child;

  const _GlassCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.06),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.18)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.35),
                blurRadius: 24,
                spreadRadius: 2,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}

/// Futuristic subtitle chip
class _SubtitleTag extends StatelessWidget {
  final String text;

  const _SubtitleTag({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withOpacity(0.18)),
        color: Colors.white.withOpacity(0.04),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white70, letterSpacing: 0.2),
      ),
    );
  }
}

/// Custom form field with icon + optional show/hide
class _FTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool obscure;
  final VoidCallback? onToggleObscure;
  final String? Function(String?)? validator;
  final Iterable<String>? autofillHints;
  final TextInputType? keyboardType;

  const _FTextField({
    required this.controller,
    required this.label,
    required this.icon,
    this.obscure = false,
    this.onToggleObscure,
    this.validator,
    this.autofillHints,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    final baseBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.white.withOpacity(0.18)),
    );
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: validator,
      autofillHints: autofillHints,
      keyboardType: keyboardType,
      style: const TextStyle(fontSize: 15.5),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        suffixIcon: onToggleObscure == null
            ? null
            : IconButton(
                onPressed: onToggleObscure,
                icon: Icon(
                  obscure
                      ? Icons.visibility_off_rounded
                      : Icons.visibility_rounded,
                ),
              ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.05),
        enabledBorder: baseBorder,
        focusedBorder: baseBorder.copyWith(
          borderSide: const BorderSide(color: Color(0xFF5B8CFF), width: 1.4),
        ),
        errorBorder: baseBorder.copyWith(
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: baseBorder.copyWith(
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.4),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 16,
        ),
      ),
    );
  }
}

/// Password strength meter
class _PasswordStrengthBar extends StatefulWidget {
  final String text;

  const _PasswordStrengthBar({required this.text});

  @override
  State<_PasswordStrengthBar> createState() => _PasswordStrengthBarState();
}

class _PasswordStrengthBarState extends State<_PasswordStrengthBar> {
  @override
  void didUpdateWidget(covariant _PasswordStrengthBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Trigger rebuild on text change
    if (oldWidget.text != widget.text) setState(() {});
  }

  double _score(String s) {
    if (s.isEmpty) return 0;
    double score = 0;
    if (s.length >= 8) score += 0.25;
    if (s.length >= 12) score += 0.25;
    if (RegExp(r'[A-Z]').hasMatch(s)) score += 0.15;
    if (RegExp(r'[a-z]').hasMatch(s)) score += 0.15;
    if (RegExp(r'\d').hasMatch(s)) score += 0.1;
    if (RegExp(r'[!@#\$%^&*(),.?":{}|<>_\-\+=]').hasMatch(s)) score += 0.1;
    return score.clamp(0, 1);
  }

  @override
  Widget build(BuildContext context) {
    final v = _score(widget.text);
    final label = v < 0.34
        ? 'Weak'
        : (v < 0.67)
        ? 'Medium'
        : 'Strong';
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: v),
            duration: const Duration(milliseconds: 350),
            builder: (_, value, __) {
              return Stack(
                children: [
                  Container(height: 8, color: Colors.white12),
                  Container(
                    height: 8,
                    width: MediaQuery.sizeOf(context).width * value,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFFF5BA6),
                          Color(0xFF5B8CFF),
                          Color(0xFF00E5A8),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Password strength: $label',
          style: const TextStyle(color: Colors.white70, fontSize: 12.5),
        ),
      ],
    );
  }
}

/// Link text
class _Link extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _Link(this.text, {required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: InkRipple.splashFactory,
      onTap: onTap,
      child: ShaderMask(
        shaderCallback: (r) => const LinearGradient(
          colors: [Color(0xFF5B8CFF), Color(0xFF9B5BFF)],
        ).createShader(r),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

/// Social auth button (placeholder)
class _SocialBtn extends StatelessWidget {
  final IconData icon;
  final String label;

  const _SocialBtn({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: label,
      child: InkResponse(
        radius: 28,
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
            color: Colors.white.withOpacity(0.06),
          ),
          child: Row(
            children: [
              Icon(icon, size: 22),
              const SizedBox(width: 1),
              Text(label, style: const TextStyle(fontWeight: FontWeight.normal)),
            ],
          ),
        ),
      ),
    );
  }
}

/// Subtle animated grid overlay
class _FaintGridOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
        child: CustomPaint(
          painter: _GridPainter(),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = Colors.white.withOpacity(0.03)
      ..strokeWidth = 1;
    const gap = 36.0;
    for (double x = 0; x < size.width; x += gap) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), p);
    }
    for (double y = 0; y < size.height; y += gap) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), p);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Animated neon gradient "blobs"
class _NeonBlobPainter extends CustomPainter {
  final double t; // 0..1
  _NeonBlobPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width;
    final cy = size.height;

    // Helper to draw a moving radial gradient circle
    void blob(Offset center, double radius, List<Color> colors) {
      final rect = Rect.fromCircle(center: center, radius: radius);
      final shader = RadialGradient(
        colors: colors,
        stops: const [0.0, 0.6, 1.0],
      ).createShader(rect);
      final paint = Paint()
        ..shader = shader
        ..blendMode = BlendMode.plus;
      canvas.drawCircle(center, radius, paint);
    }

    final a = math.sin(t * 2 * math.pi);
    final b = math.cos((t + 0.33) * 2 * math.pi);
    final c = math.sin((t + 0.66) * 2 * math.pi);

    blob(Offset(cx * (0.2 + 0.15 * a), cy * (0.3 + 0.1 * b)), cy * 0.6, [
      const Color(0x33214BFF),
      const Color(0x225B8CFF),
      Colors.transparent,
    ]);
    blob(Offset(cx * (0.8 + 0.1 * b), cy * (0.35 + 0.1 * c)), cy * 0.55, [
      const Color(0x339B5BFF),
      const Color(0x229B5BFF),
      Colors.transparent,
    ]);
    blob(Offset(cx * (0.5 + 0.12 * c), cy * (0.8 + 0.08 * a)), cy * 0.7, [
      const Color(0x3300E5A8),
      const Color(0x2200E5A8),
      Colors.transparent,
    ]);
  }

  @override
  bool shouldRepaint(covariant _NeonBlobPainter oldDelegate) =>
      oldDelegate.t != t;
}
