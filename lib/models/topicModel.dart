import 'dart:convert';
List<TopicModel> parseAllTopic(String str) {
  List list = jsonDecode(str);
  List<TopicModel> user = list.map((e) => TopicModel.fromJson(e)).toList();
  return user;
}
TopicModel topicModelFromJson(String str) => TopicModel.fromJson(json.decode(str));
String topicModelToJson(TopicModel data) => json.encode(data.toJson());
class TopicModel {
  TopicModel({
      this.id, 
      this.slug, 
      this.title, 
      this.description, 
      this.publishedAt, 
      this.updatedAt, 
      this.startsAt, 
      this.endsAt, 
      this.onlySubmissionsAfter, 
      this.visibility, 
      this.featured, 
      this.totalPhotos, 
      this.currentUserContributions, 
      this.totalCurrentUserSubmissions, 
      this.links, 
      this.status, 
      this.owners, 
      this.topContributors, 
      this.coverPhoto, 
      this.previewPhotos,});

  TopicModel.fromJson(Map<String,dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    title = json['title'];
    description = json['description'];
    publishedAt = json['published_at'];
    updatedAt = json['updated_at'];
    startsAt = json['starts_at'];
    endsAt = json['ends_at'];
    onlySubmissionsAfter = json['only_submissions_after'];
    visibility = json['visibility'];
    featured = json['featured'];
    totalPhotos = json['total_photos'];
    if (json['current_user_contributions'] != null) {
      currentUserContributions = [];
      json['current_user_contributions'].forEach((v) {
        currentUserContributions?.add(v.fromJson(v));
      });
    }
    totalCurrentUserSubmissions = json['total_current_user_submissions'];
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
    status = json['status'];
    if (json['owners'] != null) {
      owners = [];
      json['owners'].forEach((v) {
        owners?.add(Owners.fromJson(v));
      });
    }
    if (json['top_contributors'] != null) {
      topContributors = [];
      json['top_contributors'].forEach((v) {
        topContributors?.add(TopContributors.fromJson(v));
      });
    }
    coverPhoto = json['cover_photo'] != null ? CoverPhoto.fromJson(json['cover_photo']) : null;
    if (json['preview_photos'] != null) {
      previewPhotos = [];
      json['preview_photos'].forEach((v) {
        previewPhotos?.add(PreviewPhotos.fromJson(v));
      });
    }
  }
  String? id;
  String? slug;
  String? title;
  String? description;
  String? publishedAt;
  String? updatedAt;
  String? startsAt;
  dynamic endsAt;
  dynamic onlySubmissionsAfter;
  String? visibility;
  bool? featured;
  int? totalPhotos;
  List<dynamic>? currentUserContributions;
  dynamic totalCurrentUserSubmissions;
  Links? links;
  String? status;
  List<Owners>? owners;
  List<TopContributors>? topContributors;
  CoverPhoto? coverPhoto;
  List<PreviewPhotos>? previewPhotos;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['slug'] = slug;
    map['title'] = title;
    map['description'] = description;
    map['published_at'] = publishedAt;
    map['updated_at'] = updatedAt;
    map['starts_at'] = startsAt;
    map['ends_at'] = endsAt;
    map['only_submissions_after'] = onlySubmissionsAfter;
    map['visibility'] = visibility;
    map['featured'] = featured;
    map['total_photos'] = totalPhotos;
    if (currentUserContributions != null) {
      map['current_user_contributions'] = currentUserContributions?.map((v) => v.toJson()).toList();
    }
    map['total_current_user_submissions'] = totalCurrentUserSubmissions;
    if (links != null) {
      map['links'] = links?.toJson();
    }
    map['status'] = status;
    if (owners != null) {
      map['owners'] = owners?.map((v) => v.toJson()).toList();
    }
    if (topContributors != null) {
      map['top_contributors'] = topContributors?.map((v) => v.toJson()).toList();
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

PreviewPhotos previewPhotosFromJson(String str) => PreviewPhotos.fromJson(json.decode(str));
String previewPhotosToJson(PreviewPhotos data) => json.encode(data.toJson());
class PreviewPhotos {
  PreviewPhotos({
      this.id, 
      this.createdAt, 
      this.updatedAt, 
      this.blurHash, 
      this.urls,});

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
      this.smallS3,});

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
List<CoverPhoto> parseAllCover(String str) {
  List list = jsonDecode(str);
  List<CoverPhoto> user = list.map((e) => CoverPhoto.fromJson(e)).toList();
  return user;
}
CoverPhoto coverPhotoFromJson(String str) => CoverPhoto.fromJson(json.decode(str));
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
      this.user,});

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
    topicSubmissions = json['topic_submissions'] != null ? TopicSubmissions.fromJson(json['topic_submissions']) : null;
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
  dynamic description;
  String? altDescription;
  Urls? urls;
  Links? links;
  List<dynamic>? categories;
  int? likes;
  bool? likedByUser;
  List<dynamic>? currentUserCollections;
  dynamic sponsorship;
  TopicSubmissions? topicSubmissions;
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
      map['current_user_collections'] = currentUserCollections?.map((v) => v.toJson()).toList();
    }
    map['sponsorship'] = sponsorship;
    if (topicSubmissions != null) {
      map['topic_submissions'] = topicSubmissions?.toJson();
    }
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
      this.social,});

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
    profileImage = json['profile_image'] != null ? ProfileImage.fromJson(json['profile_image']) : null;
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
  dynamic twitterUsername;
  dynamic portfolioUrl;
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
      this.paypalEmail,});

  Social.fromJson(dynamic json) {
    instagramUsername = json['instagram_username'];
    portfolioUrl = json['portfolio_url'];
    twitterUsername = json['twitter_username'];
    paypalEmail = json['paypal_email'];
  }
  String? instagramUsername;
  dynamic portfolioUrl;
  dynamic twitterUsername;
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

