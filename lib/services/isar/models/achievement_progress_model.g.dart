// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement_progress_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAchievementProgressModelCollection on Isar {
  IsarCollection<AchievementProgressModel> get achievementProgressModels =>
      this.collection();
}

const AchievementProgressModelSchema = CollectionSchema(
  name: r'AchievementProgressModel',
  id: 105491009503681393,
  properties: {
    r'achievementId': PropertySchema(
      id: 0,
      name: r'achievementId',
      type: IsarType.long,
    ),
    r'completedPoints': PropertySchema(
      id: 1,
      name: r'completedPoints',
      type: IsarType.long,
    ),
    r'isCompleted': PropertySchema(
      id: 2,
      name: r'isCompleted',
      type: IsarType.bool,
    ),
    r'isReceived': PropertySchema(
      id: 3,
      name: r'isReceived',
      type: IsarType.bool,
    ),
    r'modifiedDate': PropertySchema(
      id: 4,
      name: r'modifiedDate',
      type: IsarType.long,
    ),
    r'userId': PropertySchema(
      id: 5,
      name: r'userId',
      type: IsarType.long,
    )
  },
  estimateSize: _achievementProgressModelEstimateSize,
  serialize: _achievementProgressModelSerialize,
  deserialize: _achievementProgressModelDeserialize,
  deserializeProp: _achievementProgressModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _achievementProgressModelGetId,
  getLinks: _achievementProgressModelGetLinks,
  attach: _achievementProgressModelAttach,
  version: '3.1.0+1',
);

int _achievementProgressModelEstimateSize(
  AchievementProgressModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _achievementProgressModelSerialize(
  AchievementProgressModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.achievementId);
  writer.writeLong(offsets[1], object.completedPoints);
  writer.writeBool(offsets[2], object.isCompleted);
  writer.writeBool(offsets[3], object.isReceived);
  writer.writeLong(offsets[4], object.modifiedDate);
  writer.writeLong(offsets[5], object.userId);
}

AchievementProgressModel _achievementProgressModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AchievementProgressModel(
    achievementId: reader.readLongOrNull(offsets[0]),
    completedPoints: reader.readLongOrNull(offsets[1]) ?? 0,
    id: id,
    isCompleted: reader.readBoolOrNull(offsets[2]) ?? false,
    isReceived: reader.readBoolOrNull(offsets[3]) ?? false,
    modifiedDate: reader.readLongOrNull(offsets[4]),
    userId: reader.readLongOrNull(offsets[5]),
  );
  return object;
}

