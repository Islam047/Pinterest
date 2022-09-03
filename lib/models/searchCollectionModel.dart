import 'dart:convert';
List<CollectionModel> parseAllCollection(String str) {
  List list = jsonDecode(str);
  List<CollectionModel> user = list.map((e) => CollectionModel.fromJson(e)).toList();
  return user;
}
CollectionModel collectionModelFromJson(String str) =>
    CollectionModel.fromJson(json.decode(str));

String collectionModelToJson(CollectionModel data) =>
    json.encode(data.toJson());

class CollectionModel {
  CollectionModel({
    this.id,
    this.title,
    this.description,
    this.publishedAt,
    this.lastCollectedAt,
    this.updatedAt,
    this.curated,
    this.featured,
    this.totalPhotos,
    this.private,
    this.shareKey,
    this.tags,
    this.links,
    this.user,
    this.coverPhoto,
    this.previewPhotos,
  });

  CollectionModel.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    publishedAt = json['published_at'];
    lastCollectedAt = json['last_collected_at'];
    updatedAt = json['updated_at'];
    curated = json['curated'];
    featured = json['featured'];
    totalPhotos = json['total_photos'];
    private = json['private'];
    shareKey = json['share_key'];
    if (json['tags'] != null) {
      tags = [];
      json['tags'].forEach((v) {
        tags?.add(Tags.fromJson(v));
      });
    }
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    coverPhoto = json['cover_photo'] != null
        ? CoverPhoto.fromJson(json['cover_photo'])
        : null;
    if (json['preview_photos'] != null) {
      previewPhotos = [];
      json['preview_photos'].forEach((v) {
        previewPhotos?.add(PreviewPhotos.fromJson(v));
      });
    }
  }

  String? id;
  String? title;
  dynamic description;
  String? publishedAt;
  String? lastCollectedAt;
  String? updatedAt;
  bool? curated;
  bool? featured;
  int? totalPhotos;
  bool? private;
  String? shareKey;
  List<Tags>? tags;
  Links? links;
  User? user;
  CoverPhoto? coverPhoto;
  List<PreviewPhotos>? previewPhotos;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['published_at'] = publishedAt;
    map['last_collected_at'] = lastCollectedAt;
    map['updated_at'] = updatedAt;
    map['curated'] = curated;
    map['featured'] = featured;
    map['total_photos'] = totalPhotos;
    map['private'] = private;
    map['share_key'] = shareKey;
    if (tags != null) {
      map['tags'] = tags?.map((v) => v.toJson()).toList();
    }
    if (links != null) {
      map['links'] = links?.toJson();
    }
    if (user != null) {
      map['user'] = user?.toJson();
    }
    if (coverPhoto != null) {
      map['cover_photo'] = coverPhoto?.toJson();
    }
    if (previewPhotos != null) {
      map['preview_photos'] = previewPhotos?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

PreviewPhotos previewPhotosFromJson(String str) =>
    PreviewPhotos.fromJson(json.decode(str));

String previewPhotosToJson(PreviewPhotos data) => json.encode(data.toJson());

class PreviewPhotos {
  PreviewPhotos({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.blurHash,
    this.urls,
  });

  PreviewPhotos.fromJson(dynamic json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    blurHash = json['blur_hash'];
    urls = json['urls'] != null ? Urls.fromJson(json['urls']) : null;
  }

  String? id;
  String? createdAt;
  String? updatedAt;
  String? blurHash;
  Urls? urls;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['blur_hash'] = blurHash;
    if (urls != null) {
      map['urls'] = urls?.toJson();
    }
    return map;
  }
}

Urls urlsFromJson(String str) => Urls.fromJson(json.decode(str));

String urlsToJson(Urls data) => json.encode(data.toJson());

class Urls {
  Urls({
    this.raw,
    this.full,
    this.regular,
    this.small,
    this.thumb,
    this.smallS3,
  });

  Urls.fromJson(dynamic json) {
    raw = json['raw'];
    full = json['full'];
    regular = json['regular'];
    small = json['small'];
    thumb = json['thumb'];
    smallS3 = json['small_s3'];
  }

  String? raw;
  String? full;
  String? regular;
  String? small;
  String? thumb;
  String? smallS3;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['raw'] = raw;
    map['full'] = full;
    map['regular'] = regular;
    map['small'] = small;
    map['thumb'] = thumb;
    map['small_s3'] = smallS3;
    return map;
  }
}

CoverPhoto coverPhotoFromJson(String str) =>
    CoverPhoto.fromJson(json.decode(str));

