{
  equibopStylix,
  vars,
  ...
}:
# Plugins affecting chat, messages, and sharing.
{
  programs.nixcord.config.plugins = {
    # keep-sorted start block=yes
    AutoZipper.enable = true;
    BetterCommands.enable = true;
    BetterGifAltText.enable = true;
    CharacterCounter.enable = true;
    CleanChannelName.enable = true;
    ClearURLs.enable = true;
    CopyEmojiMarkdown.enable = true;
    CopyFileContents.enable = true;
    CopyStickerLinks.enable = true;
    CopyUserMention.enable = true;
    CopyUserURLs.enable = true;
    CustomTimestamps = {
      enable = true;
      formats = {
        # keep-sorted start
        ariaLabelFormat = "YYYY-MM-DD HH:mm:ss";
        compactFormat = "YYYY-MM-DD HH:mm:ss";
        cozyFormat = "YYYY-MM-DD HH:mm:ss";
        lastDayFormat = "YYYY-MM-DD HH:mm:ss";
        lastWeekFormat = "YYYY-MM-DD HH:mm:ss";
        sameDayFormat = "YYYY-MM-DD HH:mm:ss";
        sameElseFormat = "YYYY-MM-DD HH:mm:ss";
        # keep-sorted end
      };
    };
    DontFilterMe.enable = true;
    DontRoundMyTimestamps.enable = true;
    ExpressionCloner.enable = true;
    FavoriteGifSearch.enable = true;
    FixCodeblockGap.enable = true;
    FixFileExtensions.enable = true;
    FixImagesQuality.enable = true;
    FixSpotifyEmbeds.enable = true;
    FixYoutubeEmbeds.enable = true;
    ForwardAnywhere.enable = true;
    GifPaste.enable = true;
    HolyNotes.enable = true;
    ILoveSpam.enable = true;
    ImageFilename.enable = true;
    LimitMiddleClickPaste = {
      enable = true;
      limitTo = "never";
    };
    MessageBurst = {
      enable = true;
      timePeriod = 3;
    };
    MessageFetchTimer = {
      enable = true;
      iconColor = equibopStylix.messageFetchTimerIcon;
    };
    MessageLatency = {
      enable = true;
      showMillis = true;
      latency = 1;
    };
    MessageLinkEmbeds = {
      enable = true;
      messageBackgroundColor = true;
    };
    MoreQuickReactions.enable = true;
    NoPushToTalk.enable = true;
    NormalizeMessageLinks.enable = true;
    PolishWording = {
      enable = true;
      # keep-sorted start
      fixCapitalization = true;
      fixPunctuation = true;
      # keep-sorted end
    };
    ReplyTimestamp.enable = true;
    SearchFix.enable = true;
    SelfForward.enable = true;
    SendTimestamps.enable = true;
    SongLink = {
      enable = true;
      userCountry = vars.countryCode;
    };
    SplitLargeMessages.enable = true;
    StickerPaste.enable = true;
    TextReplace = {
      enable = true;
      regexRules = [
        # keep-sorted start block=yes

        # Minecraft bugs regex.
        {
          find = "(?:^|(?<=[\\s,:;/&]))MC-\\d+(?:(?=[\\s.?!,:;/&])|$) replace: [$&]";
          replace = "(<https://bugs.mojang.com/browse/$&>)";
        }
        # XKCD regex.
        {
          find = "(?:^|(?<=[\s,:;/&]))xkcd\/(\d+)(?:(?=[\s.?!,:;/&])|$)";
          replace = "[$&](https://xkcd.com/$1)";
        }
        # Tenor regex.
        {
          find = "(https:\/\/media1\.tenor\.com\/m\/[^\/]+\/[^\/]+\.gif)(?!\?)";
          replace = "$1?download=1";
        }
        {
          find = "(https:\\/\\/github\\.com\\/[^\\/]+\\/[^\\/]+\\/commit\\/([0-9a-f]{7})([0-9a-f]{0,33}))";
          replace = "[`$2`]($1)";
        }
        {
          find = "(https:\\/\\/github\\.com\\/[^\\/]+\\/[^\\/]+\\/issues\\/([0-9a-f]{1,}))";
          replace = "[`Issue #$2`]($1)";
        }
        {
          find = "(https:\\/\\/github\\.com\\/[^\\/]+\\/[^\\/]+\\/pull\\/([0-9a-f]{1,}))";
          replace = "[`Pull Request #$2`]($1)";
        }
        # Github regex.
        {
          find = "gh:([a-zA-Z0-9_-]+)/([a-zA-Z0-9_.-]+)";
          replace = "[$1/$2](https://github.com/$1/$2)";
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
        {
          find = "tenor\.com\/..-..\/view ";
          replace = "tenor.com/view";
        }
        # keep-sorted end
      ];
    };
    Timezones = {
      enable = true;
      "24h Time" = true;
    };
    Translate.enable = true;
    TypingIndicator = {
      enable = true;
      # keep-sorted start
      includeBlockedUsers = true;
      includeIgnoredUsers = true;
      includeMutedChannels = true;
      # keep-sorted end
    };
    UnsuppressEmbeds.enable = true;
    UserMessagesPronouns.enable = true;
    ValidReply.enable = true;
    VoiceRejoin.enable = true;
    WaitForSlot.enable = true;
    WebScreenShareFixes.enable = true;
    WriteUpperCase = {
      enable = true;
      blockedWords = "http, https";
    };
    ZipPreview.enable = true;
    # keep-sorted end
  };
}
