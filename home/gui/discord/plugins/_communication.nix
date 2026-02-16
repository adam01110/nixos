{
  stylix,
  userCountry,
  ...
}:
# Plugins affecting chat, messages, and sharing.
{
  AutoZipper.enabled = true;
  BetterCommands.enabled = true;
  BetterGifAltText.enabled = true;
  CharacterCounter.enabled = true;
  CleanChannelName.enabled = true;
  ClearURLs.enabled = true;
  CopyEmojiMarkdown.enabled = true;
  CopyFileContents.enabled = true;
  CopyStickerLinks.enabled = true;
  CopyUserMention.enabled = true;
  CopyUserURLs.enabled = true;
  CustomTimestamps = {
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
  DontFilterMe.enabled = true;
  DontRoundMyTimestamps.enabled = true;
  ExpressionCloner.enabled = true;
  FavoriteGifSearch.enabled = true;
  FixCodeblockGap.enabled = true;
  FixFileExtensions.enabled = true;
  FixImagesQuality.enabled = true;
  FixSpotifyEmbeds.enabled = true;
  FixYoutubeEmbeds.enabled = true;
  ForwardAnywhere.enabled = true;
  GifPaste.enabled = true;
  HolyNotes.enabled = true;
  ILoveSpam.enabled = true;
  ImageFilename.enabled = true;
  LimitMiddleClickPaste = {
    enabled = true;
    limitTo = "never";
  };
  MessageBurst = {
    enabled = true;
    timePeriod = 3;
  };
  MessageFetchTimer = {
    enabled = true;
    iconColor = stylix.messageFetchTimerIcon;
  };
  MessageLatency = {
    enabled = true;
    latency = 1;
    showMillis = true;
  };
  MessageLinkEmbeds = {
    enabled = true;
    messageBackgroundColor = true;
  };
  MoreQuickReactions.enabled = true;
  NormalizeMessageLinks.enabled = true;
  PolishWording = {
    enabled = true;
    fixCapitalization = true;
    fixPunctuation = true;
  };
  ReplyTimestamp.enabled = true;
  SearchFix.enabled = true;
  SelfForward.enabled = true;
  SendTimestamps.enabled = true;
  SongLink = {
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
  SplitLargeMessages.enabled = true;
  StickerPaste.enabled = true;
  TextReplace = {
    enabled = true;
    regexRules = [
      # Minecraft bugs regex.
      {
        find = "(?:^|(?<=[\\s,:;/&]))MC-\\d+(?:(?=[\\s.?!,:;/&])|$) replace: [$&]";
        replace = "(<https://bugs.mojang.com/browse/$&>)";
      }

      # Github regex.
      {
        find = "gh:([a-zA-Z0-9_-]+)/([a-zA-Z0-9_.-]+)";
        replace = "[$1/$2](https://github.com/$1/$2)";
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

      # Tenor regex.
      {
        find = "(https:\/\/media1\.tenor\.com\/m\/[^\/]+\/[^\/]+\.gif)(?!\?)";
        replace = "$1?download=1";
      }
      {
        find = "tenor\.com\/..-..\/view ";
        replace = "tenor.com/view";
      }

      # Reddit regex.
      {
        find = "http(?:s)?:\/\/(?:redd\.it\/|(?:[\w-]+\.)?r[ex]ddit\.com\/)(?:(r\/[\w-]+\/s\/\w+)|(u)(?:ser)?(\/)([\w-]+)(.*?)?|(?:(?:r\/[\w-]+\/)?((c)omments\/))(\w+)(?:\/[^\/\s\)\]\}]+)+(\/)(\w+)|(?:(?:(?:r\/[\w-]+\/)?comments\/)|(?<=redd\.it\/))(\w+)(?:\/.*?)?|(?!r\/|u\/|user\/|comments\/)(.*?)?)\/?(?:[?#][^\s\)\]\}]*)?(?=[\s\)\]\}]|$)";
        replace = "https://rxddit.com/$1$2$3$4$5$6$8$9$7$9$10$11";
      }

      # Steam regex.
      {
        find = "https?://store\.steampowered\.com/app/(\d+)(?:/[^\s]*)?";
        replace = "https://s.team/a/$1";
      }

      # XKCD regex.
      {
        find = "(?:^|(?<=[\s,:;/&]))xkcd\/(\d+)(?:(?=[\s.?!,:;/&])|$)";
        replace = "[$&](https://xkcd.com/$1)";
      }
    ];
  };
  Timezones = {
    enabled = true;
    "24h Time" = true;
  };
  Translate.enabled = true;
  TypingIndicator = {
    enabled = true;
    includeMutedChannels = true;
    includeIgnoredUsers = true;
    includeBlockedUsers = true;
  };
  UnsuppressEmbeds.enabled = true;
  UserMessagesPronouns.enabled = true;
  ValidReply.enabled = true;
  WriteUpperCase = {
    enabled = true;
    blockedWords = "http, https";
  };
  YoutubeDescription.enabled = true;
  ZipPreview.enabled = true;
  WebScreenShareFixes.enabled = true;
  VoiceRejoin.enabled = true;
}
