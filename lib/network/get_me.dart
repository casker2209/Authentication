class GetMeResponse {
  GetMeResponse({
    this.idSystem,
    this.id,
    this.createdAt,
    this.services,
    this.username,
    this.emails,
    this.type,
    this.status,
    this.active,
    this.roles,
    this.name,
    this.requirePasswordChange,
    this.lastLogin,
    this.statusConnection,
    this.canViewAllInfo,
    this.roomId,
    this.admin,
  });

  GetMeResponse.fromJson(dynamic json) {
    idSystem = json['idSystem'];
    id = json['_id'];
    createdAt = json['createdAt'];
    services =
        json['services'] != null ? Services.fromJson(json['services']) : null;
    username = json['username'];
    if (json['emails'] != null) {
      emails = [];
      json['emails'].forEach((v) {
        emails?.add(Emails.fromJson(v));
      });
    }
    type = json['type'];
    status = json['status'];
    active = json['active'];
    roles = json['roles'] != null ? json['roles'].cast<String>() : [];
    name = json['name'];
    requirePasswordChange = json['requirePasswordChange'];
    lastLogin = json['lastLogin'];
    statusConnection = json['statusConnection'];
    canViewAllInfo = json['canViewAllInfo'];
    roomId = json['roomId'];
    admin = json['admin'];
  }
  num? idSystem;
  String? id;
  String? createdAt;
  Services? services;
  String? username;
  List<Emails>? emails;
  String? type;
  String? status;
  bool? active;
  List<String>? roles;
  String? name;
  bool? requirePasswordChange;
  String? lastLogin;
  String? statusConnection;
  bool? canViewAllInfo;
  dynamic roomId;
  dynamic admin;
  GetMeResponse copyWith({
    num? idSystem,
    String? id,
    String? createdAt,
    Services? services,
    String? username,
    List<Emails>? emails,
    String? type,
    String? status,
    bool? active,
    List<String>? roles,
    String? name,
    bool? requirePasswordChange,
    String? lastLogin,
    String? statusConnection,
    bool? canViewAllInfo,
    dynamic roomId,
    dynamic admin,
  }) =>
      GetMeResponse(
        idSystem: idSystem ?? this.idSystem,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        services: services ?? this.services,
        username: username ?? this.username,
        emails: emails ?? this.emails,
        type: type ?? this.type,
        status: status ?? this.status,
        active: active ?? this.active,
        roles: roles ?? this.roles,
        name: name ?? this.name,
        requirePasswordChange:
            requirePasswordChange ?? this.requirePasswordChange,
        lastLogin: lastLogin ?? this.lastLogin,
        statusConnection: statusConnection ?? this.statusConnection,
        canViewAllInfo: canViewAllInfo ?? this.canViewAllInfo,
        roomId: roomId ?? this.roomId,
        admin: admin ?? this.admin,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['idSystem'] = idSystem;
    map['_id'] = id;
    map['createdAt'] = createdAt;
    if (services != null) {
      map['services'] = services?.toJson();
    }
    map['username'] = username;
    if (emails != null) {
      map['emails'] = emails?.map((v) => v.toJson()).toList();
    }
    map['type'] = type;
    map['status'] = status;
    map['active'] = active;
    map['roles'] = roles;
    map['name'] = name;
    map['requirePasswordChange'] = requirePasswordChange;
    map['lastLogin'] = lastLogin;
    map['statusConnection'] = statusConnection;
    map['canViewAllInfo'] = canViewAllInfo;
    map['roomId'] = roomId;
    map['admin'] = admin;
    return map;
  }
}

class Emails {
  Emails({
    this.address,
    this.verified,
  });

  Emails.fromJson(dynamic json) {
    address = json['address'];
    verified = json['verified'];
  }
  String? address;
  bool? verified;
  Emails copyWith({
    String? address,
    bool? verified,
  }) =>
      Emails(
        address: address ?? this.address,
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
    this.email2fa,
    this.resume,
  });

  Services.fromJson(dynamic json) {
    password =
        json['password'] != null ? Password.fromJson(json['password']) : null;
    email2fa =
        json['email2fa'] != null ? Email2fa.fromJson(json['email2fa']) : null;
    resume = json['resume'] != null ? Resume.fromJson(json['resume']) : null;
  }
  Password? password;
  Email2fa? email2fa;
  Resume? resume;
  Services copyWith({
    Password? password,
    Email2fa? email2fa,
    Resume? resume,
  }) =>
      Services(
        password: password ?? this.password,
        email2fa: email2fa ?? this.email2fa,
        resume: resume ?? this.resume,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (password != null) {
      map['password'] = password?.toJson();
    }
    if (email2fa != null) {
      map['email2fa'] = email2fa?.toJson();
    }
    if (resume != null) {
      map['resume'] = resume?.toJson();
    }
    return map;
  }
}

class Resume {
  Resume({
    this.loginTokens,
  });

  Resume.fromJson(dynamic json) {
    if (json['loginTokens'] != null) {
      loginTokens = [];
      json['loginTokens'].forEach((v) {
        loginTokens?.add(LoginTokens.fromJson(v));
      });
    }
  }
  List<LoginTokens>? loginTokens;
  Resume copyWith({
    List<LoginTokens>? loginTokens,
  }) =>
      Resume(
        loginTokens: loginTokens ?? this.loginTokens,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (loginTokens != null) {
      map['loginTokens'] = loginTokens?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class LoginTokens {
  LoginTokens({
    this.when,
    this.hashedToken,
  });

  LoginTokens.fromJson(dynamic json) {
    when = json['when'];
    hashedToken = json['hashedToken'];
  }
  String? when;
  String? hashedToken;
  LoginTokens copyWith({
    String? when,
    String? hashedToken,
  }) =>
      LoginTokens(
        when: when ?? this.when,
        hashedToken: hashedToken ?? this.hashedToken,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['when'] = when;
    map['hashedToken'] = hashedToken;
    return map;
  }
}

class Email2fa {
  Email2fa({
    this.enabled,
    this.changedAt,
  });

  Email2fa.fromJson(dynamic json) {
    enabled = json['enabled'];
    changedAt = json['changedAt'];
  }
  bool? enabled;
  String? changedAt;
  Email2fa copyWith({
    bool? enabled,
    String? changedAt,
  }) =>
      Email2fa(
        enabled: enabled ?? this.enabled,
        changedAt: changedAt ?? this.changedAt,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['enabled'] = enabled;
    map['changedAt'] = changedAt;
    return map;
  }
}

class Password {
  Password({
    this.bcrypt,
  });

  Password.fromJson(dynamic json) {
    bcrypt = json['bcrypt'];
  }
  String? bcrypt;
  Password copyWith({
    String? bcrypt,
  }) =>
      Password(
        bcrypt: bcrypt ?? this.bcrypt,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bcrypt'] = bcrypt;
    return map;
  }
}
