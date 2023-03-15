 
import 'dart:convert';

class PlacesResponse {
    PlacesResponse({
        required this.type,
        required this.query,
        required this.features,
        required this.attribution,
    });

    final String type;
    final List<String> query;
    final List<Feature> features;
    final String attribution;

    factory PlacesResponse.fromJson(String str) => PlacesResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PlacesResponse.fromMap(Map<String, dynamic> json) => PlacesResponse(
        type: json["type"],
        query: List<String>.from(json["query"].map((x) => x)),
        features: List<Feature>.from(json["features"].map((x) => Feature.fromMap(x))),
        attribution: json["attribution"],
    );

    Map<String, dynamic> toMap() => {
        "type": type,
        "query": List<dynamic>.from(query.map((x) => x)),
        "features": List<dynamic>.from(features.map((x) => x.toMap())),
        "attribution": attribution,
    };
}

class Feature {
    Feature({
        required this.id,
        required this.type,
        required this.placeType, 
        required this.properties,
        required this.textEn,
        required this.languageEn,
        required this.placeNameEn,
        required this.text,
        required this.language,
        required this.placeName, 
        required this.center,
        required this.geometry,
        required this.context,
        required this.matchingText,
        required this.matchingPlaceName,
    });

    final String id;
    final String type;
    final List<String> placeType; 
    final Properties properties;
    final String textEn;
    final Language? languageEn;
    final String placeNameEn;
    final String text;
    final Language? language;
    final String placeName; 
    final List<double> center;
    final Geometry geometry;
    final List<Context> context;
    final String matchingText;
    final String matchingPlaceName;

    factory Feature.fromJson(String str) => Feature.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Feature.fromMap(Map<String, dynamic> json) => Feature(
        id: json["id"],
        type: json["type"],
        placeType: List<String>.from(json["place_type"].map((x) => x)), 
        properties: Properties.fromMap(json["properties"]),
        textEn: json["text_en"],
        languageEn: languageValues.map[json["language_en"]],
        placeNameEn: json["place_name_en"],
        text: json["text"],
        language: languageValues.map[json["language"]],
        placeName: json["place_name"], 
        center: List<double>.from(json["center"].map((x) => x.toDouble())),
        geometry: Geometry.fromMap(json["geometry"]),
        context: List<Context>.from(json["context"].map((x) => Context.fromMap(x))),
        matchingText: json["matching_text"],
        matchingPlaceName: json["matching_place_name"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "type": type,
        "place_type": List<dynamic>.from(placeType.map((x) => x)), 
        "properties": properties.toMap(),
        "text_en": textEn,
        "language_en": languageValues.reverse[languageEn],
        "place_name_en": placeNameEn,
        "text": text,
        "language": languageValues.reverse[language],
        "place_name": placeName, 
        "center": List<dynamic>.from(center.map((x) => x)),
        "geometry": geometry.toMap(),
        "context": List<dynamic>.from(context.map((x) => x.toMap())),
        "matching_text": matchingText,
        "matching_place_name": matchingPlaceName,
    };
}

class Context {
    Context({
        required this.id,
        required this.shortCode,
        required this.wikidata,
        required this.mapboxId,
        required this.textEn,
        required this.languageEn,
        required this.text,
        required this.language,
    });

    final String id;
    final ShortCode? shortCode;
    final String wikidata;
    final String mapboxId;
    final String textEn;
    final Language? languageEn;
    final String text;
    final Language? language;

    factory Context.fromJson(String str) => Context.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Context.fromMap(Map<String, dynamic> json) => Context(
        id: json["id"],
        shortCode: shortCodeValues.map[json["short_code"]],
        wikidata: json["wikidata"],
        mapboxId: json["mapbox_id"],
        textEn: json["text_en"],
        languageEn: languageValues.map[json["language_en"]],
        text: json["text"],
        language: languageValues.map[json["language"]],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "short_code": shortCodeValues.reverse[shortCode],
        "wikidata": wikidata,
        "mapbox_id": mapboxId,
        "text_en": textEn,
        "language_en": languageValues.reverse[languageEn],
        "text": text,
        "language": languageValues.reverse[language],
    };
}

enum Language { EN }

final languageValues = EnumValues({
    "en": Language.EN
});

enum ShortCode { CA_ON, CA }

final shortCodeValues = EnumValues({
    "ca": ShortCode.CA,
    "CA-ON": ShortCode.CA_ON
});

class Geometry {
    Geometry({
        required this.type,
        required this.coordinates,
    });

    final String type;
    final List<double> coordinates;

    factory Geometry.fromJson(String str) => Geometry.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Geometry.fromMap(Map<String, dynamic> json) => Geometry(
        type: json["type"],
        coordinates: List<double>.from(json["coordinates"].map((x) => x.toDouble())),
    );

    Map<String, dynamic> toMap() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
    };
}

class Properties {
    Properties({
        required this.wikidata,
        required this.mapboxId,
        required this.foursquare,
        required this.address,
        required this.landmark,
        required this.category,
        required this.maki,
    });

    final String? wikidata;
    final String? mapboxId;
    final String? foursquare;
    final String? address;
    final bool? landmark;
    final String? category;
    final String? maki;

    factory Properties.fromJson(String str) => Properties.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Properties.fromMap(Map<String, dynamic> json) => Properties(
        wikidata: json["wikidata"],
        mapboxId: json["mapbox_id"],
        foursquare: json["foursquare"],
        address: json["address"],
        landmark: json["landmark"],
        category: json["category"],
        maki: json["maki"],
    );

    Map<String, dynamic> toMap() => {
        "wikidata": wikidata,
        "mapbox_id": mapboxId,
        "foursquare": foursquare,
        "address": address,
        "landmark": landmark,
        "category": category,
        "maki": maki,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String>? reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap ??= map.map((k, v) => MapEntry(v, k));
        return reverseMap!;
    }
}
