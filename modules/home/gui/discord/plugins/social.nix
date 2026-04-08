_:
# Social and community related plugins.
{
  programs.nixcord.config.plugins = {
    # keep-sorted start block=yes
    BetterBlockedUsers.enable = true;
    BetterInvites.enable = true;
    ForceOwnerCrown.enable = true;
    FriendsSince.enable = true;
    FriendshipRanks.enable = true;
    GuildTagSettings.enable = true;
    ImplicitRelationships.enable = true;
    InviteDefaults.enable = true;
    MemberCount.enable = true;
    MoreUserTags.enable = true;
    MutualGroupDMs.enable = true;
    NewGuildSettings = {
      enable = true;
      messages = 1;
    };
    PauseInvitesForever.enable = true;
    RelationshipNotifier.enable = true;
    ReviewDB = {
      enable = true;
      hideBlockedUsers = false;
    };
    ServerInfo.enable = true;
    ShowConnections = {
      enable = true;
      iconSpacing = 0;
    };
    ShowHiddenChannels.enable = true;
    ShowTimeoutDuration.enable = true;
    SongSpotlight.enable = true;
    SortFriends = {
      enable = true;
      showDates = true;
    };
    WhoReacted.enable = true;
    # keep-sorted end
  };
}
