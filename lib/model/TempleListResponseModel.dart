class TempleListResponseModel {
  final List<dynamic>? htmlAttributions;
  final String? nextPageToken;
  final List<Results>? results;
  final String? status;

  TempleListResponseModel({
    this.htmlAttributions,
    this.nextPageToken,
    this.results,
    this.status,
  });

  TempleListResponseModel.fromJson(Map<String, dynamic> json)
      : htmlAttributions = json['html_attributions'] as List?,
        nextPageToken = json['next_page_token'] as String?,
        results = (json['results'] as List?)?.map((dynamic e) => Results.fromJson(e as Map<String,dynamic>)).toList(),
        status = json['status'] as String?;

  Map<String, dynamic> toJson() => {
    'html_attributions' : htmlAttributions,
    'next_page_token' : nextPageToken,
    'results' : results?.map((e) => e.toJson()).toList(),
    'status' : status
  };
}

class Results {
  final String? businessStatus;
  final Geometry? geometry;
  final String? icon;
  final String? iconBackgroundColor;
  final String? iconMaskBaseUri;
  final String? name;
  final List<Photos>? photos;
  final String? placeId;
  final PlusCode? plusCode;
  final num? rating;
  final String? reference;
  final String? scope;
  final List<String>? types;
  final num? userRatingsTotal;
  final String? vicinity;

  Results({
    this.businessStatus,
    this.geometry,
    this.icon,
    this.iconBackgroundColor,
    this.iconMaskBaseUri,
    this.name,
    this.photos,
    this.placeId,
    this.plusCode,
    this.rating,
    this.reference,
    this.scope,
    this.types,
    this.userRatingsTotal,
    this.vicinity,
  });

  Results.fromJson(Map<String, dynamic> json)
      : businessStatus = json['business_status'] as String?,
        geometry = (json['geometry'] as Map<String,dynamic>?) != null ? Geometry.fromJson(json['geometry'] as Map<String,dynamic>) : null,
        icon = json['icon'] as String?,
        iconBackgroundColor = json['icon_background_color'] as String?,
        iconMaskBaseUri = json['icon_mask_base_uri'] as String?,
        name = json['name'] as String?,
        photos = (json['photos'] as List?)?.map((dynamic e) => Photos.fromJson(e as Map<String,dynamic>)).toList(),
        placeId = json['place_id'] as String?,
        plusCode = (json['plus_code'] as Map<String,dynamic>?) != null ? PlusCode.fromJson(json['plus_code'] as Map<String,dynamic>) : null,
        rating = json['rating'] as num?,
        reference = json['reference'] as String?,
        scope = json['scope'] as String?,
        types = (json['types'] as List?)?.map((dynamic e) => e as String).toList(),
        userRatingsTotal = json['user_ratings_total'] as num?,
        vicinity = json['vicinity'] as String?;

  Map<String, dynamic> toJson() => {
    'business_status' : businessStatus,
    'geometry' : geometry?.toJson(),
    'icon' : icon,
    'icon_background_color' : iconBackgroundColor,
    'icon_mask_base_uri' : iconMaskBaseUri,
    'name' : name,
    'photos' : photos?.map((e) => e.toJson()).toList(),
    'place_id' : placeId,
    'plus_code' : plusCode?.toJson(),
    'rating' : rating,
    'reference' : reference,
    'scope' : scope,
    'types' : types,
    'user_ratings_total' : userRatingsTotal,
    'vicinity' : vicinity
  };
}

class Geometry {
  final Location? location;
  final Viewport? viewport;

  Geometry({
    this.location,
    this.viewport,
  });

  Geometry.fromJson(Map<String, dynamic> json)
      : location = (json['location'] as Map<String,dynamic>?) != null ? Location.fromJson(json['location'] as Map<String,dynamic>) : null,
        viewport = (json['viewport'] as Map<String,dynamic>?) != null ? Viewport.fromJson(json['viewport'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'location' : location?.toJson(),
    'viewport' : viewport?.toJson()
  };
}

class Location {
  final num? lat;
  final num? lng;

  Location({
    this.lat,
    this.lng,
  });

  Location.fromJson(Map<String, dynamic> json)
      : lat = json['lat'] as num?,
        lng = json['lng'] as num?;

  Map<String, dynamic> toJson() => {
    'lat' : lat,
    'lng' : lng
  };
}

class Viewport {
  final Northeast? northeast;
  final Southwest? southwest;

  Viewport({
    this.northeast,
    this.southwest,
  });

  Viewport.fromJson(Map<String, dynamic> json)
      : northeast = (json['northeast'] as Map<String,dynamic>?) != null ? Northeast.fromJson(json['northeast'] as Map<String,dynamic>) : null,
        southwest = (json['southwest'] as Map<String,dynamic>?) != null ? Southwest.fromJson(json['southwest'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'northeast' : northeast?.toJson(),
    'southwest' : southwest?.toJson()
  };
}

class Northeast {
  final num? lat;
  final num? lng;

  Northeast({
    this.lat,
    this.lng,
  });

  Northeast.fromJson(Map<String, dynamic> json)
      : lat = json['lat'] as num?,
        lng = json['lng'] as num?;

  Map<String, dynamic> toJson() => {
    'lat' : lat,
    'lng' : lng
  };
}

class Southwest {
  final num? lat;
  final num? lng;

  Southwest({
    this.lat,
    this.lng,
  });

  Southwest.fromJson(Map<String, dynamic> json)
      : lat = json['lat'] as num?,
        lng = json['lng'] as num?;

  Map<String, dynamic> toJson() => {
    'lat' : lat,
    'lng' : lng
  };
}

class Photos {
  final num? height;
  final List<String>? htmlAttributions;
  final String? photoReference;
  final num? width;

  Photos({
    this.height,
    this.htmlAttributions,
    this.photoReference,
    this.width,
  });

  Photos.fromJson(Map<String, dynamic> json)
      : height = json['height'] as num?,
        htmlAttributions = (json['html_attributions'] as List?)?.map((dynamic e) => e as String).toList(),
        photoReference = json['photo_reference'] as String?,
        width = json['width'] as num?;

  Map<String, dynamic> toJson() => {
    'height' : height,
    'html_attributions' : htmlAttributions,
    'photo_reference' : photoReference,
    'width' : width
  };
}

class PlusCode {
  final String? compoundCode;
  final String? globalCode;

  PlusCode({
    this.compoundCode,
    this.globalCode,
  });

  PlusCode.fromJson(Map<String, dynamic> json)
      : compoundCode = json['compound_code'] as String?,
        globalCode = json['global_code'] as String?;

  Map<String, dynamic> toJson() => {
    'compound_code' : compoundCode,
    'global_code' : globalCode
  };
}