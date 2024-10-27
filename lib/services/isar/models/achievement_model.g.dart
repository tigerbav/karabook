// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAchievementModelCollection on Isar {
  IsarCollection<AchievementModel> get achievementModels => this.collection();
}

const AchievementModelSchema = CollectionSchema(
  name: r'AchievementModel',
  id: -2648282601373786305,
  properties: {
    r'descriptionKey': PropertySchema(
      id: 0,
      name: r'descriptionKey',
      type: IsarType.string,
    ),
    r'enabled': PropertySchema(
      id: 1,
      name: r'enabled',
      type: IsarType.bool,
    ),
    r'image': PropertySchema(
      id: 2,
      name: r'image',
      type: IsarType.string,
    ),
    r'maxPoints': PropertySchema(
      id: 3,
      name: r'maxPoints',
      type: IsarType.long,
    ),
    r'modifiedDate': PropertySchema(
      id: 4,
      name: r'modifiedDate',
      type: IsarType.long,
    ),
    r'nameKey': PropertySchema(
      id: 5,
      name: r'nameKey',
      type: IsarType.string,
    )
  },
  estimateSize: _achievementModelEstimateSize,
  serialize: _achievementModelSerialize,
  deserialize: _achievementModelDeserialize,
  deserializeProp: _achievementModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _achievementModelGetId,
  getLinks: _achievementModelGetLinks,
  attach: _achievementModelAttach,
  version: '3.1.0+1',
);

int _achievementModelEstimateSize(
  AchievementModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.descriptionKey;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.image;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.nameKey;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _achievementModelSerialize(
  AchievementModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.descriptionKey);
  writer.writeBool(offsets[1], object.enabled);
  writer.writeString(offsets[2], object.image);
  writer.writeLong(offsets[3], object.maxPoints);
  writer.writeLong(offsets[4], object.modifiedDate);
  writer.writeString(offsets[5], object.nameKey);
}

AchievementModel _achievementModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AchievementModel(
    descriptionKey: reader.readStringOrNull(offsets[0]),
    enabled: reader.readBoolOrNull(offsets[1]) ?? false,
    id: id,
    image: reader.readStringOrNull(offsets[2]),
    maxPoints: reader.readLongOrNull(offsets[3]) ?? 0,
    modifiedDate: reader.readLongOrNull(offsets[4]),
    nameKey: reader.readStringOrNull(offsets[5]),
  );
  return object;
}

P _achievementModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _achievementModelGetId(AchievementModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _achievementModelGetLinks(AchievementModel object) {
  return [];
}

void _achievementModelAttach(
    IsarCollection<dynamic> col, Id id, AchievementModel object) {}

extension AchievementModelQueryWhereSort
    on QueryBuilder<AchievementModel, AchievementModel, QWhere> {
  QueryBuilder<AchievementModel, AchievementModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AchievementModelQueryWhere
    on QueryBuilder<AchievementModel, AchievementModel, QWhereClause> {
  QueryBuilder<AchievementModel, AchievementModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AchievementModelQueryFilter
    on QueryBuilder<AchievementModel, AchievementModel, QFilterCondition> {
  QueryBuilder<AchievementModel, AchievementModel, QAfterFilterCondition>
      descriptionKeyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'descriptionKey',
      ));
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterFilterCondition>
      descriptionKeyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'descriptionKey',
      ));
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterFilterCondition>
      descriptionKeyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'descriptionKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterFilterCondition>
      descriptionKeyGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'descriptionKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterFilterCondition>
      descriptionKeyLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'descriptionKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterFilterCondition>
      descriptionKeyBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'descriptionKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterFilterCondition>
      descriptionKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'descriptionKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterFilterCondition>
      descriptionKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'descriptionKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterFilterCondition>
      descriptionKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'descriptionKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterFilterCondition>
      descriptionKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'descriptionKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterFilterCondition>
      descriptionKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'descriptionKey',
        value: '',
      ));
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterFilterCondition>
      descriptionKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'descriptionKey',
        value: '',
      ));
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterFilterCondition>
      enabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'enabled',
        value: value,
      ));
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterFilterCondition>
      imageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'image',
      ));
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterFilterCondition>
      imageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'image',
      ));
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterFilterCondition>
      imageEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterFilterCondition>
      imageGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterFilterCondition>
      imageLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterFilterCondition>
      imageBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'image',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterFilterCondition>
      imageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterFilterCondition>
      imageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterFilterCondition>
      imageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterFilterCondition>
      imageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'image',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterFilterCondition>
      imageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'image',
        value: '',
      ));
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterFilterCondition>
      imageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'image',
        value: '',
      ));
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterFilterCondition>
      maxPointsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maxPoints',
        value: value,
      ));
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterFilterCondition>
      maxPointsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maxPoints',
        value: value,
      ));
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterFilterCondition>
      maxPointsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maxPoints',
        value: value,
      ));
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterFilterCondition>
      maxPointsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maxPoints',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterFilterCondition>
      modifiedDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'modifiedDate',
      ));
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterFilterCondition>
      modifiedDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'modifiedDate',
      ));
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterFilterCondition>
      modifiedDateEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'modifiedDate',
        value: value,
      ));
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterFilterCondition>
      modifiedDateGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'modifiedDate',
        value: value,
      ));
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterFilterCondition>
      modifiedDateLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'modifiedDate',
        value: value,
      ));
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterFilterCondition>
      modifiedDateBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'modifiedDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterFilterCondition>
      nameKeyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'nameKey',
      ));
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterFilterCondition>
      nameKeyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'nameKey',
      ));
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterFilterCondition>
      nameKeyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nameKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterFilterCondition>
      nameKeyGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nameKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterFilterCondition>
      nameKeyLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nameKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterFilterCondition>
      nameKeyBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nameKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterFilterCondition>
      nameKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nameKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterFilterCondition>
      nameKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nameKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterFilterCondition>
      nameKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nameKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterFilterCondition>
      nameKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nameKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterFilterCondition>
      nameKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nameKey',
        value: '',
      ));
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterFilterCondition>
      nameKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nameKey',
        value: '',
      ));
    });
  }
}

