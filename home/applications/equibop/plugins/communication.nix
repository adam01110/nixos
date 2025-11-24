{
  stylix,
  userCountry,
  ...
}:

# plugins affecting chat, messages, and sharing.
{
  autoZipper.enabled = true;
  betterCommands.enabled = true;
  betterGifAltText.enabled = true;
  betterQuickReact.enabled = true;
  characterCounter.enabled = true;
  cleanChannelName.enabled = true;
  clearURLs.enabled = true;
  copyEmojiMarkdown.enabled = true;
  copyFileContents.enabled = true;
  copyStickerLinks.enabled = true;
  copyUserMention.enabled = true;
  copyUserURLs.enabled = true;
  customTimestamps = {
    enabled = true;
    formats = {
      cozyFormat = "YYYY-MM-DD HH:mm:ss";
      compactFormat = "YYYY-MM-DD HH:mm:ss";
      sameDayFormat = "YYYY-MM-DD HH:mm:ss";
      lastDayFormat = "YYYY-MM-DD HH:mm:ss";
      lastWeekFormat = "YYYY-MM-DD HH:mm:ss";
      sameElseFormat = "YYYY-MM-DD HH:mm:ss";
      ariaLabelFormat = "YYYY-MM-DD HH:mm:ss";
    };
  };
  dontFilterMe.enabled = true;
  dontRoundMyTimestamps.enabled = true;
  expressionCloner.enabled = true;
  favoriteGifSearch.enabled = true;
  fixCodeblockGap.enabled = true;
  fixFileExtensions.enabled = true;
  fixImagesQuality.enabled = true;
  fixSpotifyEmbeds.enabled = true;
  fixYoutubeEmbeds.enabled = true;
  forwardAnywhere.enabled = true;
  gifPaste.enabled = true;
  holyNotes.enabled = true;
  ignoreTerms.enabled = true;
  iLoveSpam.enabled = true;
  imageFilename.enabled = true;
  imagePreview.enabled = true;
  limitMiddleClickPaste = {
    enabled = true;
    limitTo = "never";
  };
  messageBurst = {
    enabled = true;
    timePeriod = 3;
  };
  messageFetchTimer = {
    enabled = true;
    iconColor = stylix.messageFetchTimerIcon;
  };
  messageLatency = {
    enabled = true;
    latency = 1;
    showMillis = true;
  };
  messageLinkEmbeds = {
    enabled = true;
    messageBackgroundColor = true;
  };
  normalizeMessageLinks.enabled = true;
  polishWording = {
    enabled = true;
    fixCapitalization = true;
    fixPunctuation = true;
  };
  replyTimestamp.enabled = true;
  searchFix.enabled = true;
  selfForward.enabled = true;
  sendTimestamps.enabled = true;
  songLink = {
    enabled = true;
    inherit userCountry;
    servicesSettings = {
      amazonMusic.enabled = false;
      spotify = {
        enabled = false;
        openInNative = false;
      };
      itunes = {
        enabled = false;
        openInNative = false;
      };
      appleMusic = {
        enabled = false;
        openInNative = false;
      };
      youtube.enabled = true;
      youtubeMusic.enabled = true;
      google.enabled = true;
      googleMusic.enabled = false;
      pandora.enabled = false;
      deezer.enabled = false;
      tidal.enabled = false;
      amazonStore.enabled = false;
      napster.enabled = false;
      yandex.enabled = false;
      spinrilla.enabled = false;
      audius.enabled = false;
      audiomack.enabled = false;
      anghami.enabled = false;
      boomplay.enabled = false;
      bandcamp.enabled = false;
    };
  };
  splitLargeMessages.enabled = true;
  stickerPaste.enabled = true;
  textReplace = {
    enabled = true;
    regexRules = [
      {
        find = "gh:([a-zA-Z0-9_-]+)/([a-zA-Z0-9_.-]+)";
        replace = "[$1/$2](https://github.com/$1/$2)";
      }
      {
        find = "(?:^|(?<=[\\s,:;/&]))MC-\\d+(?:(?=[\\s.?!,:;/&])|$) replace: [$&]";
        replace = "(<https://bugs.mojang.com/browse/$&>)";
      }
      {
        find = "(https:\\/\\/github\\.com\\/[^\\/]+\\/[^\\/]+\\/issues\\/([0-9a-f]{1,}))";
        replace = "[`Issue #$2`]($1)";
      }
      {
        find = "(https:\\/\\/github\\.com\\/[^\\/]+\\/[^\\/]+\\/pull\\/([0-9a-f]{1,}))";
        replace = "[`Pull Request #$2`]($1)";
      }
      {
        find = "(https:\\/\\/github\\.com\\/[^\\/]+\\/[^\\/]+\\/commit\\/([0-9a-f]{7})([0-9a-f]{0,33}))";
        replace = "[`$2`]($1)";
      }
    ];
  };
  timezones = {
    enabled = true;
    "24h Time" = true;
  };
  translate.enabled = true;
  typingIndicator = {
    enabled = true;
    includeMutedChannels = true;
    includeIgnoredUsers = true;
    includeBlockedUsers = true;
  };
  unsuppressEmbeds.enabled = true;
  userMessagesPronouns.enabled = true;
  validReply.enabled = true;
  writeUpperCase = {
    enabled = true;
    blockedWords = "http, https";
  };
  youtubeDescription.enabled = true;
  zipPreview.enabled = true;
}