String coverPhotoToJson(CoverPhoto data) => json.encode(data.toJson());

class CoverPhoto {
  CoverPhoto({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.promotedAt,
    this.width,
    this.height,
    this.color,
    this.blurHash,
    this.description,
    this.altDescription,
    this.urls,
    this.links,
    this.categories,
    this.likes,
    this.likedByUser,
    this.currentUserCollections,
    this.sponsorship,
    this.topicSubmissions,
    this.user,
  });

  CoverPhoto.fromJson(dynamic json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    promotedAt = json['promoted_at'];
    width = json['width'];
    height = json['height'];
    color = json['color'];
    blurHash = json['blur_hash'];
    description = json['description'];
    altDescription = json['alt_description'];
    urls = json['urls'] != null ? Urls.fromJson(json['urls']) : null;
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((v) {
        categories?.add(v.fromJson(v));
      });
    }
    likes = json['likes'];
    likedByUser = json['liked_by_user'];
    if (json['current_user_collections'] != null) {
      currentUserCollections = [];
      json['current_user_collections'].forEach((v) {
        currentUserCollections?.add(v.fromJson(v));
      });
    }
    sponsorship = json['sponsorship'];
    topicSubmissions = json['topic_submissions'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  String? id;
  String? createdAt;
  String? updatedAt;
  dynamic promotedAt;
  int? width;
  int? height;
  String? color;
  String? blurHash;
  String? description;
  String? altDescription;
  Urls? urls;
  Links? links;
  List<dynamic>? categories;
  int? likes;
  bool? likedByUser;
  List<dynamic>? currentUserCollections;
  dynamic sponsorship;
  dynamic topicSubmissions;
  User? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['promoted_at'] = promotedAt;
    map['width'] = width;
    map['height'] = height;
    map['color'] = color;
    map['blur_hash'] = blurHash;
    map['description'] = description;
    map['alt_description'] = altDescription;
    if (urls != null) {
      map['urls'] = urls?.toJson();
    }
    if (links != null) {
      map['links'] = links?.toJson();
    }
    if (categories != null) {
      map['categories'] = categories?.map((v) => v.toJson()).toList();
    }
    map['likes'] = likes;
    map['liked_by_user'] = likedByUser;
    if (currentUserCollections != null) {
      map['current_user_collections'] =
          currentUserCollections?.map((v) => v.toJson()).toList();
    }
    map['sponsorship'] = sponsorship;
    map['topic_submissions'] = topicSubmissions;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }
}

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.id,
    this.updatedAt,
    this.username,
    this.name,
    this.firstName,
    this.lastName,
    this.twitterUsername,
    this.portfolioUrl,
    this.bio,
    this.location,
    this.links,
    this.profileImage,
    this.instagramUsername,
    this.totalCollections,
    this.totalLikes,
    this.totalPhotos,
    this.acceptedTos,
    this.forHire,
    this.social,
  });

  User.fromJson(dynamic json) {
    id = json['id'];
    updatedAt = json['updated_at'];
    username = json['username'];
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    twitterUsername = json['twitter_username'];
    portfolioUrl = json['portfolio_url'];
    bio = json['bio'];
    location = json['location'];
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
    profileImage = json['profile_image'] != null
        ? ProfileImage.fromJson(json['profile_image'])
        : null;
    instagramUsername = json['instagram_username'];
    totalCollections = json['total_collections'];
    totalLikes = json['total_likes'];
    totalPhotos = json['total_photos'];
    acceptedTos = json['accepted_tos'];
    forHire = json['for_hire'];
    social = json['social'] != null ? Social.fromJson(json['social']) : null;
  }

  String? id;
  String? updatedAt;
  String? username;
  String? name;
  String? firstName;
  String? lastName;
  String? twitterUsername;
  String? portfolioUrl;
  String? bio;
  String? location;
  Links? links;
  ProfileImage? profileImage;
  String? instagramUsername;
  int? totalCollections;
  int? totalLikes;
  int? totalPhotos;
  bool? acceptedTos;
  bool? forHire;
  Social? social;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['updated_at'] = updatedAt;
    map['username'] = username;
    map['name'] = name;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['twitter_username'] = twitterUsername;
    map['portfolio_url'] = portfolioUrl;
    map['bio'] = bio;
    map['location'] = location;
    if (links != null) {
      map['links'] = links?.toJson();
    }
    if (profileImage != null) {
      map['profile_image'] = profileImage?.toJson();
    }
    map['instagram_username'] = instagramUsername;
    map['total_collections'] = totalCollections;
    map['total_likes'] = totalLikes;
    map['total_photos'] = totalPhotos;
    map['accepted_tos'] = acceptedTos;
    map['for_hire'] = forHire;
    if (social != null) {
      map['social'] = social?.toJson();
    }
    return map;
  }
}

