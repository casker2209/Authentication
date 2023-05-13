class SignInResponse{
  SignInResponse({
    this.system,
    this.rocket});

  SignInResponse.fromJson(dynamic json) {
    system = json['system'] != null ? System.fromJson(json['system']) : null;
    rocket = json['rocket'] != null ? Rocket.fromJson(json['rocket']) : null;
  }
  System? system;
  Rocket? rocket;
  SignInResponse copyWith({  System? system,
    Rocket? rocket,
  }) => SignInResponse(  system: system ?? this.system,
    rocket: rocket ?? this.rocket,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (system != null) {
      map['system'] = system?.toJson();
    }
    if (rocket != null) {
      map['rocket'] = rocket?.toJson();
    }
    return map;
  }

}

class Rocket {
  Rocket({
    this.status,
    this.data,});

  Rocket.fromJson(dynamic json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? status;
  Data? data;
  Rocket copyWith({  String? status,
    Data? data,
  }) => Rocket(  status: status ?? this.status,
    data: data ?? this.data,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
    this.userId,
    this.authToken,
    this.me,});

  Data.fromJson(dynamic json) {
    userId = json['userId'];
    authToken = json['authToken'];
    me = json['me'] != null ? Me.fromJson(json['me']) : null;
  }
  String? userId;
  String? authToken;
  Me? me;
  Data copyWith({  String? userId,
    String? authToken,
    Me? me,
  }) => Data(  userId: userId ?? this.userId,
    authToken: authToken ?? this.authToken,
    me: me ?? this.me,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = userId;
    map['authToken'] = authToken;
    if (me != null) {
      map['me'] = me?.toJson();
    }
    return map;
  }

}

class Me {
  Me({
    this.id,
    this.services,
    this.username,
    this.emails,
    this.status,
    this.active,
    this.updatedAt,
    this.roles,
    this.name,
    this.requirePasswordChange,
    this.settings,
    this.statusConnection,
    this.avatarUrl,});

  Me.fromJson(dynamic json) {
    id = json['_id'];
    services = json['services'] != null ? Services.fromJson(json['services']) : null;
    username = json['username'];
    if (json['emails'] != null) {
      emails = [];
      json['emails'].forEach((v) {
        emails?.add(Emails.fromJson(v));
      });
    }
    status = json['status'];
    active = json['active'];
    updatedAt = json['_updatedAt'];
    roles = json['roles'] != null ? json['roles'].cast<String>() : [];
    name = json['name'];
    requirePasswordChange = json['requirePasswordChange'];
    settings = json['settings'] != null ? Settings.fromJson(json['settings']) : null;
    statusConnection = json['statusConnection'];
    avatarUrl = json['avatarUrl'];
  }
  String? id;
  Services? services;
  String? username;
  List<Emails>? emails;
  String? status;
  bool? active;
  String? updatedAt;
  List<String>? roles;
  String? name;
  bool? requirePasswordChange;
  Settings? settings;
  String? statusConnection;
  String? avatarUrl;
  Me copyWith({  String? id,
    Services? services,
    String? username,
    List<Emails>? emails,
    String? status,
    bool? active,
    String? updatedAt,
    List<String>? roles,
    String? name,
    bool? requirePasswordChange,
    Settings? settings,
    String? statusConnection,
    String? avatarUrl,
  }) => Me(  id: id ?? this.id,
    services: services ?? this.services,
    username: username ?? this.username,
    emails: emails ?? this.emails,
    status: status ?? this.status,
    active: active ?? this.active,
    updatedAt: updatedAt ?? this.updatedAt,
    roles: roles ?? this.roles,
    name: name ?? this.name,
    requirePasswordChange: requirePasswordChange ?? this.requirePasswordChange,
    settings: settings ?? this.settings,
    statusConnection: statusConnection ?? this.statusConnection,
    avatarUrl: avatarUrl ?? this.avatarUrl,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    if (services != null) {
      map['services'] = services?.toJson();
    }
    map['username'] = username;
    if (emails != null) {
      map['emails'] = emails?.map((v) => v.toJson()).toList();
    }
    map['status'] = status;
    map['active'] = active;
    map['_updatedAt'] = updatedAt;
    map['roles'] = roles;
    map['name'] = name;
    map['requirePasswordChange'] = requirePasswordChange;
    if (settings != null) {
      map['settings'] = settings?.toJson();
    }
    map['statusConnection'] = statusConnection;
    map['avatarUrl'] = avatarUrl;
    return map;
  }

}

