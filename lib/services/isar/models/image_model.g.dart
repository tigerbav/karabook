// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetImageModelCollection on Isar {
  IsarCollection<ImageModel> get imageModels => this.collection();
}

const ImageModelSchema = CollectionSchema(
  name: r'ImageModel',
  id: -4998388787585861710,
  properties: {
    r'categoryId': PropertySchema(
      id: 0,
      name: r'categoryId',
      type: IsarType.long,
    ),
    r'completedIds': PropertySchema(
      id: 1,
      name: r'completedIds',
      type: IsarType.longList,
    ),
    r'enabled': PropertySchema(
      id: 2,
      name: r'enabled',
      type: IsarType.bool,
    ),
    r'imageRawData': PropertySchema(
      id: 3,
      name: r'imageRawData',
      type: IsarType.string,
    ),
    r'isCompleted': PropertySchema(
      id: 4,
      name: r'isCompleted',
      type: IsarType.bool,
    ),
    r'isDaily': PropertySchema(
      id: 5,
      name: r'isDaily',
      type: IsarType.bool,
    ),
    r'modifiedDate': PropertySchema(
      id: 6,
      name: r'modifiedDate',
      type: IsarType.long,
    ),
    r'screenProgress': PropertySchema(
      id: 7,
      name: r'screenProgress',
      type: IsarType.longList,
    ),
    r'sort': PropertySchema(
      id: 8,
      name: r'sort',
      type: IsarType.long,
    ),
    r'tag': PropertySchema(
      id: 9,
      name: r'tag',
      type: IsarType.string,
    )
  },
  estimateSize: _imageModelEstimateSize,
  serialize: _imageModelSerialize,
  deserialize: _imageModelDeserialize,
  deserializeProp: _imageModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _imageModelGetId,
  getLinks: _imageModelGetLinks,
  attach: _imageModelAttach,
  version: '3.1.0+1',
);

int _imageModelEstimateSize(
  ImageModel object,
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
    final value = object.imageRawData;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.screenProgress;
    if (value != null) {
      bytesCount += 3 + value.length * 8;
    }
  }
  {
    final value = object.tag;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _imageModelSerialize(
  ImageModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.categoryId);
  writer.writeLongList(offsets[1], object.completedIds);
  writer.writeBool(offsets[2], object.enabled);
  writer.writeString(offsets[3], object.imageRawData);
  writer.writeBool(offsets[4], object.isCompleted);
  writer.writeBool(offsets[5], object.isDaily);
  writer.writeLong(offsets[6], object.modifiedDate);
  writer.writeLongList(offsets[7], object.screenProgress);
  writer.writeLong(offsets[8], object.sort);
  writer.writeString(offsets[9], object.tag);
}

ImageModel _imageModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ImageModel(
    categoryId: reader.readLongOrNull(offsets[0]),
    completedIds: reader.readLongList(offsets[1]),
    enabled: reader.readBoolOrNull(offsets[2]) ?? false,
    id: id,
    imageRawData: reader.readStringOrNull(offsets[3]),
    isCompleted: reader.readBoolOrNull(offsets[4]),
    isDaily: reader.readBoolOrNull(offsets[5]) ?? false,
    modifiedDate: reader.readLongOrNull(offsets[6]),
    screenProgress: reader.readLongList(offsets[7]),
    sort: reader.readLongOrNull(offsets[8]) ?? 0,
    tag: reader.readStringOrNull(offsets[9]),
  );
  return object;
}

P _imageModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readLongList(offset)) as P;
    case 2:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readBoolOrNull(offset)) as P;
    case 5:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 6:
      return (reader.readLongOrNull(offset)) as P;
    case 7:
      return (reader.readLongList(offset)) as P;
    case 8:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _imageModelGetId(ImageModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _imageModelGetLinks(ImageModel object) {
  return [];
}

void _imageModelAttach(IsarCollection<dynamic> col, Id id, ImageModel object) {
  object.id = id;
}

extension ImageModelQueryWhereSort
    on QueryBuilder<ImageModel, ImageModel, QWhere> {
  QueryBuilder<ImageModel, ImageModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ImageModelQueryWhere
    on QueryBuilder<ImageModel, ImageModel, QWhereClause> {
  QueryBuilder<ImageModel, ImageModel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<ImageModel, ImageModel, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterWhereClause> idBetween(
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

extension ImageModelQueryFilter
    on QueryBuilder<ImageModel, ImageModel, QFilterCondition> {
  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      categoryIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'categoryId',
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      categoryIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'categoryId',
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> categoryIdEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'categoryId',
        value: value,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      categoryIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'categoryId',
        value: value,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      categoryIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'categoryId',
        value: value,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> categoryIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'categoryId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      completedIdsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'completedIds',
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      completedIdsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'completedIds',
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      completedIdsElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'completedIds',
        value: value,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
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

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
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

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
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

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
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

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
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

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
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

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
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

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
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

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
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

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> enabledEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'enabled',
        value: value,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      imageRawDataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'imageRawData',
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      imageRawDataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'imageRawData',
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      imageRawDataEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imageRawData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      imageRawDataGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'imageRawData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      imageRawDataLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'imageRawData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      imageRawDataBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'imageRawData',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      imageRawDataStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'imageRawData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      imageRawDataEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'imageRawData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      imageRawDataContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'imageRawData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      imageRawDataMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'imageRawData',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      imageRawDataIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imageRawData',
        value: '',
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      imageRawDataIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'imageRawData',
        value: '',
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      isCompletedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isCompleted',
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      isCompletedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isCompleted',
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      isCompletedEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCompleted',
        value: value,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> isDailyEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isDaily',
        value: value,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      modifiedDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'modifiedDate',
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      modifiedDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'modifiedDate',
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      modifiedDateEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'modifiedDate',
        value: value,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
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

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
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

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
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

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      screenProgressIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'screenProgress',
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      screenProgressIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'screenProgress',
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
      screenProgressElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'screenProgress',
        value: value,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
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

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
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

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
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

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
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

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
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

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
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

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
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

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
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

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition>
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

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> sortEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sort',
        value: value,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> sortGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sort',
        value: value,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> sortLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sort',
        value: value,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> sortBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sort',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> tagIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tag',
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> tagIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tag',
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> tagEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> tagGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> tagLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> tagBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tag',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> tagStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> tagEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> tagContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> tagMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tag',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> tagIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tag',
        value: '',
      ));
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterFilterCondition> tagIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tag',
        value: '',
      ));
    });
  }
}