Social socialFromJson(String str) => Social.fromJson(json.decode(str));

String socialToJson(Social data) => json.encode(data.toJson());

class Social {
  Social({
    this.instagramUsername,
    this.portfolioUrl,
    this.twitterUsername,
    this.paypalEmail,
  });

  Social.fromJson(dynamic json) {
    instagramUsername = json['instagram_username'];
    portfolioUrl = json['portfolio_url'];
    twitterUsername = json['twitter_username'];
    paypalEmail = json['paypal_email'];
  }

  String? instagramUsername;
  String? portfolioUrl;
  String? twitterUsername;
  dynamic paypalEmail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['instagram_username'] = instagramUsername;
    map['portfolio_url'] = portfolioUrl;
    map['twitter_username'] = twitterUsername;
    map['paypal_email'] = paypalEmail;
    return map;
  }
}

ProfileImage profileImageFromJson(String str) =>
    ProfileImage.fromJson(json.decode(str));

String profileImageToJson(ProfileImage data) => json.encode(data.toJson());

class ProfileImage {
  ProfileImage({
    this.small,
    this.medium,
    this.large,
  });

  ProfileImage.fromJson(dynamic json) {
    small = json['small'];
    medium = json['medium'];
    large = json['large'];
  }

  String? small;
  String? medium;
  String? large;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['small'] = small;
    map['medium'] = medium;
    map['large'] = large;
    return map;
  }
}

Links linksFromJson(String str) => Links.fromJson(json.decode(str));

String linksToJson(Links data) => json.encode(data.toJson());

class Links {
  Links({
    this.self,
    this.html,
    this.photos,
    this.likes,
    this.portfolio,
    this.following,
    this.followers,
  });

  Links.fromJson(dynamic json) {
    self = json['self'];
    html = json['html'];
    photos = json['photos'];
    likes = json['likes'];
    portfolio = json['portfolio'];
    following = json['following'];
    followers = json['followers'];
  }

  String? self;
  String? html;
  String? photos;
  String? likes;
  String? portfolio;
  String? following;
  String? followers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['self'] = self;
    map['html'] = html;
    map['photos'] = photos;
    map['likes'] = likes;
    map['portfolio'] = portfolio;
    map['following'] = following;
    map['followers'] = followers;
    return map;
  }
}

Tags tagsFromJson(String str) => Tags.fromJson(json.decode(str));

String tagsToJson(Tags data) => json.encode(data.toJson());

class Tags {
  Tags({
    this.type,
    this.title,
    this.source,
  });

  Tags.fromJson(dynamic json) {
    type = json['type'];
    title = json['title'];
    source = json['source'] != null ? Source.fromJson(json['source']) : null;
  }

  String? type;
  String? title;
  Source? source;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['title'] = title;
    if (source != null) {
      map['source'] = source?.toJson();
    }
    return map;
  }
}

Source sourceFromJson(String str) => Source.fromJson(json.decode(str));

String sourceToJson(Source data) => json.encode(data.toJson());

class Source {
  Source({
    this.ancestry,
    this.title,
    this.subtitle,
    this.description,
    this.metaTitle,
    this.metaDescription,
    this.coverPhoto,
  });

  Source.fromJson(dynamic json) {
    ancestry =
        json['ancestry'] != null ? Ancestry.fromJson(json['ancestry']) : null;
    title = json['title'];
    subtitle = json['subtitle'];
    description = json['description'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    coverPhoto = json['cover_photo'] != null
        ? CoverPhoto.fromJson(json['cover_photo'])
        : null;
  }

  Ancestry? ancestry;
  String? title;
  String? subtitle;
  String? description;
  String? metaTitle;
  String? metaDescription;
  CoverPhoto? coverPhoto;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (ancestry != null) {
      map['ancestry'] = ancestry?.toJson();
    }
    map['title'] = title;
    map['subtitle'] = subtitle;
    map['description'] = description;
    map['meta_title'] = metaTitle;
    map['meta_description'] = metaDescription;
    if (coverPhoto != null) {
      map['cover_photo'] = coverPhoto?.toJson();
    }
    return map;
  }
}

TopicSubmissions topicSubmissionsFromJson(String str) =>
    TopicSubmissions.fromJson(json.decode(str));

String topicSubmissionsToJson(TopicSubmissions data) =>
    json.encode(data.toJson());

