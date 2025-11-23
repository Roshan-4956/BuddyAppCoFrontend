/// Assets constants for the Buddy app
/// All assets are organized by feature/section for easy management
class Assets {
  Assets._();

  static const String _assets = 'assets/';

  // common assets used across multiple screens
  /// Buddy logo + text (SVG)
  static const String buddyIconWithText = '${_assets}common/icon+text.svg';

  // ==========================================================================
  // WELCOME SCREEN
  // ==========================================================================

  /// Welcome screen - Buddy character and boxes illustration (combined artwork)
  static const String welcomeIllustrationBuddy =
      '${_assets}welcome/illustration.svg';

  // ==========================================================================
  // ICONS - General UI Icons
  // ==========================================================================

  /// Right arrow icon
  static const String iconArrowRight = '${_assets}icons/arrow_right.svg';

  /// Right arrow vector (inner element)
  static const String iconArrowRightVector =
      '${_assets}icons/arrow_right_vector.svg';

  /// Checkbox icon
  static const String iconCheckbox = '${_assets}icons/checkbox.svg';

  /// Back arrow icon (gray)
  static const String iconBackArrow = '${_assets}icons/back_arrow.svg';

  // ==========================================================================
  // LOGIN SCREEN
  // ==========================================================================

  /// Login options background image
  static const String loginOptions = '${_assets}login_screen/loginOptions.png';

  /// Welcome screen background
  static const String loginWelcomeScreen =
      '${_assets}login_screen/welcomescreen.png';

  /// Apple login icon
  static const String loginApple = '${_assets}login_screen/apple.png';

  /// Google login icon
  static const String loginGoogle = '${_assets}login_screen/google.png';

  /// Error icon for form validation
  static const String loginError = '${_assets}login_screen/error.png';

  /// Back arrow for navigation
  static const String loginArrow = '${_assets}login_screen/arrow.png';

  static const String loginIllustration1 =
      '${_assets}login_screen/login-illustration-1.svg';
  static const String loginIllustration2 =
      '${_assets}login_screen/login-above-box.svg';

  // ==========================================================================
  // ONBOARDING
  // ==========================================================================

  /// Filler screen - Background Blobs
  static const String fillerBlob1 = '${_assets}onboarding_filler/filler_blob_1.svg';
  static const String fillerBlob2 = '${_assets}onboarding_filler/filler_blob_2.svg';
  static const String fillerBlob3 = '${_assets}onboarding_filler/filler_blob_3.svg';

  /// Filler screen - Star (Reusable)
  static const String fillerStar = '${_assets}onboarding_filler/filler_star.svg';

  /// Filler screen - Circle outlines for background
  static const String onboardingCircleOutline1 =
      '${_assets}onboarding/circle_outline_1.svg';
  static const String onboardingCircleOutline2 =
      '${_assets}onboarding/circle_outline_2.svg';
  static const String onboardingCircleOutline3 =
      '${_assets}onboarding/circle_outline_3.svg';

  /// Onboarding Step 1 - Purple filled circle background decoration
  static const String onboardingStep1BackgroundCirclePurple =
      '${_assets}onboarding/circle_filled_1.svg';

  /// Onboarding Steps 2-4 - Light blue filled circle background decoration
  static const String onboardingStep2BackgroundCircleBlue =
      '${_assets}onboarding/circle_filled_2.svg';

  /// Filler screen - Decorative stars
  static const String onboardingStarBlueSmall =
      '${_assets}onboarding/star_blue_small.svg';
  static const String onboardingStarBlue1 =
      '${_assets}onboarding/star_blue_1.svg';
  static const String onboardingStarBlue2 =
      '${_assets}onboarding/star_blue_2.svg';
  static const String onboardingStarPink1 =
      '${_assets}onboarding/star_pink_1.svg';
  static const String onboardingStarPink2 =
      '${_assets}onboarding/star_pink_2.svg';
  static const String onboardingStarPink3 =
      '${_assets}onboarding/star_pink_3.svg';
  static const String onboardingStarPink4 =
      '${_assets}onboarding/star_pink_4.svg';
  static const String onboardingStarYellow1 =
      '${_assets}onboarding/star_yellow_1.svg';
  static const String onboardingStarYellow2 =
      '${_assets}onboarding/star_yellow_2.svg';
  static const String onboardingStarYellow3 =
      '${_assets}onboarding/star_yellow_3.svg';
  static const String onboardingStarPurple1 =
      '${_assets}onboarding/star_purple_1.svg';

