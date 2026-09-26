import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sealed_countries/sealed_countries.dart';

import '../../l10n/generated/app_localizations.dart';
import '../errors/form_validators.dart';
import '../phone/phone_numbers.dart';
import '../theme/app_tokens.dart';
import 'app_controls.dart';

/// Country dial code + national number field; emits E.164 via [onChanged].
class AppPhoneField extends StatefulWidget {
  const AppPhoneField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.optional = false,
    this.helperText,
    this.prefixIcon = Icons.phone_outlined,
  });

  final String label;
  final String value;
  final ValueChanged<String> onChanged;
  final bool optional;
  final String? helperText;
  final IconData prefixIcon;

  @override
  State<AppPhoneField> createState() => _AppPhoneFieldState();
}

class _AppPhoneFieldState extends State<AppPhoneField> {
  late final TextEditingController _national;
  late WorldCountry _country;

  @override
  void initState() {
    super.initState();
    _national = TextEditingController();
    _country = WorldCountry.fromCodeShort('TN');
    _applyIncoming(widget.value);
  }

  @override
  void didUpdateWidget(covariant AppPhoneField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _applyIncoming(widget.value);
    }
  }

  void _applyIncoming(String raw) {
    final split = PhoneNumbers.split(raw);
    if (split != null) {
      _country = split.$1;
      if (_national.text != split.$2) {
        _national.text = split.$2;
      }
    } else if (raw.isEmpty && _national.text.isNotEmpty) {
      _national.clear();
    }
  }

  void _emit() {
    final national = _national.text.trim();
    if (national.isEmpty) {
      widget.onChanged('');
      return;
    }
    widget.onChanged(PhoneNumbers.compose(_country, national));
  }

  @override
  void dispose() {
    _national.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final dial = PhoneNumbers.dialDigits(_country);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 168,
                child: AppDropdownField<String>(
                  label: l10n.phoneCountryCode,
                  value: _country.codeShort,
                  compact: true,
                  items: [
                    for (final country in PhoneNumbers.dialCountries)
                      DropdownMenuItem(
                        value: country.codeShort,
                        child: Text(
                          '${country.emoji} +${PhoneNumbers.dialDigits(country)}',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                  ],
                  onChanged: (code) {
                    if (code == null) return;
                    setState(() {
                      _country = WorldCountry.fromCodeShort(code);
                    });
                    _emit();
                  },
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: AppTextField(
                  controller: _national,
                  label: widget.label,
                  helperText:
                      widget.helperText ??
                      l10n.phoneCountryHint(
                        '${_country.emoji} ${_country.name.common} (+$dial)',
                      ),
                  prefixIcon: widget.prefixIcon,
                  compact: true,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (_) => _emit(),
                  validator: (value) {
                    final full = PhoneNumbers.compose(_country, value ?? '');
                    if (widget.optional && (value == null || value.isEmpty)) {
                      return null;
                    }
                    return FormValidators.phone(l10n, full);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
