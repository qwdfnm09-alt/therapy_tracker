import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/localization/app_strings.dart';
import '../../../core/widgets/app_page.dart';
import '../../../core/widgets/section_card.dart';
import '../../../data/local/partner_offers_repository.dart';
import '../../../domain/models/partner_offer.dart';

class PartnerOffersScreen extends StatelessWidget {
  const PartnerOffersScreen({
    super.key,
    this.repository = const PartnerOffersRepository(),
  });

  final PartnerOffersRepository repository;

  @override
  Widget build(BuildContext context) {
    final languageCode = Localizations.localeOf(context).languageCode;
    final offers = repository.all();

    return AppPage(
      title: context.tr('partnerOffers'),
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SectionCard(
            title: context.tr('partnerOffersIntroTitle'),
            icon: Icons.local_offer_outlined,
            child: Text(context.tr('partnerOffersIntroBody')),
          ),
          const SizedBox(height: 16),
          SectionCard(
            title: context.tr('partnerOffersAvailableTitle'),
            icon: Icons.storefront_outlined,
            child: Column(
              children: [
                for (var i = 0; i < offers.length; i++) ...[
                  _PartnerOfferCard(
                    offer: offers[i],
                    languageCode: languageCode,
                  ),
                  if (i != offers.length - 1) const SizedBox(height: 12),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PartnerOfferCard extends StatelessWidget {
  const _PartnerOfferCard({required this.offer, required this.languageCode});

  final PartnerOffer offer;
  final String languageCode;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final code = offer.code;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              offer.merchant(languageCode),
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            offer.title(languageCode),
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            offer.summary(languageCode),
            style: theme.textTheme.bodyMedium?.copyWith(height: 1.45),
          ),
          const SizedBox(height: 12),
          _OfferDetailRow(
            label: context.tr('partnerOffersClaimLabel'),
            value: offer.claimHint(languageCode),
          ),
          if (code != null) ...[
            const SizedBox(height: 10),
            _OfferDetailRow(
              label: context.tr('partnerOffersCodeLabel'),
              value: code,
            ),
            const SizedBox(height: 12),
            FilledButton.tonalIcon(
              onPressed: () => _copyCode(context, code),
              icon: const Icon(Icons.copy_all_outlined),
              label: Text(context.tr('partnerOffersCopyCode')),
            ),
          ],
          if ((offer.notes(languageCode) ?? '').isNotEmpty) ...[
            const SizedBox(height: 12),
            _OfferDetailRow(
              label: context.tr('partnerOffersNotesLabel'),
              value: offer.notes(languageCode)!,
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _copyCode(BuildContext context, String code) async {
    await Clipboard.setData(ClipboardData(text: code));
    if (!context.mounted) return;

    ScaffoldMessenger.maybeOf(
      context,
    )?.showSnackBar(SnackBar(content: Text(context.tr('partnerOffersCopied'))));
  }
}

class _OfferDetailRow extends StatelessWidget {
  const _OfferDetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(value, style: theme.textTheme.bodyMedium?.copyWith(height: 1.4)),
      ],
    );
  }
}