  /// Step 1 - Background circle and UI elements
  static const String onboardingStep1Circle =
      '${_assets}onboarding/circle_outline_1.svg';
  static const String onboardingCalendarIcon =
      '${_assets}onboarding/calendar_icon.svg';
  static const String onboardingDropdownIcon =
      '${_assets}onboarding/dropdown_icon.svg';
  static const String onboardingBackArrow = '${_assets}icons/back_arrow.svg';

  /// Step 2 - Background circle
  static const String onboardingStep2Circle =
      '${_assets}onboarding/circle_outline_2.svg';

  /// Avatar selection images
  static const String onboardingAvatar1 = '${_assets}onboarding/avatar_1.png';
  static const String onboardingAvatar2 = '${_assets}onboarding/avatar_2.png';
  static const String onboardingAvatar3 = '${_assets}onboarding/avatar_3.png';
  static const String onboardingAvatar4 = '${_assets}onboarding/avatar_4.png';
  static const String onboardingAvatar5 = '${_assets}onboarding/avatar_5.png';

  /// Camera icon for photo capture
  static const String onboardingCamera = '${_assets}onboarding/camera.png';

  /// Gallery icon for photo selection
  static const String onboardingGallery = '${_assets}onboarding/gallery.png';

  /// Gender selection icons
  static const String onboardingGenderMale = '${_assets}onboarding/male.png';
  static const String onboardingGenderFemale =
      '${_assets}onboarding/female.png';
  static const String onboardingGenderOthers =
      '${_assets}onboarding/others.png';

  // ==========================================================================
  // INTERESTS
  // ==========================================================================

  /// Interest category icons
  static const String interestAdventure = '${_assets}interests/adventure.png';
  static const String interestArt = '${_assets}interests/art.png';
  static const String interestBooks = '${_assets}interests/books.png';
  static const String interestEntertainment =
      '${_assets}interests/entertainment.png';
  static const String interestFashion = '${_assets}interests/fashion.png';
  static const String interestFood = '${_assets}interests/food.png';
  static const String interestGaming = '${_assets}interests/gaming.png';
  static const String interestHealth = '${_assets}interests/health.png';
  static const String interestMusic = '${_assets}interests/music.png';
  static const String interestSports = '${_assets}interests/sports.png';
  static const String interestTech = '${_assets}interests/tech.png';
  static const String interestTravel = '${_assets}interests/travel.png';

  // ==========================================================================
  // COMMON UI ELEMENTS
  // ==========================================================================

  /// Back arrow (dark)
  static const String backArrow = '${_assets}backArrow.png';

  /// Back arrow (white/light)
  static const String backArrowWhite = '${_assets}backArrowWhite.png';

  /// Buddy logo with title
  static const String buddyLogoTitle = '${_assets}buddyLogoTitle.png';

  /// Blue stars decoration
  static const String blueStars = '${_assets}blueStars.png';

  /// Purple star
  static const String purpleStar = '${_assets}purpStar.png';

  /// Purple stars
  static const String purpleStars = '${_assets}purpStars.png';

  /// Yellow star
  static const String yellowStar = '${_assets}yellowStar.png';

  // ==========================================================================
  // SPLASH & LOADING SCREENS
  // ==========================================================================

  /// Green splash screen
  static const String greenSplash = '${_assets}greenSplash.png';

  /// Community people illustration
  static const String commPeeps = '${_assets}commPeeps.png';

  /// Ladder climber illustration
  static const String ladderClimber = '${_assets}ladderClimber.png';

  // ==========================================================================
  // PREFERENCE SCREENS
  // ==========================================================================

  /// Gender preference background
  static const String genderPrefBG = '${_assets}genderPrefBG.png';

  /// Location preference background
  static const String locPrefBG = '${_assets}locPrefBG.png';

  /// Phone OTP screen
  static const String continueWithPhoneOTP =
      '${_assets}CONTINUE WITH PHONE OTP.png';

  // ==========================================================================
  // HOMEPAGE
  // ==========================================================================

  // Add homepage specific assets here as needed

  // ==========================================================================
  // COMMUNITY
  // ==========================================================================

  static const String _community = '${_assets}community/';

