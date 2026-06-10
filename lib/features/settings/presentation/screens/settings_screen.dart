import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/design_system/tokens/app_spacing.dart';
import '../../../../core/design_system/tokens/app_typography.dart';
import '../../../../core/responsive/responsive_layout.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../providers/settings_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final padding = ResponsiveLayout.pagePadding(context);
    final maxWidth = ResponsiveLayout.contentMaxWidth(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/weather'),
        ),
      ),
      body: SingleChildScrollView(
        padding: padding,
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Appearance', style: theme.textTheme.headlineMedium),
                const SizedBox(height: AppSpacing.m),
                _ThemeSection(),
                const SizedBox(height: AppSpacing.l),
                _FontSection(),
                const SizedBox(height: AppSpacing.l),
                const Divider(),
                const SizedBox(height: AppSpacing.m),
                Text('Account', style: theme.textTheme.headlineMedium),
                const SizedBox(height: AppSpacing.m),
                _LogoutButton(),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ThemeSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer<SettingsProvider>(
      builder: (context, settings, _) => Card(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.m),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Theme', style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: AppSpacing.m),
              Row(
                children: [
                  Expanded(
                    child: _SelectionTile(
                      label: 'Light',
                      icon: Icons.light_mode_outlined,
                      selected: settings.themeMode == ThemeMode.light,
                      onTap: () => settings.setThemeMode(ThemeMode.light),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.s),
                  Expanded(
                    child: _SelectionTile(
                      label: 'Dark',
                      icon: Icons.dark_mode_outlined,
                      selected: settings.themeMode == ThemeMode.dark,
                      onTap: () => settings.setThemeMode(ThemeMode.dark),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FontSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer<SettingsProvider>(
      builder: (context, settings, _) => Card(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.m),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Typography', style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: AppSpacing.m),
              Row(
                children: [
                  Expanded(
                    child: _SelectionTile(
                      label: 'Nunito',
                      sublabel: 'Clean & modern',
                      selected: settings.fontFamily == AppFontFamily.fontA,
                      onTap: () => settings.setFontFamily(AppFontFamily.fontA),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.s),
                  Expanded(
                    child: _SelectionTile(
                      label: 'Merriweather',
                      sublabel: 'Classic & elegant',
                      selected: settings.fontFamily == AppFontFamily.fontB,
                      onTap: () => settings.setFontFamily(AppFontFamily.fontB),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SelectionTile extends StatelessWidget {
  const _SelectionTile({
    required this.label,
    this.sublabel,
    this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final String? sublabel;
  final IconData? icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(AppSpacing.m),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: selected ? theme.colorScheme.primary : theme.colorScheme.outline,
            width: selected ? 2 : 1,
          ),
          color: selected ? theme.colorScheme.primary.withValues(alpha: 0.08) : null,
        ),
        child: Column(
          children: [
            if (icon != null) Icon(icon, color: selected ? theme.colorScheme.primary : null),
            Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: selected ? FontWeight.bold : null,
                color: selected ? theme.colorScheme.primary : null,
              ),
              textAlign: TextAlign.center,
            ),
            if (sublabel != null)
              Text(sublabel!, style: theme.textTheme.bodySmall, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, _) => OutlinedButton.icon(
        onPressed: auth.state == AuthState.loading
            ? null
            : () async {
                await context.read<AuthProvider>().logout();
                if (context.mounted) context.go('/login');
              },
        icon: const Icon(Icons.logout),
        label: const Text('Sign Out'),
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          foregroundColor: Theme.of(context).colorScheme.error,
          side: BorderSide(color: Theme.of(context).colorScheme.error),
        ),
      ),
    );
  }
}