extension AchievementModelQueryObject
    on QueryBuilder<AchievementModel, AchievementModel, QFilterCondition> {}

extension AchievementModelQueryLinks
    on QueryBuilder<AchievementModel, AchievementModel, QFilterCondition> {}

extension AchievementModelQuerySortBy
    on QueryBuilder<AchievementModel, AchievementModel, QSortBy> {
  QueryBuilder<AchievementModel, AchievementModel, QAfterSortBy>
      sortByDescriptionKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descriptionKey', Sort.asc);
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterSortBy>
      sortByDescriptionKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descriptionKey', Sort.desc);
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterSortBy>
      sortByEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enabled', Sort.asc);
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterSortBy>
      sortByEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enabled', Sort.desc);
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterSortBy> sortByImage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image', Sort.asc);
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterSortBy>
      sortByImageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image', Sort.desc);
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterSortBy>
      sortByMaxPoints() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxPoints', Sort.asc);
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterSortBy>
      sortByMaxPointsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxPoints', Sort.desc);
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterSortBy>
      sortByModifiedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modifiedDate', Sort.asc);
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterSortBy>
      sortByModifiedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modifiedDate', Sort.desc);
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterSortBy>
      sortByNameKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameKey', Sort.asc);
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterSortBy>
      sortByNameKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameKey', Sort.desc);
    });
  }
}

extension AchievementModelQuerySortThenBy
    on QueryBuilder<AchievementModel, AchievementModel, QSortThenBy> {
  QueryBuilder<AchievementModel, AchievementModel, QAfterSortBy>
      thenByDescriptionKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descriptionKey', Sort.asc);
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterSortBy>
      thenByDescriptionKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descriptionKey', Sort.desc);
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterSortBy>
      thenByEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enabled', Sort.asc);
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterSortBy>
      thenByEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enabled', Sort.desc);
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterSortBy> thenByImage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image', Sort.asc);
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterSortBy>
      thenByImageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image', Sort.desc);
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterSortBy>
      thenByMaxPoints() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxPoints', Sort.asc);
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterSortBy>
      thenByMaxPointsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxPoints', Sort.desc);
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterSortBy>
      thenByModifiedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modifiedDate', Sort.asc);
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterSortBy>
      thenByModifiedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modifiedDate', Sort.desc);
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterSortBy>
      thenByNameKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameKey', Sort.asc);
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QAfterSortBy>
      thenByNameKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameKey', Sort.desc);
    });
  }
}

extension AchievementModelQueryWhereDistinct
    on QueryBuilder<AchievementModel, AchievementModel, QDistinct> {
  QueryBuilder<AchievementModel, AchievementModel, QDistinct>
      distinctByDescriptionKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'descriptionKey',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QDistinct>
      distinctByEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'enabled');
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QDistinct> distinctByImage(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'image', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QDistinct>
      distinctByMaxPoints() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'maxPoints');
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QDistinct>
      distinctByModifiedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'modifiedDate');
    });
  }

  QueryBuilder<AchievementModel, AchievementModel, QDistinct> distinctByNameKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nameKey', caseSensitive: caseSensitive);
    });
  }
}

extension AchievementModelQueryProperty
    on QueryBuilder<AchievementModel, AchievementModel, QQueryProperty> {
  QueryBuilder<AchievementModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AchievementModel, String?, QQueryOperations>
      descriptionKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'descriptionKey');
    });
  }

  QueryBuilder<AchievementModel, bool, QQueryOperations> enabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'enabled');
    });
  }

  QueryBuilder<AchievementModel, String?, QQueryOperations> imageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'image');
    });
  }

  QueryBuilder<AchievementModel, int, QQueryOperations> maxPointsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'maxPoints');
    });
  }

  QueryBuilder<AchievementModel, int?, QQueryOperations>
      modifiedDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'modifiedDate');
    });
  }

  QueryBuilder<AchievementModel, String?, QQueryOperations> nameKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nameKey');
    });
  }
}
