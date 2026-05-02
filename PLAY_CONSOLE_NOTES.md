# Google Play Notes

Last reviewed against the current codebase on May 2, 2026.

## Current app behavior

- The app stores assessment and booking data locally on the device.
- The app does not send saved user profiles or results to a developer backend in the current code.
- The app can open external channels only after user action:
  - WhatsApp
  - SMS
  - Phone call
  - PDF sharing / printing
- Main Android manifest does not request sensitive runtime permissions.
- `INTERNET` appears only in debug/profile manifests, not in the main release manifest.

## Privacy policy

- In-app privacy policy screen exists under Settings.
- A publishable privacy policy file exists at `web/privacy-policy.html`.
- Before Play submission, host that page on a public non-editable URL and place the same URL in Play Console.

## Suggested Data safety direction

This is a code-based suggestion, not legal advice. Re-check in Play Console before submission.

- Collected data by developer/app backend:
  - Likely `No`, because the current app stores data on-device only and does not send it to a developer server.
- Shared data:
  - Likely `No` for developer-controlled sharing.
  - User-triggered external actions like WhatsApp, SMS, phone, printing, and PDF sharing should be described consistently in the privacy policy and store listing notes if needed.
- Security:
  - Be careful not to claim data is encrypted in transit if there is no developer backend transmission.
  - Be careful not to claim strong local encryption unless you implement it explicitly.

## Data categories visible in code

Potential user-provided data handled locally by the app:

- Name
- Age
- Job
- Education
- Questionnaire answers
- Compatibility result
- Marriage-readiness result
- Phone number
- Preferred booking date
- Booking message text

## Remaining external tasks before release

- Replace the privacy contact in `web/privacy-policy.html` with your final support email or official privacy contact.
- Host `web/privacy-policy.html` on a public HTTPS URL.
- Put that URL in Play Console.
- Make sure the developer or business name in Play Console matches the privacy policy text.
- Fill the Data safety form consistently with the final published behavior.
- Prepare store listing assets, content rating, and target audience declarations.
