import 'package:flutter/material.dart';
import '../../../core/config/connected_feature_dependency_container.dart';
import '../../../core/localization/app_strings.dart';
import '../../../core/widgets/app_page.dart';
import '../../../core/widgets/form_text_field.dart';
import '../../../core/widgets/section_card.dart';
import '../../../domain/models/auth_user.dart';
import '../../../domain/use_cases/auth_use_cases.dart';

enum AccountScreenMode { signIn, createAccount }

class AccountScreen extends StatefulWidget {
  const AccountScreen({
    super.key,
    this.initialMode = AccountScreenMode.signIn,
    this.redirectRouteOnSuccess,
    this.getCurrentAuthUserUseCase,
    this.createAccountWithEmailUseCase,
    this.signInWithEmailUseCase,
    this.signOutUseCase,
  });

  final AccountScreenMode initialMode;
  final String? redirectRouteOnSuccess;
  final GetCurrentAuthUserUseCase? getCurrentAuthUserUseCase;
  final CreateAccountWithEmailUseCase? createAccountWithEmailUseCase;
  final SignInWithEmailUseCase? signInWithEmailUseCase;
  final SignOutUseCase? signOutUseCase;

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late final GetCurrentAuthUserUseCase _getCurrentAuthUserUseCase;
  late final CreateAccountWithEmailUseCase _createAccountWithEmailUseCase;
  late final SignInWithEmailUseCase _signInWithEmailUseCase;
  late final SignOutUseCase _signOutUseCase;

  late AccountScreenMode _mode;
  AuthUser? _currentUser;
  String? _statusMessageKey;
  bool _isLoading = true;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _mode = widget.initialMode;
    final container = ConnectedFeatureDependencyContainer.forCurrentMode();
    _getCurrentAuthUserUseCase =
        widget.getCurrentAuthUserUseCase ??
        GetCurrentAuthUserUseCase(container.auth);
    _createAccountWithEmailUseCase =
        widget.createAccountWithEmailUseCase ??
        CreateAccountWithEmailUseCase(container.auth);
    _signInWithEmailUseCase =
        widget.signInWithEmailUseCase ?? SignInWithEmailUseCase(container.auth);
    _signOutUseCase = widget.signOutUseCase ?? SignOutUseCase(container.auth);
    _loadCurrentUser();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loadCurrentUser() async {
    final user = await _getCurrentAuthUserUseCase.execute();
    if (!mounted) return;
    setState(() {
      _currentUser = user;
      _isLoading = false;
    });
  }

  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSubmitting = true);
    try {
      final result = await _signInWithEmailUseCase.execute(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      if (!mounted) return;
      setState(() => _statusMessageKey = result.message);
      if (result.success) {
        await _loadCurrentUser();
        await _handleSuccessRedirect();
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  Future<void> _createAccount() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSubmitting = true);
    try {
      final result = await _createAccountWithEmailUseCase.execute(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      if (!mounted) return;
      setState(() => _statusMessageKey = result.message);
      if (result.success) {
        await _loadCurrentUser();
        await _handleSuccessRedirect();
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  Future<void> _signOut() async {
    setState(() => _isSubmitting = true);
    try {
      await _signOutUseCase.execute();
      if (!mounted) return;
      _emailController.clear();
      _passwordController.clear();
      setState(() => _statusMessageKey = 'signedOut');
      await _loadCurrentUser();
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  Future<void> _handleSuccessRedirect() async {
    final route = widget.redirectRouteOnSuccess;
    if (!mounted || route == null) return;
    Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final isCreateMode = _mode == AccountScreenMode.createAccount;

    return AppPage(
      title: context.tr(
        isCreateMode ? 'accountCreateAccount' : 'accountSignIn',
      ),
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(20),
              children: [
                SectionCard(
                  title: context.tr('accountIntroTitle'),
                  icon: Icons.account_circle_outlined,
                  child: Text(
                    context.tr(
                      isCreateMode
                          ? 'accountCreateModeBody'
                          : 'accountSignInModeBody',
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SectionCard(
                  title: context.tr('accountStatusTitle'),
                  icon: Icons.verified_user_outlined,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _currentUser == null
                            ? context.tr('accountSignedOut')
                            : '${context.tr('accountSignedInAs')}: ${_currentUser!.email}',
                      ),
                      if (_statusMessageKey != null) ...[
                        const SizedBox(height: 8),
                        Text(context.tr(_statusMessageKey!)),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SectionCard(
                  title: context.tr('accountActionTitle'),
                  icon: isCreateMode
                      ? Icons.person_add_alt_1_outlined
                      : Icons.login_outlined,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SegmentedButton<AccountScreenMode>(
                          segments: [
                            ButtonSegment(
                              value: AccountScreenMode.signIn,
                              icon: const Icon(Icons.login_outlined),
                              label: Text(context.tr('accountSignIn')),
                            ),
                            ButtonSegment(
                              value: AccountScreenMode.createAccount,
                              icon: const Icon(Icons.person_add_alt_1_outlined),
                              label: Text(context.tr('accountCreateAccount')),
                            ),
                          ],
                          selected: {_mode},
                          onSelectionChanged: _isSubmitting
                              ? null
                              : (selection) {
                                  setState(() {
                                    _mode = selection.first;
                                    _statusMessageKey = null;
                                  });
                                },
                        ),
                        const SizedBox(height: 16),
                        AppTextField(
                          controller: _emailController,
                          label: context.tr('accountEmail'),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return context.tr('fieldRequired');
                            }
                            if (!value.contains('@')) {
                              return context.tr('invalidEmail');
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 14),
                        AppTextField(
                          controller: _passwordController,
                          label: context.tr('accountPassword'),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return context.tr('fieldRequired');
                            }
                            if (value.length < 6) {
                              return context.tr('accountPasswordTooShort');
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 14),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton.icon(
                            onPressed: _isSubmitting
                                ? null
                                : isCreateMode
                                ? _createAccount
                                : _signIn,
                            icon: _isSubmitting
                                ? const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Icon(
                                    isCreateMode
                                        ? Icons.person_add_alt_1_outlined
                                        : Icons.login_outlined,
                                  ),
                            label: Text(
                              context.tr(
                                isCreateMode
                                    ? 'accountCreateAccount'
                                    : 'accountSignIn',
                              ),
                            ),
                          ),
                        ),
                        if (_currentUser != null) ...[
                          const SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              onPressed: _isSubmitting ? null : _signOut,
                              icon: const Icon(Icons.logout_outlined),
                              label: Text(context.tr('accountSignOut')),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
