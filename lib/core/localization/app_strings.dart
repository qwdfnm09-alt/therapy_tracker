import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../../presentation/providers/app_state.dart';

class AppStrings {
  static const _values = <String, Map<String, String>>{
    'en': {
      'appName': 'ميثاق 360',
      'tagline': 'Marriage compatibility and family counseling',
      'startAssessment': 'Start assessment',
      'startUsage': 'Start Usage',
      'welcomeAccountEntry': 'Sign in or create account',
      'continueAssessment': 'Continue assessment',
      'settings': 'Settings',
      'welcomeTitle': 'Build a clearer marriage decision',
      'welcomeBody':
          'Evaluate personality, emotions, lifestyle, expectations, and family boundaries before marriage and after.',
      'homeTitle': 'Choose the feature you want to open',
      'homeBody':
          'Start the assessment flow, open the test, review the latest result, or go directly to counseling and settings.',
      'quickAccess': 'Quick access',
      'featurePersonality': 'Open the compatibility questions for both users',
      'featureResults': 'Review the latest calculated compatibility report',
      'featureCounseling': 'Book a counseling or coaching request',
      'featureResourcesToolsHub':
          'Open the educational content and practical family tools from one organized place',
      'featureEducationalHub':
          'Read practical pre-marriage guidance, key questions, and warning signs',
      'featureRelationshipTools':
          'Use simple relationship tools for care, attention, and weekly practice',
      'featureGratitudeBank':
          'Save short appreciation notes locally and review them later',
      'featureBudgetPlanner':
          'Track simple income and expense items locally to reduce money ambiguity',
      'featureRemindersCenter':
          'Plan small recurring reminders locally for check-ins, gratitude, and budget follow-up',
      'featureGuidedMediator':
          'Use a local guided conflict script to slow escalation and end with one practical agreement',
      'featureScenarioLab':
          'Compare how both people respond to realistic pressure scenarios without affecting the main compatibility score',
      'featureProblemBox':
          'Send a private relationship concern through the connected submission path and optionally forward it to WhatsApp',
      'featureEmergencySupport':
          'Open immediate support actions and review first-response guidance directly from Home',
      'featureSettings': 'Change language, theme, and clear saved data',
      'account': 'Account',
      'accountTileBody':
          'Optional connected sign-in for future cloud features, without affecting current local use.',
      'accountIntroTitle': 'Connected sign-in status',
      'accountIntroBody':
          'This screen prepares optional account access for future cloud features. The current app can still be used without signing in.',
      'accountStatusTitle': 'Current account state',
      'accountActionTitle': 'Account action',
      'accountSignedOut': 'Not signed in',
      'accountSignedInAs': 'Signed in as',
      'accountEmail': 'Email',
      'accountPassword': 'Password',
      'accountPasswordTooShort': 'Password must be at least 6 characters',
      'accountSignIn': 'Sign in',
      'accountCreateAccount': 'Create account',
      'accountSignOut': 'Sign out',
      'invalidEmail': 'Enter a valid email address',
      'connectedAuthDisabled':
          'Connected sign-in is not enabled in the current app mode.',
      'accountSignInModeBody':
          'Use this mode to enter with an existing account without changing the current local flows.',
      'accountCreateModeBody':
          'Use this mode to create a new account first, then enter the app directly when creation succeeds.',
      'signedIn': 'Signed in successfully.',
      'accountCreated': 'Account created and signed in successfully.',
      'signedOut': 'Signed out.',
      'signInFailed': 'Could not sign in with the provided credentials.',
      'accountCreateFailed': 'Could not create the account with these details.',
      'accountEmailInUse': 'This email is already used by another account.',
      'accountUserNotFound': 'No account was found for this email.',
      'accountWrongPassword': 'The password is incorrect.',
      'accountInvalidCredential':
          'This email or password is not accepted by Firebase Auth.',
      'accountTooManyRequests':
          'Too many attempts were made. Try again in a moment.',
      'problemBox': 'Anonymous problem box',
      'problemBoxTileBody':
          'Send a private relationship concern through the connected submission path when it becomes available.',
      'problemBoxIntroTitle': 'Private write-only concern box',
      'problemBoxIntroBody':
          'Use this screen to submit a private relationship concern for later review. The first version keeps this flow separate from all assessment and tool data.',
      'problemBoxTopic': 'Short topic',
      'problemBoxDetails': 'Details',
      'problemBoxTooShort': 'Write a slightly clearer description first.',
      'problemBoxSubmit': 'Submit concern',
      'problemBoxDisabled':
          'Connected submission is not enabled in the current app mode.',
      'problemBoxSubmitted': 'Concern submitted for review.',
      'problemBoxPermissionDenied':
          'Submission is blocked by the current Firestore rules.',
      'problemBoxUnavailable':
          'The problem box service is temporarily unavailable.',
      'problemBoxSubmitFailed': 'The concern could not be submitted right now.',
      'problemBoxWhatsappOpened': 'WhatsApp opened with the concern message.',
      'emergencySupport': 'Emergency support',
      'emergencySupportTileBody':
          'Open immediate support actions and review first-response guidance without changing any saved assessment data.',
      'emergencySupportIntroTitle': 'Immediate support routing',
      'emergencySupportIntroBody':
          'Use this screen when you need a fast support action. It does not trigger automatic escalation, background monitoring, or emergency dispatch.',
      'emergencySupportQuickActionsTitle': 'Quick actions',
      'emergencySupportActionNote':
          'If the device cannot open the selected action, use your local emergency services first when there is immediate physical danger.',
      'partnerOffers': 'Partner offers',
      'partnerOffersTileBody':
          'Review local partner offers and copy any available codes without affecting your current saved data.',
      'partnerOffersIntroTitle': 'Local offers only',
      'partnerOffersIntroBody':
          'This first version is intentionally simple. It only shows local read-only offers and claim notes so the app does not depend on any partner backend yet.',
      'partnerOffersAvailableTitle': 'Available offers',
      'partnerOffersCodeLabel': 'Discount code',
      'partnerOffersClaimLabel': 'How to use',
      'partnerOffersNotesLabel': 'Notes',
      'partnerOffersCopyCode': 'Copy code',
      'partnerOffersCopied': 'Offer code copied.',
      'connectedFeatures': 'Connected features',
      'connectedFeaturesTileBody':
          'Review the deferred cloud features and what each one still needs before activation.',
      'connectedFeaturesIntroTitle': 'Cloud architecture status',
      'connectedFeaturesIntroBody':
          'These features are intentionally not live yet. This screen tracks the backend, policy, and operations layers still required before any connected rollout.',
      'connectedFeaturesLocalOnlyNote':
          'The current app remains local-first. Nothing here is active for end users yet.',
      'connectedFeaturesModeLabel': 'Mode',
      'connectedFeaturesEnabledCountLabel': 'Enabled',
      'connectedFeaturesGatedCountLabel': 'Gated',
      'connectedFeaturesStatusLabel': 'Current state',
      'connectedFeaturesRequirementsLabel': 'Required before launch',
      'connectedFeaturesStatusPlanned': 'Planned architecture phase',
      'connectedFeaturesStatusGated': 'Gated by current app mode',
      'connectedFeaturesStatusEnabled': 'Enabled by gate',
      'backendModeLocalOnly': 'Local-only runtime',
      'backendModeConnectedPreview': 'Connected preview runtime',
      'backendModeConnectedLive': 'Connected live runtime',
      'connectedRequirementAuth': 'User identity',
      'connectedRequirementBackendApi': 'Backend API',
      'connectedRequirementPrivacyConsent': 'Privacy and consent',
      'connectedRequirementModeration': 'Moderation rules',
      'connectedRequirementExpertOperations': 'Expert operations',
      'connectedRequirementSafetyRouting': 'Safety routing',
      'connectedRequirementPartnerOperations': 'Partner operations',
      'educationalHub': 'Educational Hub',
      'resourcesToolsHub': 'Resources & Tools',
      'relationshipTools': 'Relationship tools',
      'guidedMediator': 'Guided mediator',
      'scenarioLab': 'Scenario Lab',
      'gratitudeBank': 'Gratitude Bank',
      'budgetPlanner': 'Budget Planner',
      'remindersCenter': 'Reminders Center',
      'toolsOverviewTitle': 'Saved overview',
      'toolsOverviewBody':
          'A quick read of the local items already saved in the practical tools.',
      'toolsOverviewSavedItems': 'saved items',
      'toolsOverviewSavedPlans': 'saved plans',
      'toolsOverviewLatestNote': 'Latest gratitude note',
      'toolsOverviewNoData': 'No saved local data yet.',
      'educationalHubOverviewTitle': 'At a glance',
      'educationalHubOverviewBody':
          'Open the right collection faster by scanning the main educational groups first.',
      'educationalHubGuideHelper':
          'Short practical cards for calmer premarital discussions',
      'relationshipToolsOverviewTitle': 'At a glance',
      'relationshipToolsOverviewBody':
          'Use these shortcuts to move faster to the section you want inside the relationship tools screen.',
      'relationshipToolsOverviewUsage':
          '3 short rules to keep the tools practical and realistic',
      'gratitudeBankOverviewTitle': 'At a glance',
      'gratitudeBankOverviewBody':
          'Use the summary first, then jump directly to writing or reviewing saved appreciation notes.',
      'gratitudeBankOverviewActionHelper':
          'Jump directly to the writing section',
      'gratitudeBankOverviewLatestTitle': 'Latest saved note',
      'gratitudeBankSummaryTitle': 'Monthly summary',
      'gratitudeBankSummaryBody':
          'A small reading of consistency so appreciation does not stay abstract.',
      'gratitudeBankSummaryTotalLabel': 'Total saved notes',
      'gratitudeBankSummaryMonthLabel': 'Notes this month',
      'gratitudeBankSummaryLatestLabel': 'Latest saved date',
      'gratitudeBankSummaryNoDate': 'No saved date yet',
      'budgetPlannerOverviewTitle': 'At a glance',
      'budgetPlannerOverviewBody':
          'Use the quick overview first, then jump directly to the summary, writing section, or saved entries.',
      'budgetPlannerOverviewSummaryHelper':
          'Jump directly to the money summary section',
      'budgetPlannerOverviewActionHelper': 'Jump directly to the entry form',
      'budgetPlannerOverviewEntriesHelper':
          'Jump directly to the saved entries section',
      'budgetPlannerOverviewLatestTitle': 'Latest saved entry',
      'budgetPlannerSmartSummaryTitle': 'Smarter summary',
      'budgetPlannerSmartSummaryBody':
          'Use these signals to spot where money pressure is clustering instead of reading totals alone.',
      'budgetPlannerSmartSummaryMonthLabel': 'Entries this month',
      'budgetPlannerSmartSummaryTopCategoryLabel': 'Top expense category',
      'budgetPlannerSmartSummaryTopAmountLabel': 'Top category amount',
      'budgetPlannerSmartSummaryNoCategory': 'No expense category yet',
      'remindersCenterOverviewTitle': 'At a glance',
      'remindersCenterOverviewBody':
          'Use the quick overview first, then jump directly to writing or reviewing saved reminder plans.',
      'remindersCenterOverviewActionHelper':
          'Jump directly to the reminder form',
      'remindersCenterOverviewLatestTitle': 'Latest saved reminder',
      'remindersCenterSmartSummaryTitle': 'Smarter summary',
      'remindersCenterSmartSummaryBody':
          'Use these signals to see whether your reminder plans are focused or scattered before turning them into real notifications.',
      'remindersCenterSmartSummaryMonthLabel': 'Plans this month',
      'remindersCenterSmartSummaryCategoriesLabel': 'Used categories',
      'remindersCenterSmartSummaryTopCategoryLabel': 'Most repeated category',
      'remindersCenterSmartSummaryNoCategory': 'No category used yet',
      'bookingHistoryOverviewTitle': 'At a glance',
      'bookingHistoryOverviewBody':
          'Use this summary first to review the booking history count and the latest request state.',
      'bookingHistoryOverviewCountHelper':
          'Total locally saved booking requests',
      'bookingHistoryOverviewStatusHelper':
          'Latest send result in the current history order',
      'bookingHistoryOverviewLatestTitle': 'Latest booking summary',
      'useLatestBooking': 'Use latest booking details',
      'latestBookingApplied': 'Latest booking details applied to the form.',
      'startNewBooking': 'Start new booking',
      'resourcesToolsHubIntroTitle':
          'One place for the added content and tools',
      'resourcesToolsHubIntroBody':
          'This screen keeps Home focused on the main journey while giving the newer content and support tools a clearer structure.',
      'resourcesToolsHubContentSection': 'Reading and conversation support',
      'resourcesToolsHubToolsSection': 'Practical follow-up tools',
      'educationalHubIntroTitle': 'A careful reading layer around the score',
      'educationalHubIntroBody':
          'This section does not change your compatibility result. It helps both people translate the result into clearer conversations and better judgment before commitment.',
      'educationalHubCollections': 'Collections',
      'premaritalGuide': 'Premarital guide',
      'goldenQuestions': 'Golden questions',
      'goldenQuestionsSubtitle':
          'Structured questions to surface hidden assumptions early',
      'goldenQuestionsIntroTitle':
          'Ask the difficult questions before pressure',
      'goldenQuestionsIntroBody':
          'These questions are useful because they reveal habits, assumptions, and future expectations. The goal is not to impress the other person but to make ambiguity smaller.',
      'redFlags': 'Red flags',
      'redFlagsSubtitle': 'Common warning signs that should not be minimized',
      'redFlagsIntroTitle': 'Warning signs deserve direct naming',
      'redFlagsIntroBody':
          'A red flag does not mean every relationship must end immediately. It means the pattern should not be excused, romanticized, or left vague.',
      'rightsAndDuties': 'Rights and responsibilities',
      'rightsAndDutiesSubtitle':
          'A practical awareness layer around fairness, boundaries, and support',
      'rightsAndDutiesIntroTitle':
          'Use clarity early before conflict turns chronic',
      'rightsAndDutiesIntroBody':
          'This section is not legal representation. It helps both sides turn vague expectations into clear discussion points around respect, fairness, privacy, and when outside support is necessary.',
      'inLawsGuide': 'In-laws guide',
      'inLawsGuideSubtitle':
          'Practical guidance for boundaries and family interference',
      'inLawsGuideIntroTitle':
          'Handle family pressure before it shapes the marriage',
      'inLawsGuideIntroBody':
          'This guide focuses on repeated family friction patterns: what should stay inside the couple, how to respond calmly to interference, and when stronger boundaries or counseling are necessary.',
      'marriageReadinessCard': 'Marriage readiness card',
      'marriageReadinessSubtitle':
          'A practical checklist before fast commitment',
      'marriageReadinessIntroTitle':
          'Readiness should be checked before promises grow heavier',
      'marriageReadinessIntroBody':
          'This section helps turn marriage readiness into concrete review points around self-awareness, pressure habits, responsibility, and decision pacing.',
      'heritageAwareness': 'Heritage and family awareness',
      'heritageAwarenessSubtitle': 'Read inherited ideas with a practical lens',
      'heritageAwarenessIntroTitle':
          'Use culture to support the family, not to excuse harm',
      'heritageAwarenessIntroBody':
          'This section revisits inherited sayings and family stories with a practical lens: keep what strengthens mercy and responsibility, and challenge what normalizes harm or domination.',
      'relationshipToolsIntroTitle': 'Small tools for steadier connection',
      'relationshipToolsIntroBody':
          'These tools are intentionally simple. They do not diagnose the relationship, but they help both people turn care into visible action.',
      'loveLanguagesTitle': 'Love languages quick guide',
      'loveLanguagesBody':
          'Use this as a practical lens, not as a rigid label. The useful question is: what kind of care is actually felt by the other person?',
      'loveLanguagesQuizTitle': 'Love languages mini quiz',
      'loveLanguagesQuizBody':
          'Answer these short situations first, then use the saved result as a discussion starter instead of a final label.',
      'loveLanguagesQuizLatestTitle': 'Latest saved result',
      'loveLanguagesQuizPrimaryLabel': 'Primary language',
      'loveLanguagesQuizSaveAction': 'Save quiz result',
      'loveLanguagesQuizIncomplete':
          'Answer all quiz questions before saving the result.',
      'loveLanguagesQuizSaved': 'Love language result saved locally.',
      'weeklyChallengesTitle': 'Weekly connection challenges',
      'weeklyChallengesBody':
          'Choose one challenge at a time. Keep it specific and repeatable instead of turning it into a performance.',
      'weeklyChallengesChecklistTitle': 'Weekly checklist',
      'weeklyChallengesChecklistBody':
          'Mark the challenge when you actually practice it. The goal is follow-through, not collecting perfect intentions.',
      'weeklyChallengesProgressTitle': 'Completed this cycle',
      'weeklyChallengesProgressCount': '{current} of {total} challenges marked',
      'relationshipToolsUsageTitle': 'How to use these tools well',
      'relationshipToolsUsagePoint1':
          'Start with the smallest useful action instead of promising a full personality change.',
      'relationshipToolsUsagePoint2':
          'If one tool feels unnatural, discuss why before treating it as failure.',
      'relationshipToolsUsagePoint3':
          'Use repetition to build trust. Small consistent care is more useful than rare dramatic effort.',
      'guidedMediatorIntroTitle': 'A local conflict guide, not live mediation',
      'guidedMediatorIntroBody':
          'This tool does not use AI chat or live expert monitoring. It gives you a structured way to slow a tense conversation and end with one usable agreement.',
      'guidedMediatorTracksTitle': 'Choose the current tension type',
      'guidedMediatorTracksBody':
          'Pick the closest conflict pattern first. The plan below will adapt the prompts and the next-step structure to that pattern.',
      'guidedMediatorPlanTitle': 'Suggested mediation path',
      'guidedMediatorPauseLabel': 'Pause first',
      'guidedMediatorPersonALabel': 'Person A says',
      'guidedMediatorPersonBLabel': 'Person B says',
      'guidedMediatorAgreementLabel': 'End with one agreement',
      'guidedMediatorEscalationLabel': 'When to move to counseling',
      'guidedMediatorLocalNoteTitle': 'Current boundary',
      'guidedMediatorLocalNoteBody':
          'This is a local rule-based guide only. It does not save the conflict, send it to the cloud, or replace direct safety support when the situation is dangerous.',
      'scenarioLabIntroTitle': 'Stress-test the fit with realistic scenarios',
      'scenarioLabIntroBody':
          'This lab is separate from the main compatibility score. It gives both people a safer place to compare instincts under pressure before those moments happen in real life.',
      'scenarioLabSummaryTitle': 'Compatibility radar',
      'scenarioLabSummaryBody':
          'This quick radar reads scenario alignment only. Use it to spot where instincts already match and where a clear agreement is still needed.',
      'scenarioLabAnsweredLabel': 'Answered scenarios',
      'scenarioLabAlignedLabel': 'Strong alignment',
      'scenarioLabCloseLabel': 'Close but not identical',
      'scenarioLabGapLabel': 'Visible gap',
      'scenarioLabRecommendationsTitle': 'Discussion recommendations',
      'scenarioLabRecommendationsBody':
          'Use these points as the next conversation list. Start with visible gaps first, then define what a workable agreement looks like in the close scenarios.',
      'scenarioLabRecommendationGapLabel': 'Discuss first',
      'scenarioLabRecommendationCloseLabel': 'Clarify expectations',
      'scenarioLabRecommendationGapHint':
          'The difference here is clear enough to need one direct agreement before pressure grows.',
      'scenarioLabRecommendationCloseHint':
          'The direction is close, but the preferred method still needs a specific agreement.',
      'scenarioLabUserALabel': 'Person A choice',
      'scenarioLabUserBLabel': 'Person B choice',
      'scenarioLabFocusLabel': 'Focus',
      'gratitudeBankIntroTitle': 'A simple memory of what went right',
      'gratitudeBankIntroBody':
          'This tool stores short notes of appreciation locally on the device. The goal is to preserve visible evidence of care instead of relying on memory alone during tension.',
      'gratitudeBankAddTitle': 'Add a new note',
      'gratitudeBankPrompt':
          'Write one short thing you appreciated. Keep it concrete and specific.',
      'gratitudeBankHint':
          'Example: I appreciated how calmly you handled today’s pressure.',
      'gratitudeBankTooShort': 'Write a slightly clearer appreciation note.',
      'gratitudeBankSaveAction': 'Save note',
      'gratitudeBankSavedTitle': 'Saved notes',
      'gratitudeBankEmpty':
          'No gratitude notes yet. Add the first one when something small and real deserves to be remembered.',
      'budgetPlannerIntroTitle': 'A simple money clarity tool',
      'budgetPlannerIntroBody':
          'This tool is intentionally lightweight. It helps both sides make money conversations clearer by tracking a few visible entries locally.',
      'budgetPlannerSummaryTitle': 'Current summary',
      'budgetPlannerAddTitle': 'Add a budget entry',
      'budgetPlannerEntriesTitle': 'Saved entries',
      'budgetPlannerEmpty':
          'No budget entries yet. Add the first income or expense item to start a clearer money view.',
      'budgetTitle': 'Entry title',
      'budgetAmount': 'Amount',
      'budgetType': 'Type',
      'budgetCategory': 'Category',
      'budgetIncome': 'Income',
      'budgetExpense': 'Expense',
      'budgetBalance': 'Balance',
      'budgetAmountInvalid': 'Enter a valid amount greater than zero',
      'budgetSaveAction': 'Save entry',
      'remindersCenterIntroTitle': 'A local reminder planner',
      'remindersCenterIntroBody':
          'Use this screen to plan small recurring reminders that support calmer routines and clearer follow-up.',
      'remindersCenterLocalOnlyNote':
          'This phase stores reminder plans locally only. It does not trigger device notifications yet.',
      'remindersCenterNotificationNote':
          'New reminder plans can now schedule actual device notifications using a structured daily or weekly schedule.',
      'remindersCenterAddTitle': 'Add a reminder plan',
      'remindersCenterSavedTitle': 'Saved reminder plans',
      'remindersCenterEmpty':
          'No reminder plans yet. Add one simple plan instead of trying to track everything mentally.',
      'reminderTitle': 'Reminder title',
      'reminderCategory': 'Reminder category',
      'reminderCategoryCheckIn': 'Relationship check-in',
      'reminderCategoryGratitude': 'Gratitude reminder',
      'reminderCategoryBudget': 'Budget follow-up',
      'reminderCategoryCustom': 'Custom reminder',
      'reminderScheduleLabel': 'Schedule label',
      'reminderScheduleHint': 'Example: Every Friday at 8:00 PM',
      'reminderScheduleType': 'Schedule type',
      'reminderScheduleDaily': 'Daily',
      'reminderScheduleWeekly': 'Weekly',
      'reminderWeekday': 'Weekday',
      'reminderPickTime': 'Pick reminder time',
      'reminderSelectedTime': 'Selected time',
      'reminderNotificationScheduled':
          'Reminder saved and scheduled as a device notification.',
      'reminderNotificationSavedLocalOnly':
          'Reminder saved locally, but notification permission was not granted.',
      'monday': 'Monday',
      'tuesday': 'Tuesday',
      'wednesday': 'Wednesday',
      'thursday': 'Thursday',
      'friday': 'Friday',
      'saturday': 'Saturday',
      'sunday': 'Sunday',
      'reminderNote': 'Optional note',
      'reminderSaveAction': 'Save reminder plan',
      'delete': 'Delete',
      'assessmentStatus': 'Assessment status',
      'latestBooking': 'Latest booking',
      'bookingHistory': 'Booking history',
      'bookingHistoryEmpty': 'No booking history yet.',
      'noBookingYet': 'No booking request has been saved yet.',
      'bookingDate': 'Preferred date',
      'bookingType': 'Session type',
      'bookingPhone': 'Phone',
      'bookingMessage': 'Message',
      'clinicPhone': 'Clinic phone',
      'bookingStatus': 'Send status',
      'bookingRecommendation': 'Recommendation',
      'bookingResultVerdict': 'Result verdict',
      'recommendedSessionTitle': 'Recommended session from your result',
      'bookRecommendedSession': 'Book recommended session',
      'saveAsPdf': 'Save as PDF',
      'generatedAt': 'Generated at',
      'pdfOpeningOptions': 'Opening PDF options...',
      'pdfReadyTitle': 'PDF options',
      'pdfPreparing': 'Preparing the PDF file...',
      'pdfSaveAction': 'Save or share PDF',
      'pdfPrintAction': 'Print PDF',
      'pdfExportReady': 'The PDF file is ready to share or save.',
      'pdfActionFailed': 'The PDF action could not be completed.',
      'pdfExportFailed': 'The PDF report could not be prepared.',
      'recommendedReasonIndividual':
          'The current result suggests that individual readiness needs deeper review before any fast commitment.',
      'recommendedReasonFamily':
          'The current result points to family-boundary pressure that fits a family consultation best.',
      'recommendedReasonPlanning':
          'The current result points to expectation and planning gaps that fit a coaching session well.',
      'recommendedReasonCommunication':
          'The current result shows communication pressure that will benefit from a guided coaching conversation.',
      'recommendedReasonAlignment':
          'The current result mainly needs one alignment-focused session to confirm expectations clearly.',
      'viewBookingDetails': 'View booking details',
      'viewBookingHistory': 'View booking history',
      'createdAt': 'Created at',
      'questionnaire': 'Questionnaire',
      'questionnaireProgress': 'Questionnaire progress',
      'scaleHint': '1 = low agreement, 5 = high agreement',
      'personalityIntro':
          'This version uses situational statements and clearer behavior anchors instead of plain generic ratings.',
      'selectClosestAnswer': 'Choose the answer that feels most like you',
      'personalityOnboardingTitle': 'A deeper personality journey',
      'personalityOnboardingBody':
          'This test is built as a staged journey. It reads style, emotional rhythm, conflict habits, and future pressure points instead of collecting flat ratings only.',
      'personalityOnboardingStagesTitle': 'Stage-based flow',
      'personalityOnboardingStagesBody':
          'You move through focused cards instead of one long page, so each block has a clear theme and pace.',
      'personalityOnboardingAdaptiveTitle': 'Adaptive branching',
      'personalityOnboardingAdaptiveBody':
          'Some later stages appear only when your answers reveal a tension, pressure area, or meaningful difference that needs deeper reading.',
      'personalityOnboardingArchetypeTitle': 'Archetype summary',
      'personalityOnboardingArchetypeBody':
          'At the end, each person gets a readable archetype and the relationship gets a clearer dynamic summary.',
      'startPersonalityJourney': 'Start personality journey',
      'resumePersonalityJourney': 'Resume personality journey',
      'restartPersonalityJourney': 'Restart from beginning',
      'stageProgress': 'Stage progress',
      'questionProgress': 'Question progress',
      'questionOfStage': 'Question {current} of {total}',
      'answerBothUsersPrompt':
          'Answer for both people before moving through the stage smoothly.',
      'questionAwaitingAnswer':
          'This question is still waiting for one or both answers.',
      'questionReadyToAdvance': 'Both answers are set. You can keep moving.',
      'previousStage': 'Previous',
      'nextStage': 'Next',
      'previousQuestion': 'Previous question',
      'nextQuestion': 'Next question',
      'continueToNextStage': 'Next stage',
      'reviewPreviousStage': 'Previous stage',
      'stageComplete': 'This stage is complete',
      'stageInsight': 'Stage insight',
      'stageInsightPrompt':
          'This stage helps reveal how both people handle this part of marriage in real life.',
      'stageInsightStrong':
          'The answers here already suggest a stable rhythm between both people.',
      'stageInsightGap':
          'A visible gap is forming here. This is not fatal, but it does need an explicit agreement.',
      'stageInsightMixed':
          'This area shows partial alignment. The next discussion matters more than the score alone.',
      'midJourneyInsightTitle': 'What we are seeing so far',
      'midJourneyStrong':
          'Across {stages}, the answers suggest a naturally compatible rhythm so far.',
      'midJourneyGap':
          'Across {stages}, a visible difference is emerging and needs direct conversation.',
      'midJourneyMixed':
          'Across {stages}, there is partial alignment with a few topics that need clearer expectations.',
      'midJourneyContinue': 'Continue journey',
      'adaptiveFocusTitle': 'Adaptive focus',
      'adaptiveStagePlanning': 'Planning under change',
      'adaptiveStageAnger': 'Escalation control',
      'adaptiveStageFamily': 'Family pressure handling',
      'adaptiveStageCareer': 'Career and family tradeoffs',
      'categoryAnalysis': 'Category analysis',
      'completeQuestionnaire': 'Complete all questions for both users first',
      'answeredQuestions': 'Answered questions',
      'relationshipDynamics': 'Relationship dynamics',
      'personalityProfile': 'Personality profile',
      'archetypeSummary': 'Archetype summary',
      'narrativeSummary': 'Narrative summary',
      'personalityMap': 'Visual personality map',
      'comparisonLens': 'Comparison lens',
      'keyTakeaways': 'Key takeaways',
      'relationshipPulse': 'Relationship pulse',
      'watchpoint': 'Watchpoint',
      'advantage': 'Advantage',
      'nextStepTitle': 'Recommended next step',
      'discussionTopicsTitle': 'Topics to discuss before engagement',
      'conversationPrepTitle': 'Conversation prep',
      'decisionCheckpointTitle': 'Decision checkpoint',
      'decisionCheckpointSlow':
          'The current result should slow the decision down. Do not treat chemistry alone as enough before the main pressure points are reviewed.',
      'decisionCheckpointDiscuss':
          'The result is workable, but only if the unresolved topics are discussed directly and converted into explicit agreements.',
      'decisionCheckpointStable':
          'The result looks stable enough for a focused final discussion. The goal now is to confirm expectations clearly, not to search for hidden conflict.',
      'discussionChecklistTitle': 'Checklist before a final decision',
      'discussionChecklistCompatibility':
          'Name the biggest difference in the result and agree on what daily behavior would make it manageable.',
      'discussionChecklistReadiness':
          'Clarify what still needs personal growth before either side treats the relationship as ready for full commitment.',
      'discussionChecklistExpectations':
          'Turn the most important expectations into direct language instead of assuming they are already understood.',
      'conversationGroundRulesTitle': 'Ground rules for the next conversation',
      'conversationGroundRule1':
          'Discuss one pressure area at a time and ask for concrete examples, not ideal answers.',
      'conversationGroundRule2':
          'If the same topic produces defensiveness or avoidance, treat that as useful information rather than forcing a quick conclusion.',
      'conversationGroundRule3':
          'End the conversation with one explicit agreement, one open question, and one next step.',
      'retakeLater': 'Review answers again',
      'nextStepCounselorFirst':
          'A guided counseling session should come before any fast commitment decision.',
      'nextStepGuidedDiscussion':
          'Hold a structured conversation around the main pressure points before moving forward.',
      'nextStepAlignment':
          'Use one focused pre-marriage conversation to confirm expectations and preserve the current alignment.',
      'topicConflictRepair':
          'How each person slows conflict down and repairs trust after tension.',
      'topicFamilyBoundaries':
          'How boundaries with both families will be set and protected.',
      'topicMoneyPlanning':
          'How budgeting, saving, and daily spending decisions will be shared.',
      'topicFutureTiming':
          'How children, work priorities, and timing expectations will be negotiated.',
      'topicCommunicationRhythm':
          'How often emotional check-ins and direct conversations are needed.',
      'topicHouseholdResponsibility':
          'How promises, roles, and daily responsibilities will be divided fairly.',
      'comparisonClose': 'Both people are close here.',
      'comparisonGapLight':
          'This difference looks manageable and may even complement the relationship.',
      'comparisonGapStrong':
          'This difference is strong enough to need explicit agreement before pressure rises.',
      'leanEnergyHigh': 'leans more social and externally energized',
      'leanEnergyLow': 'leans more quiet and internally recharged',
      'leanStructureHigh': 'leans more structured and plan-oriented',
      'leanStructureLow': 'leans more flexible and open-ended',
      'leanEmotionHigh': 'shows clearer emotional naming and expression',
      'leanEmotionLow': 'needs more time to identify and express feelings',
      'leanConflictHigh': 'stays steadier during conflict',
      'leanConflictLow': 'reacts faster under pressure',
      'heroSummaryLead': 'Overall read',
      'mapEnergy': 'Energy style',
      'mapStructure': 'Structure style',
      'mapEmotion': 'Emotional clarity',
      'mapConflict': 'Conflict regulation',
      'narrativeCompatibilityHigh':
          'The overall pattern points to strong compatibility with a stable base for marriage.',
      'narrativeCompatibilityMid':
          'The relationship looks workable, with clear strengths and a few areas that need deliberate agreement.',
      'narrativeCompatibilityLow':
          'The current pattern shows fragile compatibility and needs slower, more structured discussion.',
      'narrativeReadinessHigh':
          'Marriage readiness is also strong, which suggests the pair can carry responsibility with reasonable steadiness.',
      'narrativeReadinessMid':
          'Marriage readiness is moderate, so the relationship may benefit from a bit more preparation before a final decision.',
      'narrativeReadinessLow':
          'Marriage readiness is below the safer range, so pressure points should be reviewed before commitment.',
      'narrativeArchetypeLead': 'Their current archetypes read as',
      'narrativeDynamicLead': 'In practice, the relationship tends to show',
      'narrativeRiskLead': 'The main pressure area right now is',
      'narrativeStrengthLead': 'The clearest strength right now is',
      'narrativeSupportLead':
          'A guided conversation around these patterns would likely make the result more dependable.',
      'verdictTitle': 'Relationship verdict',
      'verdictStrong': 'Strong base',
      'verdictWorkable': 'Promising with discussion',
      'verdictFragile': 'Needs slower discussion',
      'verdictStrongBody':
          'The relationship shows a solid base, with differences that look manageable if expectations stay explicit.',
      'verdictWorkableBody':
          'The relationship has real potential, but several patterns should be discussed before decisions get serious.',
      'verdictFragileBody':
          'The current pattern needs slower and more structured conversation before a confident commitment.',
      'whatToDiscussNow': 'What to discuss now',
      'topStrengthNow': 'Top strength now',
      'finalRevealTitle': 'Ready for the final readout',
      'finalRevealBody':
          'You have completed the full journey. The next step will turn these answers into archetypes, a compatibility map, and the clearest discussion points.',
      'finalRevealPrimary': 'Reveal compatibility result',
      'reviewLastQuestion': 'Review last question',
      'completed': 'Completed',
      'pending': 'Pending',
      'userA': 'User A',
      'userB': 'User B',
      'name': 'Name',
      'age': 'Age',
      'job': 'Job',
      'education': 'Education',
      'profileSetupTitle': 'Build the personal profile first',
      'profileSetupBody':
          'This part sets the context for the personality journey, so keep it clean and realistic.',
      'profileProgress': 'Profile progress',
      'profileCompleteFields': '{current} of {total} fields complete',
      'identitySection': 'Identity basics',
      'identitySectionBody':
          'These details anchor the profile before the deeper compatibility reading starts.',
      'contextSection': 'Daily life context',
      'contextSectionBody':
          'Work and education help frame routines, pressure, and expectations.',
      'profileNextUserB':
          'After saving this profile, you will move to the second person.',
      'profileNextTest':
          'After saving this profile, you will move directly into the personality journey.',
      'nameHint': 'How should this person appear in the report?',
      'ageHint': '18+',
      'jobHint': 'Current role or main work',
      'educationHint': 'Highest completed education',
      'profileReady': 'Profile is ready for the next step.',
      'profileNeedsMore':
          'Complete the remaining fields to unlock the next step smoothly.',
      'next': 'Next',
      'saveContinue': 'Save and continue',
      'personalityTest': 'Personality test',
      'result': 'Compatibility result',
      'compatibility': 'Compatibility',
      'readiness': 'Marriage readiness',
      'strengths': 'Strength areas',
      'risks': 'Risk areas',
      'notes': 'Psychological notes',
      'sessions': 'Suggested counseling sessions',
      'bookConsultation': 'Book family consultation',
      'individualTherapy': 'Book individual therapy',
      'coaching': 'Pre-marriage coaching',
      'sessionTypeFamily': 'Family consultation',
      'sessionTypeIndividual': 'Individual therapy',
      'sessionTypeCoaching': 'Pre-marriage coaching',
      'booking': 'Counseling booking',
      'preferredDate': 'Preferred date',
      'phone': 'Phone number',
      'message': 'Message',
      'confirmBooking': 'Confirm booking',
      'bookingSaved': 'Booking request saved locally',
      'bookingSent': 'Booking request was opened for sending to the clinic.',
      'bookingSendFailed':
          'The booking was saved, but the phone could not open the sending app.',
      'bookingActionFailed':
          'The app could not open this action on the device.',
      'bookingStatusWhatsapp': 'Opened in WhatsApp',
      'bookingStatusSms': 'Opened in SMS',
      'bookingStatusCall': 'Opened phone call',
      'bookingStatusRemote': 'Saved to backend',
      'bookingStatusFailed': 'Saved locally only',
      'bookingConfirmationTitle': 'Booking request ready',
      'openWhatsapp': 'Open WhatsApp',
      'openSms': 'Open SMS',
      'callClinicAction': 'Call clinic',
      'copyBookingMessage': 'Copy request text',
      'bookingMessageCopied': 'Booking request text copied.',
      'openBookingHistory': 'Open booking history',
      'done': 'Done',
      'pickDate': 'Pick date',
      'appearance': 'Appearance',
      'language': 'Language',
      'light': 'Light',
      'dark': 'Dark',
      'system': 'System',
      'english': 'English',
      'arabic': 'Arabic',
      'clearData': 'Clear saved assessment',
      'calculate': 'Calculate compatibility',
      'completeProfiles': 'Complete both profiles first',
      'resultEmptyBody':
          'Finish both profiles and answer all questions to generate a compatibility report.',
      'openAssessment': 'Open assessment',
      'fieldRequired': 'This field is required',
      'invalidAge': 'Age must be 18 or above',
      'invalidPhone': 'Enter a valid phone number',
      'selectPreferredDate': 'Select your preferred date',
      'categoryPersonality': 'Personality',
      'categoryEmotionalIntelligence': 'Emotional intelligence',
      'categoryAngerManagement': 'Anger management',
      'categoryCommunication': 'Communication',
      'categoryFinancialMindset': 'Financial mindset',
      'categoryFamilyBoundaries': 'Family boundaries',
      'categoryFutureGoals': 'Future goals',
      'categoryResponsibility': 'Responsibility',
      'noHighRisk':
          'No high-risk area detected by the current scoring profile.',
      'noStrongAlignmentYet':
          'Shared effort is visible, but no category is strongly aligned yet.',
      'alignmentLabel': 'alignment',
      'needsStructuredDiscussion': 'needs structured discussion',
      'noteStrongAlignment':
          'The couple shows strong alignment, but expectations should still be discussed explicitly.',
      'noteWorkableCompatibility':
          'The relationship has workable compatibility with several topics needing guided conversation.',
      'noteFragileCompatibility':
          'Compatibility is currently fragile. A counselor should review the main gaps before commitment.',
      'noteAngerManagement':
          'Conflict repair and anger regulation need attention before marriage pressure increases.',
      'noteFamilyBoundaries':
          'Family boundary expectations may cause repeated stress if they remain vague.',
      'noteReadinessThreshold':
          'Marriage readiness is below the recommended threshold for a confident decision.',
      'sessionCommunication': 'Communication and conflict dialogue session',
      'sessionFamilyBoundaries': 'Family boundaries consultation',
      'sessionFuturePlanning':
          'Future planning and financial expectations session',
      'sessionIndividualReadiness': 'Individual psychological readiness review',
      'sessionAlignment':
          'One pre-marriage coaching session for final alignment',
      'profileEnergyOutgoing':
          'Gets energy from people, movement, and visible interaction.',
      'profileEnergyReserved':
          'Recharges better through calm space and lower social intensity.',
      'profileEnergyBalanced':
          'Can enjoy both social activity and quiet recovery time.',
      'profileStructureStructured':
          'Feels safer with planning, clarity, and visible structure.',
      'profileStructureFlexible':
          'Prefers adaptability and keeping room for change.',
      'profileStructureBalanced':
          'Uses structure when needed without becoming rigid.',
      'profileEmotionAware':
          'Usually understands feelings and can express them clearly.',
      'profileEmotionGuarded':
          'May need more time to identify and verbalize emotions.',
      'profileEmotionGrowing':
          'Shows awareness, with room to deepen emotional clarity.',
      'profileConflictSteady':
          'Tends to slow conflict down and repair the connection.',
      'profileConflictReactive':
          'May react quickly under pressure before calming down.',
      'profileConflictDeveloping':
          'Shows mixed conflict habits and can improve with practice.',
      'dynamicEnergyAligned':
          'Their social pace is naturally close, so shared routines may feel easier.',
      'dynamicEnergyBridge':
          'Their social energy differs enough that they will need intentional balance.',
      'dynamicPlanningAligned':
          'They approach structure and planning at a similar pace.',
      'dynamicPlanningBridge':
          'Their planning style differs, so expectations should be negotiated early.',
      'dynamicRepairStrong':
          'Their conflict-repair capacity looks strong and protective for the relationship.',
      'dynamicRepairFragile':
          'Conflict repair looks fragile and needs conscious work before stress rises.',
      'dynamicRepairDeveloping':
          'Repair skills exist, but the relationship will benefit from clearer conflict habits.',
      'archetypePlanner': 'Planner',
      'archetypeFlexible': 'Flexible',
      'archetypeBalanced': 'Balanced',
      'archetypeWarmCommunicator': 'Warm Communicator',
      'archetypeReflectivePartner': 'Reflective Partner',
      'archetypeSteadyResponder': 'Steady Responder',
      'archetypeDirectProcessor': 'Direct Processor',
      'localOnly': 'Local prototype. Firebase can be connected later.',
    },
    'ar': {
      'appName': 'ميثاق 360',
      'tagline': 'توافق الزواج والاستشارات الأسرية',
      'startAssessment': 'ابدأ التقييم',
      'startUsage': 'ابدأ الاستخدام',
      'welcomeAccountEntry': 'سجل الدخول أو أنشئ حسابًا',
      'continueAssessment': 'استكمال التقييم',
      'settings': 'الإعدادات',
      'welcomeTitle': 'اتخذ قرار زواج أوضح',
      'welcomeBody':
          'قيّم الشخصية والمشاعر ونمط الحياة والتوقعات والحدود الأسرية قبل وبعد الزواج.',
      'homeTitle': 'اختر الميزة التي تريد فتحها',
      'homeBody':
          'ابدأ التقييم، وافتح الاختبار، وراجع آخر نتيجة، أو ادخل مباشرة إلى الحجز والإعدادات.',
      'quickAccess': 'وصول سريع',
      'featurePersonality': 'افتح أسئلة التوافق للشخصين',
      'featureResults': 'راجع آخر تقرير توافق تم حسابه',
      'featureCounseling': 'أرسل طلب حجز استشارة أو جلسة تأهيل',
      'featureResourcesToolsHub':
          'افتح المحتوى التوعوي والأدوات العملية من مكان منظم واحد',
      'featureEducationalHub':
          'اقرأ محتوى عملي قبل الزواج وأسئلة مهمة وعلامات تحذير',
      'featureRelationshipTools':
          'استخدم أدوات بسيطة للعناية والاهتمام والممارسة الأسبوعية',
      'featureGratitudeBank': 'احفظ ملاحظات امتنان قصيرة محليًا وراجعها لاحقًا',
      'featureBudgetPlanner':
          'تابع عناصر دخل ومصروفات بسيطة محليًا لتقليل غموض المال',
      'featureRemindersCenter':
          'خطط لتذكيرات صغيرة محليًا للمتابعة والامتنان ومراجعة المال',
      'featureGuidedMediator':
          'استخدم مسارًا محليًا موجهًا للخلاف لتهدئة التصعيد والخروج باتفاق عملي واحد',
      'featureScenarioLab':
          'قارن كيف يستجيب الطرفان لسيناريوهات ضغط واقعية بدون التأثير على نتيجة التوافق الأساسية',
      'featureProblemBox':
          'أرسل مشكلة خاصة عبر المسار المتصل مع إمكانية تمريرها إلى واتساب',
      'featureEmergencySupport':
          'افتح وسائل الدعم العاجل وراجع إرشادات الاستجابة الأولى مباشرة من الصفحة الرئيسية',
      'featureSettings': 'غيّر اللغة والمظهر وامسح البيانات المحفوظة',
      'account': 'الحساب',
      'accountTileBody':
          'تسجيل دخول متصل اختياري للميزات السحابية القادمة بدون التأثير على الاستخدام المحلي الحالي.',
      'accountIntroTitle': 'حالة تسجيل الدخول المتصل',
      'accountIntroBody':
          'هذه الشاشة تجهز دخولًا اختياريًا للحساب من أجل الميزات السحابية القادمة. ما زال يمكن استخدام التطبيق الحالي بدون تسجيل دخول.',
      'accountStatusTitle': 'حالة الحساب الحالية',
      'accountActionTitle': 'إجراء الحساب',
      'accountSignedOut': 'لا يوجد تسجيل دخول',
      'accountSignedInAs': 'تم تسجيل الدخول باسم',
      'accountEmail': 'البريد الإلكتروني',
      'accountPassword': 'كلمة المرور',
      'accountPasswordTooShort': 'يجب أن تكون كلمة المرور 6 أحرف على الأقل',
      'accountSignIn': 'تسجيل الدخول',
      'accountCreateAccount': 'إنشاء حساب',
      'accountSignOut': 'تسجيل الخروج',
      'invalidEmail': 'أدخل بريدًا إلكترونيًا صحيحًا',
      'connectedAuthDisabled':
          'تسجيل الدخول المتصل غير مفعّل في وضع التطبيق الحالي.',
      'accountSignInModeBody':
          'استخدم هذا الوضع للدخول بحساب موجود بدون تغيير أي مسار محلي شغال حاليًا.',
      'accountCreateModeBody':
          'استخدم هذا الوضع لإنشاء حساب جديد أولًا ثم دخول التطبيق مباشرة عند نجاح الإنشاء.',
      'signedIn': 'تم تسجيل الدخول بنجاح.',
      'accountCreated': 'تم إنشاء الحساب وتسجيل الدخول بنجاح.',
      'signedOut': 'تم تسجيل الخروج.',
      'signInFailed': 'تعذر تسجيل الدخول بالبيانات المدخلة.',
      'accountCreateFailed': 'تعذر إنشاء الحساب بهذه البيانات.',
      'accountEmailInUse': 'هذا البريد مستخدم بالفعل في حساب آخر.',
      'accountUserNotFound': 'لا يوجد حساب مرتبط بهذا البريد.',
      'accountWrongPassword': 'كلمة المرور غير صحيحة.',
      'accountInvalidCredential':
          'هذا البريد أو كلمة المرور غير مقبولين في Firebase Auth.',
      'accountTooManyRequests': 'تمت محاولات كثيرة. حاول مرة أخرى بعد قليل.',
      'problemBox': 'صندوق مشاكل خاص',
      'problemBoxTileBody':
          'أرسل مشكلة علاقة بشكل خاص عبر مسار الإرسال المتصل عند توفره.',
      'problemBoxIntroTitle': 'صندوق خاص للكتابة فقط',
      'problemBoxIntroBody':
          'استخدم هذه الشاشة لإرسال مشكلة علاقة بشكل خاص لمراجعتها لاحقًا. النسخة الأولى تُبقي هذا المسار منفصلًا عن كل بيانات التقييم والأدوات.',
      'problemBoxTopic': 'عنوان مختصر',
      'problemBoxDetails': 'التفاصيل',
      'problemBoxTooShort': 'اكتب وصفًا أوضح قليلًا أولًا.',
      'problemBoxSubmit': 'إرسال المشكلة',
      'problemBoxDisabled': 'الإرسال المتصل غير مفعّل في وضع التطبيق الحالي.',
      'problemBoxSubmitted': 'تم إرسال المشكلة للمراجعة.',
      'problemBoxPermissionDenied':
          'الإرسال مرفوض حاليًا بسبب قواعد Firestore الحالية.',
      'problemBoxUnavailable': 'خدمة صندوق المشاكل غير متاحة مؤقتًا.',
      'problemBoxSubmitFailed': 'تعذر إرسال المشكلة الآن.',
      'problemBoxWhatsappOpened': 'تم فتح واتساب برسالة المشكلة.',
      'emergencySupport': 'الدعم العاجل',
      'emergencySupportTileBody':
          'افتح وسائل دعم عاجلة سريعة وراجع إرشادات الاستجابة الأولى بدون تغيير أي بيانات تقييم محفوظة.',
      'emergencySupportIntroTitle': 'توجيه دعم فوري',
      'emergencySupportIntroBody':
          'استخدم هذه الشاشة عندما تحتاج إلى خطوة دعم سريعة. هي لا تطلق تصعيدًا آليًا ولا مراقبة خلفية ولا ترسل جهات طوارئ.',
      'emergencySupportQuickActionsTitle': 'إجراءات سريعة',
      'emergencySupportActionNote':
          'إذا لم يستطع الجهاز فتح الإجراء المحدد، فاستخدم خدمات الطوارئ المحلية أولًا عند وجود خطر جسدي فوري.',
      'partnerOffers': 'عروض الشركاء',
      'partnerOffersTileBody':
          'راجع عروض الشركاء المحلية وانسخ أي أكواد متاحة بدون التأثير على بياناتك المحفوظة الحالية.',
      'partnerOffersIntroTitle': 'عروض محلية فقط',
      'partnerOffersIntroBody':
          'هذه النسخة الأولى بسيطة عمدًا. هي تعرض عروضًا محلية للقراءة فقط مع ملاحظات الاستخدام حتى لا يعتمد التطبيق بعد على أي backend خاص بالشركاء.',
      'partnerOffersAvailableTitle': 'العروض المتاحة',
      'partnerOffersCodeLabel': 'كود الخصم',
      'partnerOffersClaimLabel': 'طريقة الاستخدام',
      'partnerOffersNotesLabel': 'ملاحظات',
      'partnerOffersCopyCode': 'انسخ الكود',
      'partnerOffersCopied': 'تم نسخ كود العرض.',
      'connectedFeatures': 'الميزات المتصلة',
      'connectedFeaturesTileBody':
          'راجع الميزات السحابية المؤجلة وما الذي ما زال كل جزء منها يحتاجه قبل التفعيل.',
      'connectedFeaturesIntroTitle': 'حالة البنية السحابية',
      'connectedFeaturesIntroBody':
          'هذه الميزات غير مفعلة عمدًا حتى الآن. هذه الشاشة تتابع طبقات الخلفية والخصوصية والتشغيل التي ما زالت مطلوبة قبل أي إطلاق متصل.',
      'connectedFeaturesLocalOnlyNote':
          'التطبيق الحالي ما زال يعمل محليًا أولًا. لا يوجد أي جزء من هذه الميزات مفعّل للمستخدم النهائي بعد.',
      'connectedFeaturesModeLabel': 'الوضع',
      'connectedFeaturesEnabledCountLabel': 'المفعّل',
      'connectedFeaturesGatedCountLabel': 'المقفول',
      'connectedFeaturesStatusLabel': 'الحالة الحالية',
      'connectedFeaturesRequirementsLabel': 'المطلوب قبل الإطلاق',
      'connectedFeaturesStatusPlanned': 'مرحلة معمارية مخططة',
      'connectedFeaturesStatusGated': 'مقفول بحسب وضع التطبيق الحالي',
      'connectedFeaturesStatusEnabled': 'مفعّل عبر البوابة',
      'backendModeLocalOnly': 'وضع محلي فقط',
      'backendModeConnectedPreview': 'وضع معاينة متصل',
      'backendModeConnectedLive': 'وضع متصل حي',
      'connectedRequirementAuth': 'هوية المستخدم',
      'connectedRequirementBackendApi': 'واجهة خلفية',
      'connectedRequirementPrivacyConsent': 'الخصوصية والموافقة',
      'connectedRequirementModeration': 'قواعد المراجعة',
      'connectedRequirementExpertOperations': 'تشغيل الخبراء',
      'connectedRequirementSafetyRouting': 'توجيه السلامة',
      'connectedRequirementPartnerOperations': 'تشغيل الشركاء',
      'educationalHub': 'المكتبة التوعوية',
      'resourcesToolsHub': 'المحتوى والأدوات',
      'relationshipTools': 'أدوات العلاقة',
      'guidedMediator': 'الوسيط الموجه',
      'scenarioLab': 'مختبر السيناريوهات',
      'gratitudeBank': 'حصالة الامتنان',
      'budgetPlanner': 'مخطط الميزانية',
      'remindersCenter': 'مركز التذكيرات',
      'toolsOverviewTitle': 'ملخص محفوظ',
      'toolsOverviewBody':
          'قراءة سريعة للعناصر المحلية المحفوظة بالفعل داخل الأدوات العملية.',
      'toolsOverviewSavedItems': 'عناصر محفوظة',
      'toolsOverviewSavedPlans': 'خطط محفوظة',
      'toolsOverviewLatestNote': 'أحدث ملاحظة امتنان',
      'toolsOverviewNoData': 'لا توجد بيانات محلية محفوظة بعد.',
      'educationalHubOverviewTitle': 'نظرة سريعة',
      'educationalHubOverviewBody':
          'افتح المجموعة المناسبة أسرع عبر قراءة الملامح الرئيسية للمحتوى التوعوي أولًا.',
      'educationalHubGuideHelper':
          'بطاقات عملية قصيرة لنقاشات ما قبل الزواج بشكل أهدأ',
      'relationshipToolsOverviewTitle': 'نظرة سريعة',
      'relationshipToolsOverviewBody':
          'استخدم هذه الاختصارات للوصول أسرع إلى القسم الذي تريده داخل شاشة أدوات العلاقة.',
      'relationshipToolsOverviewUsage':
          '3 قواعد قصيرة لتبقى الأدوات عملية وواقعية',
      'gratitudeBankOverviewTitle': 'نظرة سريعة',
      'gratitudeBankOverviewBody':
          'ابدأ بالملخص ثم انتقل مباشرة إلى كتابة الملاحظة أو مراجعة الملاحظات المحفوظة.',
      'gratitudeBankOverviewActionHelper': 'انتقل مباشرة إلى قسم الكتابة',
      'gratitudeBankOverviewLatestTitle': 'آخر ملاحظة محفوظة',
      'gratitudeBankSummaryTitle': 'ملخص شهري',
      'gratitudeBankSummaryBody':
          'قراءة صغيرة للاستمرارية حتى لا يبقى الامتنان فكرة عامة فقط.',
      'gratitudeBankSummaryTotalLabel': 'إجمالي الملاحظات المحفوظة',
      'gratitudeBankSummaryMonthLabel': 'ملاحظات هذا الشهر',
      'gratitudeBankSummaryLatestLabel': 'أحدث تاريخ حفظ',
      'gratitudeBankSummaryNoDate': 'لا يوجد تاريخ حفظ بعد',
      'budgetPlannerOverviewTitle': 'نظرة سريعة',
      'budgetPlannerOverviewBody':
          'ابدأ بالقراءة السريعة ثم انتقل مباشرة إلى الملخص أو قسم الإضافة أو البنود المحفوظة.',
      'budgetPlannerOverviewSummaryHelper': 'انتقل مباشرة إلى قسم ملخص المال',
      'budgetPlannerOverviewActionHelper': 'انتقل مباشرة إلى نموذج الإدخال',
      'budgetPlannerOverviewEntriesHelper':
          'انتقل مباشرة إلى قسم البنود المحفوظة',
      'budgetPlannerOverviewLatestTitle': 'آخر بند محفوظ',
      'budgetPlannerSmartSummaryTitle': 'ملخص أذكى',
      'budgetPlannerSmartSummaryBody':
          'استخدم هذه الإشارات لمعرفة أين يتركز ضغط المال بدل قراءة الإجماليات فقط.',
      'budgetPlannerSmartSummaryMonthLabel': 'بنود هذا الشهر',
      'budgetPlannerSmartSummaryTopCategoryLabel': 'أكثر فئة مصروفات',
      'budgetPlannerSmartSummaryTopAmountLabel': 'قيمة الفئة الأعلى',
      'budgetPlannerSmartSummaryNoCategory': 'لا توجد فئة مصروفات بعد',
      'remindersCenterOverviewTitle': 'نظرة سريعة',
      'remindersCenterOverviewBody':
          'ابدأ بالقراءة السريعة ثم انتقل مباشرة إلى كتابة الخطة أو مراجعة خطط التذكير المحفوظة.',
      'remindersCenterOverviewActionHelper': 'انتقل مباشرة إلى نموذج التذكير',
      'remindersCenterOverviewLatestTitle': 'آخر خطة تذكير محفوظة',
      'remindersCenterSmartSummaryTitle': 'ملخص أذكى',
      'remindersCenterSmartSummaryBody':
          'استخدم هذه الإشارات لترى هل خطط التذكير مركزة أم مشتتة قبل تحويلها إلى إشعارات حقيقية.',
      'remindersCenterSmartSummaryMonthLabel': 'خطط هذا الشهر',
      'remindersCenterSmartSummaryCategoriesLabel': 'التصنيفات المستخدمة',
      'remindersCenterSmartSummaryTopCategoryLabel': 'أكثر تصنيف متكرر',
      'remindersCenterSmartSummaryNoCategory': 'لا يوجد تصنيف مستخدم بعد',
      'bookingHistoryOverviewTitle': 'نظرة سريعة',
      'bookingHistoryOverviewBody':
          'ابدأ بهذا الملخص لمراجعة عدد طلبات الحجز وحالة آخر طلب داخل السجل الحالي.',
      'bookingHistoryOverviewCountHelper': 'إجمالي طلبات الحجز المحفوظة محليًا',
      'bookingHistoryOverviewStatusHelper':
          'آخر نتيجة إرسال حسب ترتيب السجل الحالي',
      'bookingHistoryOverviewLatestTitle': 'ملخص آخر حجز',
      'useLatestBooking': 'استخدم بيانات آخر حجز',
      'latestBookingApplied': 'تم تطبيق بيانات آخر حجز على النموذج.',
      'startNewBooking': 'ابدأ حجزًا جديدًا',
      'resourcesToolsHubIntroTitle':
          'مكان واحد للمحتوى والأدوات التي أُضيفت لاحقًا',
      'resourcesToolsHubIntroBody':
          'هذه الشاشة تُبقي الصفحة الرئيسية مركزة على المسار الأساسي، وتجمع المحتوى والأدوات المساندة بشكل أوضح وأسهل.',
      'resourcesToolsHubContentSection': 'محتوى للقراءة ودعم النقاش',
      'resourcesToolsHubToolsSection': 'أدوات عملية للمتابعة',
      'educationalHubIntroTitle': 'طبقة قراءة أهدأ حول النتيجة',
      'educationalHubIntroBody':
          'هذا القسم لا يغيّر نتيجة التوافق نفسها، لكنه يساعد الطرفين على تحويل النتيجة إلى نقاش أوضح وحكم أهدأ قبل الالتزام.',
      'educationalHubCollections': 'المجموعات',
      'premaritalGuide': 'دليل قبل الزواج',
      'goldenQuestions': 'الأسئلة الذهبية',
      'goldenQuestionsSubtitle': 'أسئلة منظمة تكشف الافتراضات الخفية مبكرًا',
      'goldenQuestionsIntroTitle': 'اسأل الأسئلة الصعبة قبل ضغط الواقع',
      'goldenQuestionsIntroBody':
          'هذه الأسئلة مفيدة لأنها تكشف العادات والافتراضات وتوقعات المستقبل. الهدف ليس إبهار الطرف الآخر، بل تقليل الغموض قدر الإمكان.',
      'redFlags': 'العلامات الحمراء',
      'redFlagsSubtitle': 'علامات تحذير متكررة لا يصح التقليل منها',
      'redFlagsIntroTitle': 'علامات التحذير تحتاج تسمية مباشرة',
      'redFlagsIntroBody':
          'العلامة الحمراء لا تعني بالضرورة أن كل علاقة يجب أن تنتهي فورًا، لكنها تعني أن النمط لا ينبغي تبريره أو تجميله أو تركه غامضًا.',
      'rightsAndDuties': 'الحقوق والمسؤوليات',
      'rightsAndDutiesSubtitle':
          'طبقة توعية عملية حول العدل والحدود ووقت طلب الدعم',
      'rightsAndDutiesIntroTitle':
          'استخدم الوضوح مبكرًا قبل أن يتحول الخلاف إلى نمط مزمن',
      'rightsAndDutiesIntroBody':
          'هذا القسم ليس تمثيلًا قانونيًا، لكنه يساعد الطرفين على تحويل التوقعات الغامضة إلى نقاط نقاش واضحة حول الاحترام والعدل والخصوصية ومتى تكون الحاجة إلى دعم خارجي ضرورية.',
      'inLawsGuide': 'دليل التعامل مع الأهل',
      'inLawsGuideSubtitle': 'إرشاد عملي للحدود والتدخلات الأسرية المتكررة',
      'inLawsGuideIntroTitle':
          'تعاملوا مع ضغط الأهل قبل أن يشكل الزواج بدلًا من دعمه',
      'inLawsGuideIntroBody':
          'يركز هذا الدليل على أنماط الاحتكاك الأسري المتكرر: ما الذي ينبغي أن يبقى داخل دائرة الزوجين، وكيفية الرد الهادئ على التدخل، ومتى تصبح الحاجة إلى حدود أوضح أو استشارة أسرية ضرورية.',
      'marriageReadinessCard': 'بطاقة جاهزية الزواج',
      'marriageReadinessSubtitle': 'مراجعة عملية قبل أي التزام سريع',
      'marriageReadinessIntroTitle':
          'ينبغي فحص الجاهزية قبل أن تصبح الوعود أثقل',
      'marriageReadinessIntroBody':
          'يساعد هذا القسم على تحويل جاهزية الزواج إلى نقاط مراجعة عملية حول الوعي بالذات، وعادات الضغط، والمسؤولية، وإيقاع اتخاذ القرار.',
      'heritageAwareness': 'التراث والوعي الأسري',
      'heritageAwarenessSubtitle': 'اقرأ الموروث بعدسة عملية',
      'heritageAwarenessIntroTitle':
          'استخدم الثقافة لدعم الأسرة لا لتبرير الأذى',
      'heritageAwarenessIntroBody':
          'يعيد هذا القسم قراءة الأقوال الموروثة والقصص العائلية بعدسة عملية: نحتفظ بما يقوي الرحمة والمسؤولية، ونراجع ما يطبع الأذى أو الهيمنة.',
      'relationshipToolsIntroTitle': 'أدوات صغيرة لاتصال أكثر ثباتًا',
      'relationshipToolsIntroBody':
          'هذه الأدوات بسيطة عن قصد. لا تشخّص العلاقة، لكنها تساعد الطرفين على تحويل الاهتمام إلى أفعال واضحة ومتكررة.',
      'loveLanguagesTitle': 'دليل سريع للغات الحب',
      'loveLanguagesBody':
          'استخدم هذا القسم كعدسة عملية لا كتصنيف جامد. السؤال المفيد هنا هو: أي نوع من الاهتمام يشعر به الطرف الآخر فعلًا؟',
      'loveLanguagesQuizTitle': 'اختبار مصغر للغات الحب',
      'loveLanguagesQuizBody':
          'أجب عن هذه المواقف القصيرة أولًا، ثم استخدم النتيجة المحفوظة كبداية للنقاش لا كحكم نهائي.',
      'loveLanguagesQuizLatestTitle': 'أحدث نتيجة محفوظة',
      'loveLanguagesQuizPrimaryLabel': 'اللغة الأبرز',
      'loveLanguagesQuizSaveAction': 'حفظ نتيجة الاختبار',
      'loveLanguagesQuizIncomplete':
          'أجب عن كل أسئلة الاختبار قبل حفظ النتيجة.',
      'loveLanguagesQuizSaved': 'تم حفظ نتيجة لغة الحب محليًا.',
      'weeklyChallengesTitle': 'تحديات أسبوعية للتقارب',
      'weeklyChallengesBody':
          'اختر تحديًا واحدًا في كل مرة. اجعله محددًا وقابلًا للتكرار بدل تحويله إلى أداء شكلي.',
      'weeklyChallengesChecklistTitle': 'قائمة المتابعة الأسبوعية',
      'weeklyChallengesChecklistBody':
          'ضع علامة عند تنفيذ التحدي فعلًا. الهدف هو الاستمرار العملي لا جمع نوايا مثالية.',
      'weeklyChallengesProgressTitle': 'المنجز في هذه الدورة',
      'weeklyChallengesProgressCount': 'تم تحديد {current} من {total} تحديات',
      'relationshipToolsUsageTitle': 'كيف تُستخدم هذه الأدوات بشكل جيد',
      'relationshipToolsUsagePoint1':
          'ابدأ بأصغر فعل مفيد بدل الوعد بتغيير الشخصية بالكامل.',
      'relationshipToolsUsagePoint2':
          'إذا بدت أداة ما غير طبيعية، فناقش سبب ذلك قبل اعتبارها فشلًا.',
      'relationshipToolsUsagePoint3':
          'التكرار يبني الثقة. الاهتمام الصغير المستمر أنفع من الجهد الكبير النادر.',
      'guidedMediatorIntroTitle': 'دليل محلي للخلاف وليس وساطة مباشرة',
      'guidedMediatorIntroBody':
          'هذه الأداة لا تستخدم محادثة ذكاء اصطناعي ولا متابعة حية من مختص. هي فقط تعطيكم طريقة منظمة لتهدئة نقاش متوتر والخروج باتفاق واحد قابل للتنفيذ.',
      'guidedMediatorTracksTitle': 'اختر نوع التوتر الحالي',
      'guidedMediatorTracksBody':
          'ابدأ باختيار أقرب نمط للخلاف. الخطة بالأسفل ستكيّف الأسئلة والخطوة التالية حسب هذا النمط.',
      'guidedMediatorPlanTitle': 'مسار وساطة مقترح',
      'guidedMediatorPauseLabel': 'توقف أولًا',
      'guidedMediatorPersonALabel': 'يقول الطرف الأول',
      'guidedMediatorPersonBLabel': 'يقول الطرف الثاني',
      'guidedMediatorAgreementLabel': 'اختموا باتفاق واحد',
      'guidedMediatorEscalationLabel': 'متى تنتقلون إلى الاستشارة',
      'guidedMediatorLocalNoteTitle': 'الحد الحالي',
      'guidedMediatorLocalNoteBody':
          'هذا دليل محلي مبني على قواعد ثابتة فقط. هو لا يحفظ الخلاف ولا يرسله إلى السحابة ولا يغني عن دعم السلامة المباشر عندما يكون الموقف خطيرًا.',
      'scenarioLabIntroTitle': 'اختبروا التوافق عبر مواقف واقعية',
      'scenarioLabIntroBody':
          'هذا المختبر منفصل عن نتيجة التوافق الأساسية. هو مساحة أكثر أمانًا لمقارنة ردود الفعل تحت الضغط قبل أن تحدث هذه المواقف فعليًا.',
      'scenarioLabSummaryTitle': 'رادار التوافق',
      'scenarioLabSummaryBody':
          'هذا الرادار السريع يقرأ التوافق داخل السيناريوهات فقط. استخدموه لمعرفة أين تتشابه الغرائز وأين ما زال الاتفاق الصريح مطلوبًا.',
      'scenarioLabAnsweredLabel': 'السيناريوهات المجابة',
      'scenarioLabAlignedLabel': 'توافق قوي',
      'scenarioLabCloseLabel': 'تقارب غير متطابق',
      'scenarioLabGapLabel': 'فجوة ظاهرة',
      'scenarioLabRecommendationsTitle': 'توصيات للنقاش',
      'scenarioLabRecommendationsBody':
          'استخدموا هذه النقاط كقائمة للنقاش القادم. ابدؤوا بالفجوات الواضحة أولًا، ثم حددوا شكل الاتفاق العملي في السيناريوهات المتقاربة.',
      'scenarioLabRecommendationGapLabel': 'يناقش أولًا',
      'scenarioLabRecommendationCloseLabel': 'يحتاج توضيحًا',
      'scenarioLabRecommendationGapHint':
          'الفرق هنا واضح بما يكفي ليحتاج اتفاقًا مباشرًا قبل أن تزيد الضغوط.',
      'scenarioLabRecommendationCloseHint':
          'الاتجاه متقارب، لكن الطريقة المفضلة ما زالت تحتاج اتفاقًا محددًا.',
      'scenarioLabUserALabel': 'اختيار الشخص الأول',
      'scenarioLabUserBLabel': 'اختيار الشخص الثاني',
      'scenarioLabFocusLabel': 'محور القراءة',
      'gratitudeBankIntroTitle': 'ذاكرة بسيطة لما سار بشكل جيد',
      'gratitudeBankIntroBody':
          'هذه الأداة تحفظ ملاحظات امتنان قصيرة محليًا على الجهاز. الهدف هو الاحتفاظ بأثر واضح للاهتمام بدل الاعتماد على الذاكرة وحدها وقت التوتر.',
      'gratitudeBankAddTitle': 'أضف ملاحظة جديدة',
      'gratitudeBankPrompt':
          'اكتب شيئًا قصيرًا تشعر بالامتنان له. اجعله محددًا وواضحًا.',
      'gratitudeBankHint': 'مثال: قدّرت هدوءك في التعامل مع ضغط اليوم.',
      'gratitudeBankTooShort': 'اكتب ملاحظة امتنان أوضح قليلًا.',
      'gratitudeBankSaveAction': 'حفظ الملاحظة',
      'gratitudeBankSavedTitle': 'الملاحظات المحفوظة',
      'gratitudeBankEmpty':
          'لا توجد ملاحظات امتنان بعد. أضف أول ملاحظة عندما يحدث شيء صغير لكنه يستحق التذكر.',
      'budgetPlannerIntroTitle': 'أداة بسيطة لوضوح المال',
      'budgetPlannerIntroBody':
          'هذه الأداة خفيفة عن قصد. هدفها أن تجعل النقاش حول المال أوضح عبر تسجيل عدد محدود من البنود محليًا على الجهاز.',
      'budgetPlannerSummaryTitle': 'الملخص الحالي',
      'budgetPlannerAddTitle': 'أضف بندًا جديدًا',
      'budgetPlannerEntriesTitle': 'البنود المحفوظة',
      'budgetPlannerEmpty':
          'لا توجد بنود ميزانية بعد. أضف أول بند دخل أو مصروف لبدء صورة أوضح عن المال.',
      'budgetTitle': 'عنوان البند',
      'budgetAmount': 'المبلغ',
      'budgetType': 'النوع',
      'budgetCategory': 'التصنيف',
      'budgetIncome': 'دخل',
      'budgetExpense': 'مصروف',
      'budgetBalance': 'الرصيد',
      'budgetAmountInvalid': 'أدخل مبلغًا صحيحًا أكبر من صفر',
      'budgetSaveAction': 'حفظ البند',
      'remindersCenterIntroTitle': 'مخطط محلي للتذكيرات',
      'remindersCenterIntroBody':
          'استخدم هذه الشاشة لتخطيط تذكيرات صغيرة متكررة تساعد على روتين أهدأ ومتابعة أوضح.',
      'remindersCenterLocalOnlyNote':
          'هذه المرحلة تحفظ خطط التذكير محليًا فقط، ولا ترسل إشعارات فعلية للنظام بعد.',
      'remindersCenterNotificationNote':
          'يمكن الآن لخطط التذكير الجديدة أن تفعّل إشعارات حقيقية على الجهاز عبر جدول يومي أو أسبوعي منظم.',
      'remindersCenterAddTitle': 'أضف خطة تذكير',
      'remindersCenterSavedTitle': 'خطط التذكير المحفوظة',
      'remindersCenterEmpty':
          'لا توجد خطط تذكير بعد. أضف خطة بسيطة بدل محاولة تذكر كل شيء ذهنيًا.',
      'reminderTitle': 'عنوان التذكير',
      'reminderCategory': 'تصنيف التذكير',
      'reminderCategoryCheckIn': 'متابعة العلاقة',
      'reminderCategoryGratitude': 'تذكير بالامتنان',
      'reminderCategoryBudget': 'مراجعة الميزانية',
      'reminderCategoryCustom': 'تذكير مخصص',
      'reminderScheduleLabel': 'وصف الموعد',
      'reminderScheduleHint': 'مثال: كل جمعة الساعة 8:00 مساءً',
      'reminderScheduleType': 'نوع الجدول',
      'reminderScheduleDaily': 'يومي',
      'reminderScheduleWeekly': 'أسبوعي',
      'reminderWeekday': 'اليوم',
      'reminderPickTime': 'اختر وقت التذكير',
      'reminderSelectedTime': 'الوقت المختار',
      'reminderNotificationScheduled':
          'تم حفظ التذكير وجدولته كإشعار حقيقي على الجهاز.',
      'reminderNotificationSavedLocalOnly':
          'تم حفظ التذكير محليًا، لكن لم يتم منح إذن الإشعارات.',
      'monday': 'الاثنين',
      'tuesday': 'الثلاثاء',
      'wednesday': 'الأربعاء',
      'thursday': 'الخميس',
      'friday': 'الجمعة',
      'saturday': 'السبت',
      'sunday': 'الأحد',
      'reminderNote': 'ملاحظة اختيارية',
      'reminderSaveAction': 'حفظ خطة التذكير',
      'delete': 'حذف',
      'assessmentStatus': 'حالة التقييم',
      'latestBooking': 'آخر طلب حجز',
      'bookingHistory': 'سجل الحجوزات',
      'bookingHistoryEmpty': 'لا يوجد سجل حجوزات حتى الآن.',
      'noBookingYet': 'لا يوجد طلب حجز محفوظ حتى الآن.',
      'bookingDate': 'الموعد المفضل',
      'bookingType': 'نوع الجلسة',
      'bookingPhone': 'الهاتف',
      'bookingMessage': 'الرسالة',
      'clinicPhone': 'رقم العيادة',
      'bookingStatus': 'حالة الإرسال',
      'bookingRecommendation': 'سبب التوصية',
      'bookingResultVerdict': 'الحكم العام للنتيجة',
      'recommendedSessionTitle': 'الجلسة الموصى بها من نتيجتك',
      'bookRecommendedSession': 'احجز الجلسة الموصى بها',
      'saveAsPdf': 'حفظ كملف PDF',
      'generatedAt': 'تاريخ التصدير',
      'pdfOpeningOptions': 'جارٍ فتح خيارات ملف PDF...',
      'pdfReadyTitle': 'خيارات ملف PDF',
      'pdfPreparing': 'جارٍ تجهيز ملف PDF...',
      'pdfSaveAction': 'حفظ أو مشاركة ملف PDF',
      'pdfPrintAction': 'طباعة ملف PDF',
      'pdfExportReady': 'ملف الـ PDF جاهز للمشاركة أو الحفظ.',
      'pdfActionFailed': 'تعذر تنفيذ إجراء ملف PDF على هذا الجهاز.',
      'pdfExportFailed': 'تعذر تجهيز ملف PDF للنتيجة.',
      'recommendedReasonIndividual':
          'النتيجة الحالية تشير إلى أن الجاهزية الفردية تحتاج مراجعة أعمق قبل أي التزام سريع.',
      'recommendedReasonFamily':
          'النتيجة الحالية تشير إلى ضغط في الحدود الأسرية، وهذا يناسب جلسة استشارة أسرية أكثر.',
      'recommendedReasonPlanning':
          'النتيجة الحالية تشير إلى فجوات في التوقعات والتخطيط، وهذا يناسب جلسة تأهيل أو تدريب أكثر.',
      'recommendedReasonCommunication':
          'النتيجة الحالية تظهر ضغطًا في التواصل، وسيستفيد من جلسة حوار موجهة.',
      'recommendedReasonAlignment':
          'النتيجة الحالية تحتاج أساسًا إلى جلسة واحدة مركزة لتثبيت التوقعات بوضوح.',
      'viewBookingDetails': 'عرض تفاصيل الحجز',
      'viewBookingHistory': 'عرض سجل الحجوزات',
      'createdAt': 'تاريخ الإنشاء',
      'questionnaire': 'الاستبيان',
      'questionnaireProgress': 'تقدم الاستبيان',
      'scaleHint': '1 = موافقة منخفضة، 5 = موافقة عالية',
      'personalityIntro':
          'هذه النسخة تعتمد على مواقف سلوكية وحدود أوضح للإجابة بدل التقييمات العامة التقليدية.',
      'selectClosestAnswer': 'اختر الإجابة الأقرب لطبيعتك',
      'personalityOnboardingTitle': 'رحلة شخصية أعمق',
      'personalityOnboardingBody':
          'هذا الاختبار مبني كرحلة على مراحل. يقرأ أسلوب الشخصية والإيقاع العاطفي وعادات الخلاف ونقاط الضغط المستقبلية بدل جمع تقييمات سطحية فقط.',
      'personalityOnboardingStagesTitle': 'تدفق على مراحل',
      'personalityOnboardingStagesBody':
          'ستتحرك بين بطاقات مركزة بدل صفحة طويلة واحدة، بحيث يكون لكل جزء موضوع وإيقاع واضح.',
      'personalityOnboardingAdaptiveTitle': 'تفرع ذكي',
      'personalityOnboardingAdaptiveBody':
          'بعض المراحل اللاحقة تظهر فقط عندما تكشف الإجابات عن توتر أو ضغط أو اختلاف يستحق قراءة أعمق.',
      'personalityOnboardingArchetypeTitle': 'ملخص النمط',
      'personalityOnboardingArchetypeBody':
          'في النهاية يحصل كل طرف على نمط واضح وتظهر ديناميكية العلاقة بصورة أقرب للحقيقة.',
      'startPersonalityJourney': 'ابدأ رحلة الشخصية',
      'resumePersonalityJourney': 'استكمل رحلة الشخصية',
      'restartPersonalityJourney': 'ابدأ من البداية',
      'stageProgress': 'تقدم المراحل',
      'questionProgress': 'تقدم الأسئلة',
      'questionOfStage': 'السؤال {current} من {total}',
      'answerBothUsersPrompt':
          'أجب عن السؤال للطرفين حتى تتحرك داخل المرحلة بشكل واضح.',
      'questionAwaitingAnswer':
          'هذا السؤال ما زال ينتظر إجابة أحد الطرفين أو كليهما.',
      'questionReadyToAdvance': 'تمت الإجابتان، ويمكنك المتابعة.',
      'previousStage': 'السابق',
      'nextStage': 'التالي',
      'previousQuestion': 'السؤال السابق',
      'nextQuestion': 'السؤال التالي',
      'continueToNextStage': 'المرحلة التالية',
      'reviewPreviousStage': 'المرحلة السابقة',
      'stageComplete': 'هذه المرحلة مكتملة',
      'stageInsight': 'قراءة المرحلة',
      'stageInsightPrompt':
          'هذه المرحلة تكشف كيف يتعامل الطرفان مع هذا الجانب من الزواج على أرض الواقع.',
      'stageInsightStrong':
          'الإجابات هنا توحي بإيقاع مستقر نسبيًا بين الطرفين.',
      'stageInsightGap':
          'يوجد فرق واضح هنا. ليس بالضرورة خطرًا، لكنه يحتاج اتفاقًا صريحًا.',
      'stageInsightMixed':
          'هذا الجانب فيه توافق جزئي، والنقاش القادم أهم من الدرجة وحدها.',
      'midJourneyInsightTitle': 'ما الذي يظهر حتى الآن',
      'midJourneyStrong':
          'عبر {stages}، توحي الإجابات حتى الآن بإيقاع متقارب وطبيعي بين الطرفين.',
      'midJourneyGap':
          'عبر {stages}، يظهر فرق واضح يحتاج إلى نقاش مباشر وصريح.',
      'midJourneyMixed':
          'عبر {stages}، يوجد توافق جزئي مع بعض النقاط التي تحتاج توقعات أوضح.',
      'midJourneyContinue': 'استكمل الرحلة',
      'adaptiveFocusTitle': 'تركيز متكيف',
      'adaptiveStagePlanning': 'التخطيط وقت التغيير',
      'adaptiveStageAnger': 'التحكم في التصعيد',
      'adaptiveStageFamily': 'التعامل مع ضغط العائلة',
      'adaptiveStageCareer': 'موازنة العمل والأسرة',
      'categoryAnalysis': 'تحليل الفئات',
      'completeQuestionnaire': 'أكمل كل الأسئلة للشخصين أولاً',
      'answeredQuestions': 'الأسئلة المجابة',
      'relationshipDynamics': 'ديناميكية العلاقة',
      'personalityProfile': 'الملف الشخصي',
      'archetypeSummary': 'ملخص النمط',
      'narrativeSummary': 'الملخص السردي',
      'personalityMap': 'الخريطة البصرية للشخصية',
      'comparisonLens': 'عدسة المقارنة',
      'keyTakeaways': 'أهم الخلاصات',
      'relationshipPulse': 'نبض العلاقة',
      'watchpoint': 'نقطة تحتاج انتباه',
      'advantage': 'نقطة تفوق',
      'nextStepTitle': 'الخطوة الموصى بها',
      'discussionTopicsTitle': 'موضوعات يجب مناقشتها قبل الارتباط',
      'conversationPrepTitle': 'التحضير للنقاش',
      'decisionCheckpointTitle': 'نقطة فحص القرار',
      'decisionCheckpointSlow':
          'النتيجة الحالية تستدعي تهدئة القرار. لا تتعامل مع الانجذاب وحده باعتباره كافيًا قبل مراجعة نقاط الضغط الأساسية.',
      'decisionCheckpointDiscuss':
          'النتيجة قابلة للبناء عليها، لكن بشرط أن تتحول الموضوعات غير المحسومة إلى نقاش مباشر واتفاقات صريحة.',
      'decisionCheckpointStable':
          'النتيجة تبدو مستقرة بما يكفي لنقاش نهائي مركز. المطلوب الآن هو تثبيت التوقعات بوضوح لا البحث عن خلافات مخفية.',
      'discussionChecklistTitle': 'قائمة فحص قبل القرار النهائي',
      'discussionChecklistCompatibility':
          'حددوا أكبر فرق ظاهر في النتيجة واتفقوا على سلوك يومي يجعل هذا الفرق قابلًا للإدارة.',
      'discussionChecklistReadiness':
          'وضّحوا ما الذي ما زال يحتاج نموًا شخصيًا قبل أن يعتبر أي طرف العلاقة جاهزة لالتزام كامل.',
      'discussionChecklistExpectations':
          'حوّلوا أهم التوقعات إلى صياغة مباشرة بدل افتراض أنها مفهومة ضمنًا.',
      'conversationGroundRulesTitle': 'قواعد للنقاش القادم',
      'conversationGroundRule1':
          'ناقشوا نقطة ضغط واحدة في كل مرة، واطلبوا أمثلة واقعية لا إجابات مثالية.',
      'conversationGroundRule2':
          'إذا كرر نفس الموضوع دفاعية أو مراوغة، فاعتبروا ذلك معلومة مهمة بدل استعجال الخلاصة.',
      'conversationGroundRule3':
          'اختموا النقاش باتفاق صريح واحد، وسؤال مفتوح واحد، وخطوة تالية واحدة.',
      'retakeLater': 'راجع الإجابات مرة أخرى',
      'nextStepCounselorFirst':
          'من الأفضل أن تسبق جلسة إرشاد متخصصة أي قرار ارتباط سريع.',
      'nextStepGuidedDiscussion':
          'اعقدا نقاشًا منظمًا حول نقاط الضغط الأساسية قبل التقدم للخطوة التالية.',
      'nextStepAlignment':
          'يكفي حوار واحد مركز قبل الزواج لتثبيت التوقعات والحفاظ على الانسجام الحالي.',
      'topicConflictRepair': 'كيف يهدئ كل طرف الخلاف ويصلح الثقة بعد التوتر.',
      'topicFamilyBoundaries': 'كيف سيتم وضع الحدود مع العائلتين وحمايتها.',
      'topicMoneyPlanning':
          'كيف ستدار الميزانية والادخار والإنفاق اليومي بشكل مشترك.',
      'topicFutureTiming':
          'كيف سيتم التفاوض حول الأطفال والعمل وتوقيت الأولويات.',
      'topicCommunicationRhythm':
          'كم يحتاج كل طرف من المتابعة العاطفية والحوار المباشر.',
      'topicHouseholdResponsibility':
          'كيف ستقسم الوعود والأدوار والمسؤوليات اليومية بعدل.',
      'comparisonClose': 'الطرفان متقاربان هنا.',
      'comparisonGapLight':
          'هذا الفرق يبدو قابلًا للإدارة، وقد يكون مكملًا للعلاقة.',
      'comparisonGapStrong':
          'هذا الفرق واضح بما يكفي ليحتاج اتفاقًا صريحًا قبل زيادة الضغوط.',
      'leanEnergyHigh': 'يميل أكثر للاجتماعية والطاقة الخارجية',
      'leanEnergyLow': 'يميل أكثر للهدوء واستعادة الطاقة داخليًا',
      'leanStructureHigh': 'يميل أكثر للنظام والتخطيط',
      'leanStructureLow': 'يميل أكثر للمرونة وترك الأمور مفتوحة',
      'leanEmotionHigh': 'لديه وضوح أعلى في تسمية المشاعر والتعبير عنها',
      'leanEmotionLow': 'يحتاج وقتًا أكبر لفهم المشاعر والتعبير عنها',
      'leanConflictHigh': 'أكثر ثباتًا وقت الخلاف',
      'leanConflictLow': 'أسرع في رد الفعل تحت الضغط',
      'heroSummaryLead': 'القراءة العامة',
      'mapEnergy': 'أسلوب الطاقة',
      'mapStructure': 'أسلوب النظام',
      'mapEmotion': 'الوضوح العاطفي',
      'mapConflict': 'تنظيم الخلاف',
      'narrativeCompatibilityHigh':
          'النمط العام يشير إلى توافق قوي مع قاعدة مستقرة نسبيًا للزواج.',
      'narrativeCompatibilityMid':
          'العلاقة تبدو قابلة للاستمرار، مع نقاط قوة واضحة وبعض المساحات التي تحتاج اتفاقًا مقصودًا.',
      'narrativeCompatibilityLow':
          'النمط الحالي يشير إلى توافق هش ويحتاج إلى نقاش أهدأ وأكثر تنظيمًا.',
      'narrativeReadinessHigh':
          'جاهزية الزواج أيضًا قوية، وهذا يوحي بقدرة معقولة على حمل المسؤولية بثبات.',
      'narrativeReadinessMid':
          'جاهزية الزواج متوسطة، لذلك قد تستفيد العلاقة من قدر إضافي من التحضير قبل القرار النهائي.',
      'narrativeReadinessLow':
          'جاهزية الزواج أقل من النطاق الآمن نسبيًا، لذلك يجب مراجعة نقاط الضغط قبل الالتزام.',
      'narrativeArchetypeLead': 'النمط الحالي لكل طرف يظهر كالتالي',
      'narrativeDynamicLead': 'وعمليًا، تميل العلاقة إلى إظهار',
      'narrativeRiskLead': 'أهم نقطة ضغط حاليًا هي',
      'narrativeStrengthLead': 'أوضح نقطة قوة حاليًا هي',
      'narrativeSupportLead':
          'محادثة موجهة حول هذه الأنماط سترفع موثوقية النتيجة وتوضح القرار أكثر.',
      'verdictTitle': 'الحكم العام على العلاقة',
      'verdictStrong': 'قاعدة قوية',
      'verdictWorkable': 'واعدة مع نقاش',
      'verdictFragile': 'تحتاج نقاشًا أهدأ',
      'verdictStrongBody':
          'العلاقة تظهر قاعدة جيدة، والفروق الحالية تبدو قابلة للإدارة إذا ظلت التوقعات واضحة.',
      'verdictWorkableBody':
          'العلاقة لديها قابلية حقيقية، لكن توجد أنماط يجب مناقشتها قبل أن تصبح القرارات أكبر.',
      'verdictFragileBody':
          'النمط الحالي يحتاج نقاشًا أهدأ وأكثر تنظيمًا قبل التزام مطمئن.',
      'whatToDiscussNow': 'ما الذي يجب مناقشته الآن',
      'topStrengthNow': 'أهم نقطة قوة الآن',
      'finalRevealTitle': 'جاهزون للقراءة النهائية',
      'finalRevealBody':
          'لقد أكملتما الرحلة كاملة. الخطوة التالية ستحول الإجابات إلى أنماط شخصية، وخريطة توافق، وأوضح نقاط للنقاش.',
      'finalRevealPrimary': 'اكشف نتيجة التوافق',
      'reviewLastQuestion': 'راجع السؤال الأخير',
      'completed': 'مكتمل',
      'pending': 'قيد الانتظار',
      'userA': 'الشخص الأول',
      'userB': 'الشخص الثاني',
      'name': 'الاسم',
      'age': 'العمر',
      'job': 'الوظيفة',
      'education': 'التعليم',
      'profileSetupTitle': 'ابدأ ببناء الملف الشخصي',
      'profileSetupBody':
          'هذا الجزء يضع سياق رحلة الشخصية، لذلك من الأفضل أن تكون البيانات واضحة وواقعية.',
      'profileProgress': 'تقدم الملف الشخصي',
      'profileCompleteFields': 'اكتمل {current} من {total} حقول',
      'identitySection': 'البيانات الأساسية',
      'identitySectionBody':
          'هذه التفاصيل تثبت هوية الملف قبل أن تبدأ قراءة التوافق الأعمق.',
      'contextSection': 'سياق الحياة اليومية',
      'contextSectionBody':
          'العمل والتعليم يساعدان في فهم الروتين والضغط والتوقعات.',
      'profileNextUserB': 'بعد حفظ هذا الملف ستنتقل إلى الشخص الثاني.',
      'profileNextTest': 'بعد حفظ هذا الملف ستدخل مباشرة إلى رحلة الشخصية.',
      'nameHint': 'كيف تريد أن يظهر هذا الشخص داخل التقرير؟',
      'ageHint': '18+',
      'jobHint': 'الوظيفة الحالية أو العمل الأساسي',
      'educationHint': 'أعلى مستوى تعليمي مكتمل',
      'profileReady': 'الملف الشخصي جاهز للخطوة التالية.',
      'profileNeedsMore': 'أكمل الحقول المتبقية لتنتقل للخطوة التالية بسلاسة.',
      'next': 'التالي',
      'saveContinue': 'حفظ ومتابعة',
      'personalityTest': 'اختبار الشخصية',
      'result': 'نتيجة التوافق',
      'compatibility': 'التوافق',
      'readiness': 'جاهزية الزواج',
      'strengths': 'نقاط القوة',
      'risks': 'مناطق الخطر',
      'notes': 'ملاحظات نفسية',
      'sessions': 'جلسات مقترحة',
      'bookConsultation': 'حجز استشارة أسرية',
      'individualTherapy': 'حجز علاج فردي',
      'coaching': 'جلسات تأهيل قبل الزواج',
      'sessionTypeFamily': 'استشارة أسرية',
      'sessionTypeIndividual': 'علاج فردي',
      'sessionTypeCoaching': 'تأهيل قبل الزواج',
      'booking': 'حجز استشارة',
      'preferredDate': 'الموعد المفضل',
      'phone': 'رقم الهاتف',
      'message': 'رسالة',
      'confirmBooking': 'تأكيد الحجز',
      'bookingSaved': 'تم حفظ طلب الحجز محلياً',
      'bookingSent': 'تم فتح طلب الحجز للإرسال إلى العيادة.',
      'bookingSendFailed':
          'تم حفظ الحجز، لكن لم يتمكن الهاتف من فتح تطبيق الإرسال.',
      'bookingActionFailed': 'تعذر فتح هذا الإجراء على الجهاز.',
      'bookingStatusWhatsapp': 'تم فتح واتساب',
      'bookingStatusSms': 'تم فتح الرسائل',
      'bookingStatusCall': 'تم فتح الاتصال',
      'bookingStatusRemote': 'تم الحفظ في الخلفية',
      'bookingStatusFailed': 'محفوظ محليًا فقط',
      'bookingConfirmationTitle': 'طلب الحجز جاهز',
      'openWhatsapp': 'فتح واتساب',
      'openSms': 'فتح الرسائل',
      'callClinicAction': 'الاتصال بالعيادة',
      'copyBookingMessage': 'انسخ نص الطلب',
      'bookingMessageCopied': 'تم نسخ نص طلب الحجز.',
      'openBookingHistory': 'افتح سجل الحجوزات',
      'done': 'تم',
      'pickDate': 'اختر التاريخ',
      'appearance': 'المظهر',
      'language': 'اللغة',
      'light': 'فاتح',
      'dark': 'داكن',
      'system': 'النظام',
      'english': 'English',
      'arabic': 'العربية',
      'clearData': 'مسح التقييم المحفوظ',
      'calculate': 'حساب التوافق',
      'completeProfiles': 'أكمل بيانات الشخصين أولاً',
      'resultEmptyBody':
          'أكمل بيانات الشخصين وأجب عن كل الأسئلة لتوليد تقرير التوافق.',
      'openAssessment': 'افتح التقييم',
      'fieldRequired': 'هذا الحقل مطلوب',
      'invalidAge': 'يجب أن يكون العمر 18 سنة أو أكثر',
      'invalidPhone': 'أدخل رقم هاتف صحيح',
      'selectPreferredDate': 'اختر موعدك المفضل',
      'categoryPersonality': 'الشخصية',
      'categoryEmotionalIntelligence': 'الذكاء العاطفي',
      'categoryAngerManagement': 'إدارة الغضب',
      'categoryCommunication': 'التواصل',
      'categoryFinancialMindset': 'التفكير المالي',
      'categoryFamilyBoundaries': 'الحدود الأسرية',
      'categoryFutureGoals': 'الأهداف المستقبلية',
      'categoryResponsibility': 'المسؤولية',
      'noHighRisk': 'لا توجد منطقة خطورة عالية حسب التقييم الحالي.',
      'noStrongAlignmentYet':
          'يوجد مجهود مشترك واضح، لكن لا توجد فئة متوافقة بقوة حتى الآن.',
      'alignmentLabel': 'توافق',
      'needsStructuredDiscussion': 'تحتاج إلى نقاش منظم',
      'noteStrongAlignment':
          'يوجد انسجام قوي بين الطرفين، لكن ما زال من المهم مناقشة التوقعات بوضوح.',
      'noteWorkableCompatibility':
          'العلاقة قابلة للنجاح، لكن توجد موضوعات تحتاج إلى حوار موجّه.',
      'noteFragileCompatibility':
          'التوافق الحالي هش، ويُفضل مراجعة الفجوات الأساسية مع مختص قبل اتخاذ قرار الارتباط.',
      'noteAngerManagement':
          'إدارة الغضب وإصلاح الخلافات تحتاج إلى اهتمام قبل زيادة ضغوط الزواج.',
      'noteFamilyBoundaries':
          'توقعات الحدود الأسرية قد تسبب ضغطاً متكرراً إذا ظلت غير واضحة.',
      'noteReadinessThreshold':
          'جاهزية الزواج أقل من الحد الموصى به لاتخاذ قرار مطمئن.',
      'sessionCommunication': 'جلسة تواصل وحوار وقت الخلاف',
      'sessionFamilyBoundaries': 'جلسة استشارة للحدود الأسرية',
      'sessionFuturePlanning': 'جلسة للتخطيط المستقبلي والتوقعات المالية',
      'sessionIndividualReadiness': 'مراجعة فردية للجاهزية النفسية',
      'sessionAlignment': 'جلسة تأهيل قبل الزواج للمراجعة النهائية',
      'profileEnergyOutgoing': 'يستمد طاقته من الناس والحركة والتفاعل الواضح.',
      'profileEnergyReserved':
          'يستعيد طاقته بشكل أفضل عبر الهدوء وتقليل الكثافة الاجتماعية.',
      'profileEnergyBalanced':
          'يستمتع بالتفاعل الاجتماعي وبالوقت الهادئ أيضًا.',
      'profileStructureStructured':
          'يشعر بالأمان أكثر مع التخطيط والوضوح والنظام.',
      'profileStructureFlexible': 'يفضل المرونة وترك مساحة للتغيير.',
      'profileStructureBalanced': 'يستخدم النظام عند الحاجة بدون جمود زائد.',
      'profileEmotionAware': 'يفهم مشاعره غالبًا ويستطيع التعبير عنها بوضوح.',
      'profileEmotionGuarded': 'قد يحتاج وقتًا أكبر لفهم مشاعره والتعبير عنها.',
      'profileEmotionGrowing':
          'يمتلك وعيًا جيدًا مع مساحة لتعميق الوضوح العاطفي.',
      'profileConflictSteady': 'يميل إلى تهدئة الخلاف وإصلاح العلاقة.',
      'profileConflictReactive': 'قد يتفاعل بسرعة تحت الضغط قبل أن يهدأ.',
      'profileConflictDeveloping':
          'عادات الخلاف لديه مختلطة ويمكن تطويرها بالممارسة.',
      'dynamicEnergyAligned':
          'الإيقاع الاجتماعي بينهما متقارب، وهذا يسهل بناء روتين مشترك.',
      'dynamicEnergyBridge':
          'الطاقة الاجتماعية بينهما مختلفة بما يكفي لتحتاج إلى توازن واعٍ.',
      'dynamicPlanningAligned': 'يتعاملان مع التخطيط والنظام بوتيرة متقاربة.',
      'dynamicPlanningBridge':
          'أسلوب التخطيط بينهما مختلف، لذلك يجب الاتفاق على التوقعات مبكرًا.',
      'dynamicRepairStrong':
          'قدرة الطرفين على إصلاح الخلاف تبدو قوية وتحمي العلاقة.',
      'dynamicRepairFragile':
          'إصلاح الخلاف يبدو هشًا ويحتاج عملًا واعيًا قبل زيادة الضغوط.',
      'dynamicRepairDeveloping':
          'توجد مهارات إصلاح، لكن العلاقة ستستفيد من عادات أوضح وقت الخلاف.',
      'archetypePlanner': 'المخطط',
      'archetypeFlexible': 'المرن',
      'archetypeBalanced': 'المتوازن',
      'archetypeWarmCommunicator': 'المتواصل الدافئ',
      'archetypeReflectivePartner': 'الشريك المتأمل',
      'archetypeSteadyResponder': 'الهادئ في الاستجابة',
      'archetypeDirectProcessor': 'المباشر في المعالجة',
      'localOnly': 'نموذج محلي. يمكن ربط Firebase لاحقاً.',
    },
  };

  static String of(BuildContext context, String key) {
    final languageCode = context.read<AppState>().languageCode;
    return _values[languageCode]?[key] ?? _values['en']?[key] ?? key;
  }
}

extension AppStringsContext on BuildContext {
  String tr(String key) => AppStrings.of(this, key);
}
