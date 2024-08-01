// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'painter_progress.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPainterProgressCollection on Isar {
  IsarCollection<PainterProgress> get painterProgress => this.collection();
}

const PainterProgressSchema = CollectionSchema(
  name: r'PainterProgress',
  id: 6545130060498597685,
  properties: {
    r'completedIds': PropertySchema(
      id: 0,
      name: r'completedIds',
      type: IsarType.longList,
    ),
    r'isCompleted': PropertySchema(
      id: 1,
      name: r'isCompleted',
      type: IsarType.bool,
    ),
    r'screenProgress': PropertySchema(
      id: 2,
      name: r'screenProgress',
      type: IsarType.longList,
    )
  },
  estimateSize: _painterProgressEstimateSize,
  serialize: _painterProgressSerialize,
  deserialize: _painterProgressDeserialize,
  deserializeProp: _painterProgressDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _painterProgressGetId,
  getLinks: _painterProgressGetLinks,
  attach: _painterProgressAttach,
  version: '3.1.0+1',
);

int _painterProgressEstimateSize(
  PainterProgress object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.completedIds;
    if (value != null) {
      bytesCount += 3 + value.length * 8;
    }
  }
  {
    final value = object.screenProgress;
    if (value != null) {
      bytesCount += 3 + value.length * 8;
    }
  }
  return bytesCount;
}

void _painterProgressSerialize(
  PainterProgress object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLongList(offsets[0], object.completedIds);
  writer.writeBool(offsets[1], object.isCompleted);
  writer.writeLongList(offsets[2], object.screenProgress);
}

PainterProgress _painterProgressDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PainterProgress();
  object.completedIds = reader.readLongList(offsets[0]);
  object.id = id;
  object.isCompleted = reader.readBool(offsets[1]);
  object.screenProgress = reader.readLongList(offsets[2]);
  return object;
}

P _painterProgressDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongList(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readLongList(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _painterProgressGetId(PainterProgress object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _painterProgressGetLinks(PainterProgress object) {
  return [];
}

void _painterProgressAttach(
    IsarCollection<dynamic> col, Id id, PainterProgress object) {
  object.id = id;
}

extension PainterProgressQueryWhereSort
    on QueryBuilder<PainterProgress, PainterProgress, QWhere> {
  QueryBuilder<PainterProgress, PainterProgress, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PainterProgressQueryWhere
    on QueryBuilder<PainterProgress, PainterProgress, QWhereClause> {
  QueryBuilder<PainterProgress, PainterProgress, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PainterProgress, PainterProgress, QAfterWhereClause>
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

  QueryBuilder<PainterProgress, PainterProgress, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PainterProgress, PainterProgress, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PainterProgress, PainterProgress, QAfterWhereClause> idBetween(
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

extension PainterProgressQueryFilter
    on QueryBuilder<PainterProgress, PainterProgress, QFilterCondition> {
  QueryBuilder<PainterProgress, PainterProgress, QAfterFilterCondition>
      completedIdsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'completedIds',
      ));
    });
  }

  QueryBuilder<PainterProgress, PainterProgress, QAfterFilterCondition>
      completedIdsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'completedIds',
      ));
    });
  }

  QueryBuilder<PainterProgress, PainterProgress, QAfterFilterCondition>
      completedIdsElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'completedIds',
        value: value,
      ));
    });
  }

  QueryBuilder<PainterProgress, PainterProgress, QAfterFilterCondition>
      completedIdsElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'completedIds',
        value: value,
      ));
    });
  }

  QueryBuilder<PainterProgress, PainterProgress, QAfterFilterCondition>
      completedIdsElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'completedIds',
        value: value,
      ));
    });
  }

  QueryBuilder<PainterProgress, PainterProgress, QAfterFilterCondition>
      completedIdsElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'completedIds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PainterProgress, PainterProgress, QAfterFilterCondition>
      completedIdsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'completedIds',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<PainterProgress, PainterProgress, QAfterFilterCondition>
      completedIdsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'completedIds',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<PainterProgress, PainterProgress, QAfterFilterCondition>
      completedIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'completedIds',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<PainterProgress, PainterProgress, QAfterFilterCondition>
      completedIdsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'completedIds',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<PainterProgress, PainterProgress, QAfterFilterCondition>
      completedIdsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'completedIds',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<PainterProgress, PainterProgress, QAfterFilterCondition>
      completedIdsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'completedIds',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<PainterProgress, PainterProgress, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PainterProgress, PainterProgress, QAfterFilterCondition>
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

  QueryBuilder<PainterProgress, PainterProgress, QAfterFilterCondition>
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

  QueryBuilder<PainterProgress, PainterProgress, QAfterFilterCondition>
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

  QueryBuilder<PainterProgress, PainterProgress, QAfterFilterCondition>
      isCompletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCompleted',
        value: value,
      ));
    });
  }

  QueryBuilder<PainterProgress, PainterProgress, QAfterFilterCondition>
      screenProgressIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'screenProgress',
      ));
    });
  }

  QueryBuilder<PainterProgress, PainterProgress, QAfterFilterCondition>
      screenProgressIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'screenProgress',
      ));
    });
  }

  QueryBuilder<PainterProgress, PainterProgress, QAfterFilterCondition>
      screenProgressElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'screenProgress',
        value: value,
      ));
    });
  }

  QueryBuilder<PainterProgress, PainterProgress, QAfterFilterCondition>
      screenProgressElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'screenProgress',
        value: value,
      ));
    });
  }

  QueryBuilder<PainterProgress, PainterProgress, QAfterFilterCondition>
      screenProgressElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'screenProgress',
        value: value,
      ));
    });
  }

  QueryBuilder<PainterProgress, PainterProgress, QAfterFilterCondition>
      screenProgressElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'screenProgress',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PainterProgress, PainterProgress, QAfterFilterCondition>
      screenProgressLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'screenProgress',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<PainterProgress, PainterProgress, QAfterFilterCondition>
      screenProgressIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'screenProgress',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<PainterProgress, PainterProgress, QAfterFilterCondition>
      screenProgressIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'screenProgress',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<PainterProgress, PainterProgress, QAfterFilterCondition>
      screenProgressLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'screenProgress',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<PainterProgress, PainterProgress, QAfterFilterCondition>
      screenProgressLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'screenProgress',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<PainterProgress, PainterProgress, QAfterFilterCondition>
      screenProgressLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'screenProgress',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension PainterProgressQueryObject
    on QueryBuilder<PainterProgress, PainterProgress, QFilterCondition> {}