class Settings {
  Settings({
    this.profile,
    this.preferences,});

  Settings.fromJson(dynamic json) {
    profile = json['profile'];
    preferences = json['preferences'] != null ? Preferences.fromJson(json['preferences']) : null;
  }
  dynamic profile;
  Preferences? preferences;
  Settings copyWith({  dynamic profile,
    Preferences? preferences,
  }) => Settings(  profile: profile ?? this.profile,
    preferences: preferences ?? this.preferences,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['profile'] = profile;
    if (preferences != null) {
      map['preferences'] = preferences?.toJson();
    }
    return map;
  }

}

class Preferences {
  Preferences({
    this.enableAutoAway,
    this.idleTimeLimit,
    this.desktopNotificationRequireInteraction,
    this.desktopNotifications,
    this.pushNotifications,
    this.unreadAlert,
    this.useEmojis,
    this.convertAsciiEmoji,
    this.autoImageLoad,
    this.saveMobileBandwidth,
    this.collapseMediaByDefault,
    this.hideUsernames,
    this.hideRoles,
    this.hideFlexTab,
    this.displayAvatars,
    this.sidebarGroupByType,
    this.sidebarViewMode,
    this.sidebarDisplayAvatar,
    this.sidebarShowUnread,
    this.sidebarSortby,
    this.alsoSendThreadToChannel,
    this.sidebarShowFavorites,
    this.sendOnEnter,
    this.messageViewMode,
    this.emailNotificationMode,
    this.newRoomNotification,
    this.newMessageNotification,
    this.muteFocusedConversations,
    this.notificationsSoundVolume,
    this.useLegacyMessageTemplate,});

