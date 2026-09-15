import 'dart:convert';

import 'package:ataa/Data/Model/Donation/donation.dart';
import 'package:flutter_test/flutter_test.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this test }}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// Pins the contract of the `projects/show_campaign` endpoint that feeds the
/// campaign-creation selection sheet. The endpoint speaks the same `project_*`
/// schema as the other project endpoints, so `DonationX.fromJson` must parse it
/// with no translator. The fixture below is a real item captured from the live
/// endpoint response.
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

const String _showCampaignItemJson = '''
{"id":"a1283fde-bf43-4eaa-9b1b-3596e9b82c96","model_type":"project","project_basic":{"name":"وقف + تجهيز 150 داعية","code":20,"portal_project_name":"وقف + تجهيز 150 داعية","start_date":"2026-02-01","end_date":null,"price":500000,"previous_donations_price":0,"order":4,"status":true,"creation_source":"dashboard","is_default_zakat":false,"creation_source_localized":"لوحة التحكم","creation_status":"accepted","creation_status_localized":"تم القبول","completion_rate":5.02,"donate_rest":474889,"your_donation":0,"total_donation":25111,"count_donation":397,"count_donor":366},"project_details":{"excerpt":"excerpt","description":"<p>desc</p>","image":{"url":"https://cdn.ataa.com.sa/429/resized_LfXkMO.jpeg","responsive_urls":[]},"video_url":null},"project_settings":{"license":null,"is_show_homepage":true,"is_show_donations_percentage":false,"is_active_completion_notification":false,"is_show_completion_indicator":true,"is_add_completion_indicator_campaign":false,"is_active_gifting":true,"is_active_accepts_zakat":false,"is_show_donors_count":true,"is_archived":false,"is_show_quick_donation":true,"is_show_campaign":true,"is_show_project_in_branches":false},"project_branch_mappings":[]}
''';

void main() {
  group('show_campaign item parsing', () {
    late DonationX donation;

    setUp(() {
      final Map<String, dynamic> json =
          jsonDecode(_showCampaignItemJson) as Map<String, dynamic>;
      donation = DonationX.fromJson(json);
    });

    test('parses identity and display fields from the project_* schema', () {
      expect(donation.id, 'a1283fde-bf43-4eaa-9b1b-3596e9b82c96');
      expect(donation.donationBasic.name, 'وقف + تجهيز 150 داعية');
      expect(donation.donationDetails.imageUrl,
          'https://cdn.ataa.com.sa/429/resized_LfXkMO.jpeg');
    });

    test('parses the completion rate and reports the project as not done', () {
      expect(donation.donationBasic.completionRate, 5.02);
      expect(donation.donationBasic.isDone, isFalse);
    });

    test('maps the progress numbers used by the campaign screen', () {
      // completionRate < 100, so the endpoint would never return a done project.
      expect(donation.donationBasic.currentDonations, 25111); // total_donation
      expect(donation.donationBasic.totalDonations, 500000); // price
    });
  });
}