  /// Alert icon
  static const String communityAlert = '${_community}alert.png';

  /// Blue graphic decoration
  static const String communityBlueGraphic = '${_community}blueGraphic.png';

  /// Buy event background
  static const String communityBuyEventBG = '${_community}buyEventBG.png';

  /// Cross/close icon
  static const String communityCross = '${_community}cross.png';

  /// Pink calendar icon
  static const String communityPinkCal = '${_community}pinkCal.png';

  /// Pink time icon
  static const String communityPinkTime = '${_community}pinkTime.png';

  /// Red eye icon
  static const String communityRedEye = '${_community}redeye.png';

  /// Tick/check icon
  static const String communityTick = '${_community}tick.png';

  /// Upload icon
  static const String communityUpload = '${_community}upload.png';

  /// Yellow calendar pin
  static const String communityYellowCalPin = '${_community}yellowCalPin.png';

  /// Yellow location pin
  static const String communityYellowLocPin = '${_community}yellowLocPin.png';

  // ==========================================================================
  // EVENTS
  // ==========================================================================

  static const String _events = '${_assets}events/';

  /// Event picture 1
  static const String eventsEventPic = '${_events}eventPic.png';

  /// Event picture 2
  static const String eventsEventPic2 = '${_events}eventPic2.png';

  /// Calendar pin
  static const String eventsCalPin = '${_events}calPin.png';

  /// Location pin
  static const String eventsLocPin = '${_events}locPin.png';

  /// Time pin
  static const String eventsTimePin = '${_events}timePin.png';

  /// Seats pin
  static const String eventsSeatsPin = '${_events}seatsPin.png';

  /// Ticket colors
  static const String eventsBlueTicket = '${_events}blueTicket.png';
  static const String eventsGreenTicket = '${_events}greenTicket.png';
  static const String eventsGreyTicket = '${_events}greyTicket.png';
  static const String eventsPinkTicket = '${_events}pinkTicket.png';
  static const String eventsPurpleTicket = '${_events}purpleTicket.png';
  static const String eventsYellowTicket = '${_events}yellowTicket.png';

  // ==========================================================================
  // NUDGES
  // ==========================================================================

  static const String _nudges = '${_assets}nudges/';

  /// Black calendar icon
  static const String nudgesBlackCal = '${_nudges}blackCal.png';

  /// Black location icon
  static const String nudgesBlackLoc = '${_nudges}blackLoc.png';

  /// Black time icon
  static const String nudgesBlackTime = '${_nudges}blackTime.png';

  /// Calendar pin
  static const String nudgesCalPin = '${_nudges}calPin.png';

  /// Calendar without background
  static const String nudgesCalWOBG = '${_nudges}calWOBG.png';

  /// Card design
  static const String nudgesCard = '${_nudges}card.png';

  /// Cross icon
  static const String nudgesCross = '${_nudges}cross.png';

  /// Dummy requestor image
  static const String nudgesDummyRequestor = '${_nudges}dummyRequestor.png';

  /// Location pin
  static const String nudgesLocPin = '${_nudges}locPin.png';

  /// Location without background
  static const String nudgesLocWOBG = '${_nudges}locWOBG.png';

  /// People pin
  static const String nudgesPeoplePin = '${_nudges}peoplePin.png';

  /// Requestors image
  static const String nudgesRequestors = '${_nudges}requestors.png';

  /// Star pin
  static const String nudgesStarPin = '${_nudges}starPin.png';

  /// Tick icon
  static const String nudgesTick = '${_nudges}tick.png';

  /// Time pin
  static const String nudgesTimePin = '${_nudges}timePin.png';

  /// Time without background
  static const String nudgesTimeWOBG = '${_nudges}timeWOBG.png';

  // ==========================================================================
  // WALLET
  // ==========================================================================

  // Add wallet specific assets here as needed
}

/// SVG Assets - Separate class for SVG-specific assets
class SvgAssets {
  SvgAssets._();

  static const String _assets = 'assets/';

  /// Error SVG
  static const String errorsSvg = '${_assets}error.svg';

  /// Welcome screen SVGs
  static const String welcomeBuddyLogo = Assets.buddyIconWithText;

  /// Icon SVGs
  static const String iconArrowRight = Assets.iconArrowRight;
  static const String iconCheckbox = Assets.iconCheckbox;
}
