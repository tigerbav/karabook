// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTextModelCollection on Isar {
  IsarCollection<TextModel> get textModels => this.collection();
}

const TextModelSchema = CollectionSchema(
  name: r'TextModel',
  id: 4550829371609725397,
  properties: {
    r'locale': PropertySchema(
      id: 0,
      name: r'locale',
      type: IsarType.string,
    ),
    r'modifiedDate': PropertySchema(
      id: 1,
      name: r'modifiedDate',
      type: IsarType.long,
    ),
    r'textKey': PropertySchema(
      id: 2,
      name: r'textKey',
      type: IsarType.string,
    ),
    r'textValue': PropertySchema(
      id: 3,
      name: r'textValue',
      type: IsarType.string,
    )
  },
  estimateSize: _textModelEstimateSize,
  serialize: _textModelSerialize,
  deserialize: _textModelDeserialize,
  deserializeProp: _textModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _textModelGetId,
  getLinks: _textModelGetLinks,
  attach: _textModelAttach,
  version: '3.1.0+1',
);

int _textModelEstimateSize(
  TextModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.locale;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.textKey;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.textValue;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _textModelSerialize(
  TextModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.locale);
  writer.writeLong(offsets[1], object.modifiedDate);
  writer.writeString(offsets[2], object.textKey);
  writer.writeString(offsets[3], object.textValue);
}

TextModel _textModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TextModel(
    id: id,
    locale: reader.readStringOrNull(offsets[0]),
    modifiedDate: reader.readLongOrNull(offsets[1]),
    textKey: reader.readStringOrNull(offsets[2]),
    textValue: reader.readStringOrNull(offsets[3]),
  );
  return object;
}

P _textModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _textModelGetId(TextModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _textModelGetLinks(TextModel object) {
  return [];
}

void _textModelAttach(IsarCollection<dynamic> col, Id id, TextModel object) {}

extension TextModelQueryWhereSort
    on QueryBuilder<TextModel, TextModel, QWhere> {
  QueryBuilder<TextModel, TextModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TextModelQueryWhere
    on QueryBuilder<TextModel, TextModel, QWhereClause> {
  QueryBuilder<TextModel, TextModel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<TextModel, TextModel, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterWhereClause> idBetween(
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

extension TextModelQueryFilter
    on QueryBuilder<TextModel, TextModel, QFilterCondition> {
  QueryBuilder<TextModel, TextModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<TextModel, TextModel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<TextModel, TextModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<TextModel, TextModel, QAfterFilterCondition> localeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'locale',
      ));
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterFilterCondition> localeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'locale',
      ));
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterFilterCondition> localeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'locale',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterFilterCondition> localeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'locale',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterFilterCondition> localeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'locale',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterFilterCondition> localeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'locale',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterFilterCondition> localeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'locale',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterFilterCondition> localeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'locale',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterFilterCondition> localeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'locale',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterFilterCondition> localeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'locale',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterFilterCondition> localeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'locale',
        value: '',
      ));
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterFilterCondition> localeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'locale',
        value: '',
      ));
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterFilterCondition>
      modifiedDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'modifiedDate',
      ));
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterFilterCondition>
      modifiedDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'modifiedDate',
      ));
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterFilterCondition> modifiedDateEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'modifiedDate',
        value: value,
      ));
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterFilterCondition>
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

  QueryBuilder<TextModel, TextModel, QAfterFilterCondition>
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

  QueryBuilder<TextModel, TextModel, QAfterFilterCondition> modifiedDateBetween(
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

  QueryBuilder<TextModel, TextModel, QAfterFilterCondition> textKeyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'textKey',
      ));
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterFilterCondition> textKeyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'textKey',
      ));
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterFilterCondition> textKeyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterFilterCondition> textKeyGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'textKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterFilterCondition> textKeyLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'textKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterFilterCondition> textKeyBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'textKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterFilterCondition> textKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'textKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterFilterCondition> textKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'textKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterFilterCondition> textKeyContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'textKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterFilterCondition> textKeyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'textKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterFilterCondition> textKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textKey',
        value: '',
      ));
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterFilterCondition>
      textKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'textKey',
        value: '',
      ));
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterFilterCondition> textValueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'textValue',
      ));
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterFilterCondition>
      textValueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'textValue',
      ));
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterFilterCondition> textValueEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterFilterCondition>
      textValueGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'textValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterFilterCondition> textValueLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'textValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterFilterCondition> textValueBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'textValue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterFilterCondition> textValueStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'textValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterFilterCondition> textValueEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'textValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterFilterCondition> textValueContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'textValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterFilterCondition> textValueMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'textValue',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterFilterCondition> textValueIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textValue',
        value: '',
      ));
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterFilterCondition>
      textValueIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'textValue',
        value: '',
      ));
    });
  }
}

extension TextModelQueryObject
    on QueryBuilder<TextModel, TextModel, QFilterCondition> {}

extension TextModelQueryLinks
    on QueryBuilder<TextModel, TextModel, QFilterCondition> {}

extension TextModelQuerySortBy on QueryBuilder<TextModel, TextModel, QSortBy> {
  QueryBuilder<TextModel, TextModel, QAfterSortBy> sortByLocale() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locale', Sort.asc);
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterSortBy> sortByLocaleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locale', Sort.desc);
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterSortBy> sortByModifiedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modifiedDate', Sort.asc);
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterSortBy> sortByModifiedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modifiedDate', Sort.desc);
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterSortBy> sortByTextKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textKey', Sort.asc);
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterSortBy> sortByTextKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textKey', Sort.desc);
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterSortBy> sortByTextValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textValue', Sort.asc);
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterSortBy> sortByTextValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textValue', Sort.desc);
    });
  }
}

extension TextModelQuerySortThenBy
    on QueryBuilder<TextModel, TextModel, QSortThenBy> {
  QueryBuilder<TextModel, TextModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterSortBy> thenByLocale() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locale', Sort.asc);
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterSortBy> thenByLocaleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locale', Sort.desc);
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterSortBy> thenByModifiedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modifiedDate', Sort.asc);
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterSortBy> thenByModifiedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modifiedDate', Sort.desc);
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterSortBy> thenByTextKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textKey', Sort.asc);
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterSortBy> thenByTextKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textKey', Sort.desc);
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterSortBy> thenByTextValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textValue', Sort.asc);
    });
  }

  QueryBuilder<TextModel, TextModel, QAfterSortBy> thenByTextValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textValue', Sort.desc);
    });
  }
}

extension TextModelQueryWhereDistinct
    on QueryBuilder<TextModel, TextModel, QDistinct> {
  QueryBuilder<TextModel, TextModel, QDistinct> distinctByLocale(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'locale', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TextModel, TextModel, QDistinct> distinctByModifiedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'modifiedDate');
    });
  }

  QueryBuilder<TextModel, TextModel, QDistinct> distinctByTextKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'textKey', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TextModel, TextModel, QDistinct> distinctByTextValue(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'textValue', caseSensitive: caseSensitive);
    });
  }
}

extension TextModelQueryProperty
    on QueryBuilder<TextModel, TextModel, QQueryProperty> {
  QueryBuilder<TextModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TextModel, String?, QQueryOperations> localeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'locale');
    });
  }

  QueryBuilder<TextModel, int?, QQueryOperations> modifiedDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'modifiedDate');
    });
  }

  QueryBuilder<TextModel, String?, QQueryOperations> textKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'textKey');
    });
  }

  QueryBuilder<TextModel, String?, QQueryOperations> textValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'textValue');
    });
  }
}