  Preferences.fromJson(dynamic json) {
    enableAutoAway = json['enableAutoAway'];
    idleTimeLimit = json['idleTimeLimit'];
    desktopNotificationRequireInteraction = json['desktopNotificationRequireInteraction'];
    desktopNotifications = json['desktopNotifications'];
    pushNotifications = json['pushNotifications'];
    unreadAlert = json['unreadAlert'];
    useEmojis = json['useEmojis'];
    convertAsciiEmoji = json['convertAsciiEmoji'];
    autoImageLoad = json['autoImageLoad'];
    saveMobileBandwidth = json['saveMobileBandwidth'];
    collapseMediaByDefault = json['collapseMediaByDefault'];
    hideUsernames = json['hideUsernames'];
    hideRoles = json['hideRoles'];
    hideFlexTab = json['hideFlexTab'];
    displayAvatars = json['displayAvatars'];
    sidebarGroupByType = json['sidebarGroupByType'];
    sidebarViewMode = json['sidebarViewMode'];
    sidebarDisplayAvatar = json['sidebarDisplayAvatar'];
    sidebarShowUnread = json['sidebarShowUnread'];
    sidebarSortby = json['sidebarSortby'];
    alsoSendThreadToChannel = json['alsoSendThreadToChannel'];
    sidebarShowFavorites = json['sidebarShowFavorites'];
    sendOnEnter = json['sendOnEnter'];
    messageViewMode = json['messageViewMode'];
    emailNotificationMode = json['emailNotificationMode'];
    newRoomNotification = json['newRoomNotification'];
    newMessageNotification = json['newMessageNotification'];
    muteFocusedConversations = json['muteFocusedConversations'];
    notificationsSoundVolume = json['notificationsSoundVolume'];
    useLegacyMessageTemplate = json['useLegacyMessageTemplate'];
  }
  bool? enableAutoAway;
  num? idleTimeLimit;
  bool? desktopNotificationRequireInteraction;
  String? desktopNotifications;
  String? pushNotifications;
  bool? unreadAlert;
  bool? useEmojis;
  bool? convertAsciiEmoji;
  bool? autoImageLoad;
  bool? saveMobileBandwidth;
  bool? collapseMediaByDefault;
  bool? hideUsernames;
  bool? hideRoles;
  bool? hideFlexTab;
  bool? displayAvatars;
  bool? sidebarGroupByType;
  String? sidebarViewMode;
  bool? sidebarDisplayAvatar;
  bool? sidebarShowUnread;
  String? sidebarSortby;
  String? alsoSendThreadToChannel;
  bool? sidebarShowFavorites;
  String? sendOnEnter;
  num? messageViewMode;
  String? emailNotificationMode;
  String? newRoomNotification;
  String? newMessageNotification;
  bool? muteFocusedConversations;
  num? notificationsSoundVolume;
  bool? useLegacyMessageTemplate;
  Preferences copyWith({  bool? enableAutoAway,
    num? idleTimeLimit,
    bool? desktopNotificationRequireInteraction,
    String? desktopNotifications,
    String? pushNotifications,
    bool? unreadAlert,
    bool? useEmojis,
    bool? convertAsciiEmoji,
    bool? autoImageLoad,
    bool? saveMobileBandwidth,
    bool? collapseMediaByDefault,
    bool? hideUsernames,
    bool? hideRoles,
    bool? hideFlexTab,
    bool? displayAvatars,
    bool? sidebarGroupByType,
    String? sidebarViewMode,
    bool? sidebarDisplayAvatar,
    bool? sidebarShowUnread,
    String? sidebarSortby,
    String? alsoSendThreadToChannel,
    bool? sidebarShowFavorites,
    String? sendOnEnter,
    num? messageViewMode,
    String? emailNotificationMode,
    String? newRoomNotification,
    String? newMessageNotification,
    bool? muteFocusedConversations,
    num? notificationsSoundVolume,
    bool? useLegacyMessageTemplate,
  }) => Preferences(  enableAutoAway: enableAutoAway ?? this.enableAutoAway,
    idleTimeLimit: idleTimeLimit ?? this.idleTimeLimit,
    desktopNotificationRequireInteraction: desktopNotificationRequireInteraction ?? this.desktopNotificationRequireInteraction,
    desktopNotifications: desktopNotifications ?? this.desktopNotifications,
    pushNotifications: pushNotifications ?? this.pushNotifications,
    unreadAlert: unreadAlert ?? this.unreadAlert,
    useEmojis: useEmojis ?? this.useEmojis,
    convertAsciiEmoji: convertAsciiEmoji ?? this.convertAsciiEmoji,
    autoImageLoad: autoImageLoad ?? this.autoImageLoad,
    saveMobileBandwidth: saveMobileBandwidth ?? this.saveMobileBandwidth,
    collapseMediaByDefault: collapseMediaByDefault ?? this.collapseMediaByDefault,
    hideUsernames: hideUsernames ?? this.hideUsernames,
    hideRoles: hideRoles ?? this.hideRoles,
    hideFlexTab: hideFlexTab ?? this.hideFlexTab,
    displayAvatars: displayAvatars ?? this.displayAvatars,
    sidebarGroupByType: sidebarGroupByType ?? this.sidebarGroupByType,
    sidebarViewMode: sidebarViewMode ?? this.sidebarViewMode,
    sidebarDisplayAvatar: sidebarDisplayAvatar ?? this.sidebarDisplayAvatar,
    sidebarShowUnread: sidebarShowUnread ?? this.sidebarShowUnread,
    sidebarSortby: sidebarSortby ?? this.sidebarSortby,
    alsoSendThreadToChannel: alsoSendThreadToChannel ?? this.alsoSendThreadToChannel,
    sidebarShowFavorites: sidebarShowFavorites ?? this.sidebarShowFavorites,
    sendOnEnter: sendOnEnter ?? this.sendOnEnter,
    messageViewMode: messageViewMode ?? this.messageViewMode,
    emailNotificationMode: emailNotificationMode ?? this.emailNotificationMode,
    newRoomNotification: newRoomNotification ?? this.newRoomNotification,
    newMessageNotification: newMessageNotification ?? this.newMessageNotification,
    muteFocusedConversations: muteFocusedConversations ?? this.muteFocusedConversations,
    notificationsSoundVolume: notificationsSoundVolume ?? this.notificationsSoundVolume,
    useLegacyMessageTemplate: useLegacyMessageTemplate ?? this.useLegacyMessageTemplate,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['enableAutoAway'] = enableAutoAway;
    map['idleTimeLimit'] = idleTimeLimit;
    map['desktopNotificationRequireInteraction'] = desktopNotificationRequireInteraction;
    map['desktopNotifications'] = desktopNotifications;
    map['pushNotifications'] = pushNotifications;
    map['unreadAlert'] = unreadAlert;
    map['useEmojis'] = useEmojis;
    map['convertAsciiEmoji'] = convertAsciiEmoji;
    map['autoImageLoad'] = autoImageLoad;
    map['saveMobileBandwidth'] = saveMobileBandwidth;
    map['collapseMediaByDefault'] = collapseMediaByDefault;
    map['hideUsernames'] = hideUsernames;
    map['hideRoles'] = hideRoles;
    map['hideFlexTab'] = hideFlexTab;
    map['displayAvatars'] = displayAvatars;
    map['sidebarGroupByType'] = sidebarGroupByType;
    map['sidebarViewMode'] = sidebarViewMode;
    map['sidebarDisplayAvatar'] = sidebarDisplayAvatar;
    map['sidebarShowUnread'] = sidebarShowUnread;
    map['sidebarSortby'] = sidebarSortby;
    map['alsoSendThreadToChannel'] = alsoSendThreadToChannel;
    map['sidebarShowFavorites'] = sidebarShowFavorites;
    map['sendOnEnter'] = sendOnEnter;
    map['messageViewMode'] = messageViewMode;
    map['emailNotificationMode'] = emailNotificationMode;
    map['newRoomNotification'] = newRoomNotification;
    map['newMessageNotification'] = newMessageNotification;
    map['muteFocusedConversations'] = muteFocusedConversations;
    map['notificationsSoundVolume'] = notificationsSoundVolume;
    map['useLegacyMessageTemplate'] = useLegacyMessageTemplate;
    return map;
  }

}