P _achievementProgressModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 2:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 3:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _achievementProgressModelGetId(AchievementProgressModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _achievementProgressModelGetLinks(
    AchievementProgressModel object) {
  return [];
}

void _achievementProgressModelAttach(
    IsarCollection<dynamic> col, Id id, AchievementProgressModel object) {}

extension AchievementProgressModelQueryWhereSort on QueryBuilder<
    AchievementProgressModel, AchievementProgressModel, QWhere> {
  QueryBuilder<AchievementProgressModel, AchievementProgressModel, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AchievementProgressModelQueryWhere on QueryBuilder<
    AchievementProgressModel, AchievementProgressModel, QWhereClause> {
  QueryBuilder<AchievementProgressModel, AchievementProgressModel,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<AchievementProgressModel, AchievementProgressModel,
      QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<AchievementProgressModel, AchievementProgressModel,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AchievementProgressModel, AchievementProgressModel,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AchievementProgressModel, AchievementProgressModel,
      QAfterWhereClause> idBetween(
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

extension AchievementProgressModelQueryFilter on QueryBuilder<
    AchievementProgressModel, AchievementProgressModel, QFilterCondition> {
  QueryBuilder<AchievementProgressModel, AchievementProgressModel,
      QAfterFilterCondition> achievementIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'achievementId',
      ));
    });
  }

  QueryBuilder<AchievementProgressModel, AchievementProgressModel,
      QAfterFilterCondition> achievementIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'achievementId',
      ));
    });
  }

  QueryBuilder<AchievementProgressModel, AchievementProgressModel,
      QAfterFilterCondition> achievementIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'achievementId',
        value: value,
      ));
    });
  }

  QueryBuilder<AchievementProgressModel, AchievementProgressModel,
      QAfterFilterCondition> achievementIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'achievementId',
        value: value,
      ));
    });
  }

  QueryBuilder<AchievementProgressModel, AchievementProgressModel,
      QAfterFilterCondition> achievementIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'achievementId',
        value: value,
      ));
    });
  }

  QueryBuilder<AchievementProgressModel, AchievementProgressModel,
      QAfterFilterCondition> achievementIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'achievementId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AchievementProgressModel, AchievementProgressModel,
      QAfterFilterCondition> completedPointsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'completedPoints',
        value: value,
      ));
    });
  }

  QueryBuilder<AchievementProgressModel, AchievementProgressModel,
      QAfterFilterCondition> completedPointsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'completedPoints',
        value: value,
      ));
    });
  }

  QueryBuilder<AchievementProgressModel, AchievementProgressModel,
      QAfterFilterCondition> completedPointsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'completedPoints',
        value: value,
      ));
    });
  }

  QueryBuilder<AchievementProgressModel, AchievementProgressModel,
      QAfterFilterCondition> completedPointsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'completedPoints',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AchievementProgressModel, AchievementProgressModel,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AchievementProgressModel, AchievementProgressModel,
      QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<AchievementProgressModel, AchievementProgressModel,
      QAfterFilterCondition> idLessThan(
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

  QueryBuilder<AchievementProgressModel, AchievementProgressModel,
      QAfterFilterCondition> idBetween(
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

  QueryBuilder<AchievementProgressModel, AchievementProgressModel,
      QAfterFilterCondition> isCompletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCompleted',
        value: value,
      ));
    });
  }

  QueryBuilder<AchievementProgressModel, AchievementProgressModel,
      QAfterFilterCondition> isReceivedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isReceived',
        value: value,
      ));
    });
  }

  QueryBuilder<AchievementProgressModel, AchievementProgressModel,
      QAfterFilterCondition> modifiedDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'modifiedDate',
      ));
    });
  }

  QueryBuilder<AchievementProgressModel, AchievementProgressModel,
      QAfterFilterCondition> modifiedDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'modifiedDate',
      ));
    });
  }

  QueryBuilder<AchievementProgressModel, AchievementProgressModel,
      QAfterFilterCondition> modifiedDateEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'modifiedDate',
        value: value,
      ));
    });
  }

  QueryBuilder<AchievementProgressModel, AchievementProgressModel,
      QAfterFilterCondition> modifiedDateGreaterThan(
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

  QueryBuilder<AchievementProgressModel, AchievementProgressModel,
      QAfterFilterCondition> modifiedDateLessThan(
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

  QueryBuilder<AchievementProgressModel, AchievementProgressModel,
      QAfterFilterCondition> modifiedDateBetween(
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

  QueryBuilder<AchievementProgressModel, AchievementProgressModel,
      QAfterFilterCondition> userIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'userId',
      ));
    });
  }

  QueryBuilder<AchievementProgressModel, AchievementProgressModel,
      QAfterFilterCondition> userIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'userId',
      ));
    });
  }

  QueryBuilder<AchievementProgressModel, AchievementProgressModel,
      QAfterFilterCondition> userIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: value,
      ));
    });
  }

  QueryBuilder<AchievementProgressModel, AchievementProgressModel,
      QAfterFilterCondition> userIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userId',
        value: value,
      ));
    });
  }

  QueryBuilder<AchievementProgressModel, AchievementProgressModel,
      QAfterFilterCondition> userIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userId',
        value: value,
      ));
    });
  }

  QueryBuilder<AchievementProgressModel, AchievementProgressModel,
      QAfterFilterCondition> userIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AchievementProgressModelQueryObject on QueryBuilder<
    AchievementProgressModel, AchievementProgressModel, QFilterCondition> {}

extension AchievementProgressModelQueryLinks on QueryBuilder<
    AchievementProgressModel, AchievementProgressModel, QFilterCondition> {}