extension ImageModelQueryObject
    on QueryBuilder<ImageModel, ImageModel, QFilterCondition> {}

extension ImageModelQueryLinks
    on QueryBuilder<ImageModel, ImageModel, QFilterCondition> {}

extension ImageModelQuerySortBy
    on QueryBuilder<ImageModel, ImageModel, QSortBy> {
  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> sortByCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.asc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> sortByCategoryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.desc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> sortByEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enabled', Sort.asc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> sortByEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enabled', Sort.desc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> sortByImageRawData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageRawData', Sort.asc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> sortByImageRawDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageRawData', Sort.desc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> sortByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.asc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> sortByIsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.desc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> sortByIsDaily() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDaily', Sort.asc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> sortByIsDailyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDaily', Sort.desc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> sortByModifiedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modifiedDate', Sort.asc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> sortByModifiedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modifiedDate', Sort.desc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> sortBySort() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sort', Sort.asc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> sortBySortDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sort', Sort.desc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> sortByTag() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tag', Sort.asc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> sortByTagDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tag', Sort.desc);
    });
  }
}

extension ImageModelQuerySortThenBy
    on QueryBuilder<ImageModel, ImageModel, QSortThenBy> {
  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> thenByCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.asc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> thenByCategoryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.desc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> thenByEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enabled', Sort.asc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> thenByEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enabled', Sort.desc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> thenByImageRawData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageRawData', Sort.asc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> thenByImageRawDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageRawData', Sort.desc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> thenByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.asc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> thenByIsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.desc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> thenByIsDaily() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDaily', Sort.asc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> thenByIsDailyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDaily', Sort.desc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> thenByModifiedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modifiedDate', Sort.asc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> thenByModifiedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modifiedDate', Sort.desc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> thenBySort() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sort', Sort.asc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> thenBySortDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sort', Sort.desc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> thenByTag() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tag', Sort.asc);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QAfterSortBy> thenByTagDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tag', Sort.desc);
    });
  }
}

extension ImageModelQueryWhereDistinct
    on QueryBuilder<ImageModel, ImageModel, QDistinct> {
  QueryBuilder<ImageModel, ImageModel, QDistinct> distinctByCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'categoryId');
    });
  }

  QueryBuilder<ImageModel, ImageModel, QDistinct> distinctByCompletedIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'completedIds');
    });
  }

  QueryBuilder<ImageModel, ImageModel, QDistinct> distinctByEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'enabled');
    });
  }

  QueryBuilder<ImageModel, ImageModel, QDistinct> distinctByImageRawData(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'imageRawData', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ImageModel, ImageModel, QDistinct> distinctByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCompleted');
    });
  }

  QueryBuilder<ImageModel, ImageModel, QDistinct> distinctByIsDaily() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDaily');
    });
  }

  QueryBuilder<ImageModel, ImageModel, QDistinct> distinctByModifiedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'modifiedDate');
    });
  }

  QueryBuilder<ImageModel, ImageModel, QDistinct> distinctByScreenProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'screenProgress');
    });
  }

  QueryBuilder<ImageModel, ImageModel, QDistinct> distinctBySort() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sort');
    });
  }

  QueryBuilder<ImageModel, ImageModel, QDistinct> distinctByTag(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tag', caseSensitive: caseSensitive);
    });
  }
}

extension ImageModelQueryProperty
    on QueryBuilder<ImageModel, ImageModel, QQueryProperty> {
  QueryBuilder<ImageModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ImageModel, int?, QQueryOperations> categoryIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'categoryId');
    });
  }

  QueryBuilder<ImageModel, List<int>?, QQueryOperations>
      completedIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'completedIds');
    });
  }

  QueryBuilder<ImageModel, bool, QQueryOperations> enabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'enabled');
    });
  }

  QueryBuilder<ImageModel, String?, QQueryOperations> imageRawDataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'imageRawData');
    });
  }

  QueryBuilder<ImageModel, bool?, QQueryOperations> isCompletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCompleted');
    });
  }

  QueryBuilder<ImageModel, bool, QQueryOperations> isDailyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDaily');
    });
  }

  QueryBuilder<ImageModel, int?, QQueryOperations> modifiedDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'modifiedDate');
    });
  }

  QueryBuilder<ImageModel, List<int>?, QQueryOperations>
      screenProgressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'screenProgress');
    });
  }

  QueryBuilder<ImageModel, int, QQueryOperations> sortProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sort');
    });
  }

  QueryBuilder<ImageModel, String?, QQueryOperations> tagProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tag');
    });
  }
}