extension PainterProgressQueryLinks
    on QueryBuilder<PainterProgress, PainterProgress, QFilterCondition> {}

extension PainterProgressQuerySortBy
    on QueryBuilder<PainterProgress, PainterProgress, QSortBy> {
  QueryBuilder<PainterProgress, PainterProgress, QAfterSortBy>
      sortByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.asc);
    });
  }

  QueryBuilder<PainterProgress, PainterProgress, QAfterSortBy>
      sortByIsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.desc);
    });
  }
}

extension PainterProgressQuerySortThenBy
    on QueryBuilder<PainterProgress, PainterProgress, QSortThenBy> {
  QueryBuilder<PainterProgress, PainterProgress, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PainterProgress, PainterProgress, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PainterProgress, PainterProgress, QAfterSortBy>
      thenByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.asc);
    });
  }

  QueryBuilder<PainterProgress, PainterProgress, QAfterSortBy>
      thenByIsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.desc);
    });
  }
}

extension PainterProgressQueryWhereDistinct
    on QueryBuilder<PainterProgress, PainterProgress, QDistinct> {
  QueryBuilder<PainterProgress, PainterProgress, QDistinct>
      distinctByCompletedIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'completedIds');
    });
  }

  QueryBuilder<PainterProgress, PainterProgress, QDistinct>
      distinctByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCompleted');
    });
  }

  QueryBuilder<PainterProgress, PainterProgress, QDistinct>
      distinctByScreenProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'screenProgress');
    });
  }
}

extension PainterProgressQueryProperty
    on QueryBuilder<PainterProgress, PainterProgress, QQueryProperty> {
  QueryBuilder<PainterProgress, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PainterProgress, List<int>?, QQueryOperations>
      completedIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'completedIds');
    });
  }

  QueryBuilder<PainterProgress, bool, QQueryOperations> isCompletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCompleted');
    });
  }

  QueryBuilder<PainterProgress, List<int>?, QQueryOperations>
      screenProgressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'screenProgress');
    });
  }
}