extension AchievementProgressModelQuerySortBy on QueryBuilder<
    AchievementProgressModel, AchievementProgressModel, QSortBy> {
  QueryBuilder<AchievementProgressModel, AchievementProgressModel, QAfterSortBy>
      sortByAchievementId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'achievementId', Sort.asc);
    });
  }

  QueryBuilder<AchievementProgressModel, AchievementProgressModel, QAfterSortBy>
      sortByAchievementIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'achievementId', Sort.desc);
    });
  }

  QueryBuilder<AchievementProgressModel, AchievementProgressModel, QAfterSortBy>
      sortByCompletedPoints() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedPoints', Sort.asc);
    });
  }

  QueryBuilder<AchievementProgressModel, AchievementProgressModel, QAfterSortBy>
      sortByCompletedPointsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedPoints', Sort.desc);
    });
  }

  QueryBuilder<AchievementProgressModel, AchievementProgressModel, QAfterSortBy>
      sortByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.asc);
    });
  }

  QueryBuilder<AchievementProgressModel, AchievementProgressModel, QAfterSortBy>
      sortByIsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.desc);
    });
  }

  QueryBuilder<AchievementProgressModel, AchievementProgressModel, QAfterSortBy>
      sortByIsReceived() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isReceived', Sort.asc);
    });
  }

  QueryBuilder<AchievementProgressModel, AchievementProgressModel, QAfterSortBy>
      sortByIsReceivedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isReceived', Sort.desc);
    });
  }

  QueryBuilder<AchievementProgressModel, AchievementProgressModel, QAfterSortBy>
      sortByModifiedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modifiedDate', Sort.asc);
    });
  }

  QueryBuilder<AchievementProgressModel, AchievementProgressModel, QAfterSortBy>
      sortByModifiedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modifiedDate', Sort.desc);
    });
  }

  QueryBuilder<AchievementProgressModel, AchievementProgressModel, QAfterSortBy>
      sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<AchievementProgressModel, AchievementProgressModel, QAfterSortBy>
      sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension AchievementProgressModelQuerySortThenBy on QueryBuilder<
    AchievementProgressModel, AchievementProgressModel, QSortThenBy> {
  QueryBuilder<AchievementProgressModel, AchievementProgressModel, QAfterSortBy>
      thenByAchievementId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'achievementId', Sort.asc);
    });
  }

  QueryBuilder<AchievementProgressModel, AchievementProgressModel, QAfterSortBy>
      thenByAchievementIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'achievementId', Sort.desc);
    });
  }

  QueryBuilder<AchievementProgressModel, AchievementProgressModel, QAfterSortBy>
      thenByCompletedPoints() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedPoints', Sort.asc);
    });
  }

  QueryBuilder<AchievementProgressModel, AchievementProgressModel, QAfterSortBy>
      thenByCompletedPointsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedPoints', Sort.desc);
    });
  }

  QueryBuilder<AchievementProgressModel, AchievementProgressModel, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AchievementProgressModel, AchievementProgressModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AchievementProgressModel, AchievementProgressModel, QAfterSortBy>
      thenByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.asc);
    });
  }

  QueryBuilder<AchievementProgressModel, AchievementProgressModel, QAfterSortBy>
      thenByIsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.desc);
    });
  }

  QueryBuilder<AchievementProgressModel, AchievementProgressModel, QAfterSortBy>
      thenByIsReceived() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isReceived', Sort.asc);
    });
  }

  QueryBuilder<AchievementProgressModel, AchievementProgressModel, QAfterSortBy>
      thenByIsReceivedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isReceived', Sort.desc);
    });
  }

  QueryBuilder<AchievementProgressModel, AchievementProgressModel, QAfterSortBy>
      thenByModifiedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modifiedDate', Sort.asc);
    });
  }

  QueryBuilder<AchievementProgressModel, AchievementProgressModel, QAfterSortBy>
      thenByModifiedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modifiedDate', Sort.desc);
    });
  }

  QueryBuilder<AchievementProgressModel, AchievementProgressModel, QAfterSortBy>
      thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<AchievementProgressModel, AchievementProgressModel, QAfterSortBy>
      thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension AchievementProgressModelQueryWhereDistinct on QueryBuilder<
    AchievementProgressModel, AchievementProgressModel, QDistinct> {
  QueryBuilder<AchievementProgressModel, AchievementProgressModel, QDistinct>
      distinctByAchievementId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'achievementId');
    });
  }

  QueryBuilder<AchievementProgressModel, AchievementProgressModel, QDistinct>
      distinctByCompletedPoints() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'completedPoints');
    });
  }

  QueryBuilder<AchievementProgressModel, AchievementProgressModel, QDistinct>
      distinctByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCompleted');
    });
  }

  QueryBuilder<AchievementProgressModel, AchievementProgressModel, QDistinct>
      distinctByIsReceived() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isReceived');
    });
  }

  QueryBuilder<AchievementProgressModel, AchievementProgressModel, QDistinct>
      distinctByModifiedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'modifiedDate');
    });
  }

  QueryBuilder<AchievementProgressModel, AchievementProgressModel, QDistinct>
      distinctByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId');
    });
  }
}

extension AchievementProgressModelQueryProperty on QueryBuilder<
    AchievementProgressModel, AchievementProgressModel, QQueryProperty> {
  QueryBuilder<AchievementProgressModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AchievementProgressModel, int?, QQueryOperations>
      achievementIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'achievementId');
    });
  }

  QueryBuilder<AchievementProgressModel, int, QQueryOperations>
      completedPointsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'completedPoints');
    });
  }

  QueryBuilder<AchievementProgressModel, bool, QQueryOperations>
      isCompletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCompleted');
    });
  }

  QueryBuilder<AchievementProgressModel, bool, QQueryOperations>
      isReceivedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isReceived');
    });
  }

  QueryBuilder<AchievementProgressModel, int?, QQueryOperations>
      modifiedDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'modifiedDate');
    });
  }

  QueryBuilder<AchievementProgressModel, int?, QQueryOperations>
      userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }
}