ProfileImage profileImageFromJson(String str) => ProfileImage.fromJson(json.decode(str));
String profileImageToJson(ProfileImage data) => json.encode(data.toJson());
class ProfileImage {
  ProfileImage({
      this.small, 
      this.medium, 
      this.large,});

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
      this.followers,});

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

TopicSubmissions topicSubmissionsFromJson(String str) => TopicSubmissions.fromJson(json.decode(str));
String topicSubmissionsToJson(TopicSubmissions data) => json.encode(data.toJson());
class TopicSubmissions {
  TopicSubmissions({
      this.experimental, 
      this.wallpapers, 
      this.travel,});

  TopicSubmissions.fromJson(dynamic json) {
    experimental = json['experimental'] != null ? Experimental.fromJson(json['experimental']) : null;
    wallpapers = json['wallpapers'] != null ? Wallpapers.fromJson(json['wallpapers']) : null;
    travel = json['travel'] != null ? Travel.fromJson(json['travel']) : null;
  }
  Experimental? experimental;
  Wallpapers? wallpapers;
  Travel? travel;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (experimental != null) {
      map['experimental'] = experimental?.toJson();
    }
    if (wallpapers != null) {
      map['wallpapers'] = wallpapers?.toJson();
    }
    if (travel != null) {
      map['travel'] = travel?.toJson();
    }
    return map;
  }

}

Travel travelFromJson(String str) => Travel.fromJson(json.decode(str));
String travelToJson(Travel data) => json.encode(data.toJson());
class Travel {
  Travel({
      this.status,});

  Travel.fromJson(dynamic json) {
    status = json['status'];
  }
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    return map;
  }

}

Wallpapers wallpapersFromJson(String str) => Wallpapers.fromJson(json.decode(str));
String wallpapersToJson(Wallpapers data) => json.encode(data.toJson());
class Wallpapers {
  Wallpapers({
      this.status, 
      this.approvedOn,});

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

Experimental experimentalFromJson(String str) => Experimental.fromJson(json.decode(str));
String experimentalToJson(Experimental data) => json.encode(data.toJson());
class Experimental {
  Experimental({
      this.status,});

  Experimental.fromJson(dynamic json) {
    status = json['status'];
  }
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    return map;
  }

}

TopContributors topContributorsFromJson(String str) => TopContributors.fromJson(json.decode(str));
String topContributorsToJson(TopContributors data) => json.encode(data.toJson());
class TopContributors {
  TopContributors({
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
      this.social,});

  TopContributors.fromJson(dynamic json) {
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
    profileImage = json['profile_image'] != null ? ProfileImage.fromJson(json['profile_image']) : null;
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
  dynamic twitterUsername;
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

Owners ownersFromJson(String str) => Owners.fromJson(json.decode(str));
String ownersToJson(Owners data) => json.encode(data.toJson());
class Owners {
  Owners({
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
      this.social,});

  Owners.fromJson(dynamic json) {
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
    profileImage = json['profile_image'] != null ? ProfileImage.fromJson(json['profile_image']) : null;
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
  dynamic lastName;
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