class Emails {
  Emails({
    this.address,
    this.verified,});

  Emails.fromJson(dynamic json) {
    address = json['address'];
    verified = json['verified'];
  }
  String? address;
  bool? verified;
  Emails copyWith({  String? address,
    bool? verified,
  }) => Emails(  address: address ?? this.address,
    verified: verified ?? this.verified,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address'] = address;
    map['verified'] = verified;
    return map;
  }

}

class Services {
  Services({
    this.password,
    this.email2fa,});

  Services.fromJson(dynamic json) {
    password = json['password'] != null ? Password.fromJson(json['password']) : null;
    email2fa = json['email2fa'] != null ? Email2fa.fromJson(json['email2fa']) : null;
  }
  Password? password;
  Email2fa? email2fa;
  Services copyWith({  Password? password,
    Email2fa? email2fa,
  }) => Services(  password: password ?? this.password,
    email2fa: email2fa ?? this.email2fa,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (password != null) {
      map['password'] = password?.toJson();
    }
    if (email2fa != null) {
      map['email2fa'] = email2fa?.toJson();
    }
    return map;
  }

}

class Email2fa {
  Email2fa({
    this.enabled,});

  Email2fa.fromJson(dynamic json) {
    enabled = json['enabled'];
  }
  bool? enabled;
  Email2fa copyWith({  bool? enabled,
  }) => Email2fa(  enabled: enabled ?? this.enabled,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['enabled'] = enabled;
    return map;
  }

}

class Password {
  Password({
    this.bcrypt,});

  Password.fromJson(dynamic json) {
    bcrypt = json['bcrypt'];
  }
  String? bcrypt;
  Password copyWith({  String? bcrypt,
  }) => Password(  bcrypt: bcrypt ?? this.bcrypt,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bcrypt'] = bcrypt;
    return map;
  }

}

class System {
  System({
    this.token,
    this.role,});

  System.fromJson(dynamic json) {
    token = json['token'];
    role = json['role'];
  }
  String? token;
  String? role;
  System copyWith({  String? token,
    String? role,
  }) => System(  token: token ?? this.token,
    role: role ?? this.role,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = token;
    map['role'] = role;
    return map;
  }

}