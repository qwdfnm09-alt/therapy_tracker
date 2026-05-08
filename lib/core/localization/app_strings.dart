import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../../presentation/providers/app_state.dart';

class AppStrings {
  static const _values = <String, Map<String, String>>{
    'en': {
      'appName': 'Taalof',
      'tagline': 'Marriage compatibility and family counseling',
      'startAssessment': 'Start assessment',
      'startUsage': 'Start Usage',
      'continueAssessment': 'Continue assessment',
      'settings': 'Settings',
      'welcomeTitle': 'Build a clearer marriage decision',
      'welcomeBody':
          'Evaluate personality, emotions, lifestyle, expectations, and family boundaries before marriage.',
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
      'featureSettings': 'Change language, theme, and clear saved data',
      'educationalHub': 'Educational Hub',
      'resourcesToolsHub': 'Resources & Tools',
      'relationshipTools': 'Relationship tools',
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
      'relationshipToolsIntroTitle': 'Small tools for steadier connection',
      'relationshipToolsIntroBody':
          'These tools are intentionally simple. They do not diagnose the relationship, but they help both people turn care into visible action.',
      'loveLanguagesTitle': 'Love languages quick guide',
      'loveLanguagesBody':
          'Use this as a practical lens, not as a rigid label. The useful question is: what kind of care is actually felt by the other person?',
      'weeklyChallengesTitle': 'Weekly connection challenges',
      'weeklyChallengesBody':
          'Choose one challenge at a time. Keep it specific and repeatable instead of turning it into a performance.',
      'relationshipToolsUsageTitle': 'How to use these tools well',
      'relationshipToolsUsagePoint1':
          'Start with the smallest useful action instead of promising a full personality change.',
      'relationshipToolsUsagePoint2':
          'If one tool feels unnatural, discuss why before treating it as failure.',
      'relationshipToolsUsagePoint3':
          'Use repetition to build trust. Small consistent care is more useful than rare dramatic effort.',
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
      'appName': 'Taalof',
      'tagline': 'توافق الزواج والاستشارات الأسرية',
      'startAssessment': 'ابدأ التقييم',
      'startUsage': 'ابدأ الاستخدام',
      'continueAssessment': 'استكمال التقييم',
      'settings': 'الإعدادات',
      'welcomeTitle': 'اتخذ قرار زواج أوضح',
      'welcomeBody':
          'قيّم الشخصية والمشاعر ونمط الحياة والتوقعات والحدود الأسرية قبل الزواج.',
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
      'featureSettings': 'غيّر اللغة والمظهر وامسح البيانات المحفوظة',
      'educationalHub': 'المكتبة التوعوية',
      'resourcesToolsHub': 'المحتوى والأدوات',
      'relationshipTools': 'أدوات العلاقة',
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
      'relationshipToolsIntroTitle': 'أدوات صغيرة لاتصال أكثر ثباتًا',
      'relationshipToolsIntroBody':
          'هذه الأدوات بسيطة عن قصد. لا تشخّص العلاقة، لكنها تساعد الطرفين على تحويل الاهتمام إلى أفعال واضحة ومتكررة.',
      'loveLanguagesTitle': 'دليل سريع للغات الحب',
      'loveLanguagesBody':
          'استخدم هذا القسم كعدسة عملية لا كتصنيف جامد. السؤال المفيد هنا هو: أي نوع من الاهتمام يشعر به الطرف الآخر فعلًا؟',
      'weeklyChallengesTitle': 'تحديات أسبوعية للتقارب',
      'weeklyChallengesBody':
          'اختر تحديًا واحدًا في كل مرة. اجعله محددًا وقابلًا للتكرار بدل تحويله إلى أداء شكلي.',
      'relationshipToolsUsageTitle': 'كيف تُستخدم هذه الأدوات بشكل جيد',
      'relationshipToolsUsagePoint1':
          'ابدأ بأصغر فعل مفيد بدل الوعد بتغيير الشخصية بالكامل.',
      'relationshipToolsUsagePoint2':
          'إذا بدت أداة ما غير طبيعية، فناقش سبب ذلك قبل اعتبارها فشلًا.',
      'relationshipToolsUsagePoint3':
          'التكرار يبني الثقة. الاهتمام الصغير المستمر أنفع من الجهد الكبير النادر.',
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