class TopicSubmissions {
  TopicSubmissions({
    this.spirituality,
    this.experimental,
    this.wallpapers,
  });

  TopicSubmissions.fromJson(dynamic json) {
    spirituality = json['spirituality'] != null
        ? Spirituality.fromJson(json['spirituality'])
        : null;
    experimental = json['experimental'] != null
        ? Experimental.fromJson(json['experimental'])
        : null;
    wallpapers = json['wallpapers'] != null
        ? Wallpapers.fromJson(json['wallpapers'])
        : null;
  }

  Spirituality? spirituality;
  Experimental? experimental;
  Wallpapers? wallpapers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (spirituality != null) {
      map['spirituality'] = spirituality?.toJson();
    }
    if (experimental != null) {
      map['experimental'] = experimental?.toJson();
    }
    if (wallpapers != null) {
      map['wallpapers'] = wallpapers?.toJson();
    }
    return map;
  }
}

Wallpapers wallpapersFromJson(String str) =>
    Wallpapers.fromJson(json.decode(str));

String wallpapersToJson(Wallpapers data) => json.encode(data.toJson());

class Wallpapers {
  Wallpapers({
    this.status,
    this.approvedOn,
  });

  Wallpapers.fromJson(dynamic json) {
    status = json['status'];
    approvedOn = json['approved_on'];
  }

  String? status;
  String? approvedOn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['approved_on'] = approvedOn;
    return map;
  }
}

Experimental experimentalFromJson(String str) =>
    Experimental.fromJson(json.decode(str));

String experimentalToJson(Experimental data) => json.encode(data.toJson());

class Experimental {
  Experimental({
    this.status,
    this.approvedOn,
  });

  Experimental.fromJson(dynamic json) {
    status = json['status'];
    approvedOn = json['approved_on'];
  }

  String? status;
  String? approvedOn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['approved_on'] = approvedOn;
    return map;
  }
}

Spirituality spiritualityFromJson(String str) =>
    Spirituality.fromJson(json.decode(str));

String spiritualityToJson(Spirituality data) => json.encode(data.toJson());

class Spirituality {
  Spirituality({
    this.status,
    this.approvedOn,
  });

  Spirituality.fromJson(dynamic json) {
    status = json['status'];
    approvedOn = json['approved_on'];
  }

  String? status;
  String? approvedOn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['approved_on'] = approvedOn;
    return map;
  }
}

Ancestry ancestryFromJson(String str) => Ancestry.fromJson(json.decode(str));

String ancestryToJson(Ancestry data) => json.encode(data.toJson());

class Ancestry {
  Ancestry({
    this.type,
    this.category,
    this.subcategory,
  });

  Ancestry.fromJson(dynamic json) {
    type = json['type'] != null ? Type.fromJson(json['type']) : null;
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    subcategory = json['subcategory'] != null
        ? Subcategory.fromJson(json['subcategory'])
        : null;
  }

  Type? type;
  Category? category;
  Subcategory? subcategory;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (type != null) {
      map['type'] = type?.toJson();
    }
    if (category != null) {
      map['category'] = category?.toJson();
    }
    if (subcategory != null) {
      map['subcategory'] = subcategory?.toJson();
    }
    return map;
  }
}

Subcategory subcategoryFromJson(String str) =>
    Subcategory.fromJson(json.decode(str));

String subcategoryToJson(Subcategory data) => json.encode(data.toJson());

class Subcategory {
  Subcategory({
    this.slug,
    this.prettySlug,
  });

  Subcategory.fromJson(dynamic json) {
    slug = json['slug'];
    prettySlug = json['pretty_slug'];
  }

  String? slug;
  String? prettySlug;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['slug'] = slug;
    map['pretty_slug'] = prettySlug;
    return map;
  }
}

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  Category({
    this.slug,
    this.prettySlug,
  });

  Category.fromJson(dynamic json) {
    slug = json['slug'];
    prettySlug = json['pretty_slug'];
  }

  String? slug;
  String? prettySlug;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['slug'] = slug;
    map['pretty_slug'] = prettySlug;
    return map;
  }
}

Type typeFromJson(String str) => Type.fromJson(json.decode(str));

String typeToJson(Type data) => json.encode(data.toJson());

class Type {
  Type({
    this.slug,
    this.prettySlug,
  });

  Type.fromJson(dynamic json) {
    slug = json['slug'];
    prettySlug = json['pretty_slug'];
  }

  String? slug;
  String? prettySlug;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['slug'] = slug;
    map['pretty_slug'] = prettySlug;
    return map;
  }
}
