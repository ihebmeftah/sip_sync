/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _is;
import 'package:sip_sync_server/src/generated/protocol.dart' as _iaib1p48;
import '../../buildings/entity/building.dart' as _iaohraio;
import '../../packs/entity/building_pack_assignment.dart' as _iq3bhcsv;

/// Commercial plan. Prices are millimes (89 TND = 89000). Null limits mean no cap.
abstract class Pack
    implements _is.TableRow<_is.UuidValue?>, _is.ProtocolSerialization {
  Pack._({
    this.id,
    required this.code,
    required this.name,
    required this.monthlyMillimes,
    this.annualMillimes,
    int? customerOrderFeeBps,
    bool? isPublic,
    bool? isEnabled,
    bool? isSystem,
    int? sortOrder,
    this.maxEmployees,
    this.maxTables,
    this.maxCategories,
    this.maxArticles,
    this.maxIngredients,
    bool? customerDiscovery,
    bool? tableQr,
    bool? customerOrdering,
    bool? inventory,
    bool? allowAppendingItems,
    bool? tableMultiOrder,
    bool? strictMode,
    bool? customAccessProfiles,
    DateTime? createdAt,
    this.buildings,
    this.assignments,
  }) : customerOrderFeeBps = customerOrderFeeBps ?? 0,
       isPublic = isPublic ?? false,
       isEnabled = isEnabled ?? true,
       isSystem = isSystem ?? false,
       sortOrder = sortOrder ?? 0,
       customerDiscovery = customerDiscovery ?? true,
       tableQr = tableQr ?? true,
       customerOrdering = customerOrdering ?? false,
       inventory = inventory ?? true,
       allowAppendingItems = allowAppendingItems ?? true,
       tableMultiOrder = tableMultiOrder ?? false,
       strictMode = strictMode ?? false,
       customAccessProfiles = customAccessProfiles ?? false,
       createdAt = createdAt ?? DateTime.now();

  factory Pack({
    _is.UuidValue? id,
    required String code,
    required String name,
    required int monthlyMillimes,
    int? annualMillimes,
    int? customerOrderFeeBps,
    bool? isPublic,
    bool? isEnabled,
    bool? isSystem,
    int? sortOrder,
    int? maxEmployees,
    int? maxTables,
    int? maxCategories,
    int? maxArticles,
    int? maxIngredients,
    bool? customerDiscovery,
    bool? tableQr,
    bool? customerOrdering,
    bool? inventory,
    bool? allowAppendingItems,
    bool? tableMultiOrder,
    bool? strictMode,
    bool? customAccessProfiles,
    DateTime? createdAt,
    List<_iaohraio.Building>? buildings,
    List<_iq3bhcsv.BuildingPackAssignment>? assignments,
  }) = _PackImpl;

  factory Pack.fromJson(Map<String, dynamic> jsonSerialization) {
    return Pack(
      id: jsonSerialization['id'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      code: jsonSerialization['code'] as String,
      name: jsonSerialization['name'] as String,
      monthlyMillimes: jsonSerialization['monthlyMillimes'] as int,
      annualMillimes: jsonSerialization['annualMillimes'] as int?,
      customerOrderFeeBps: jsonSerialization['customerOrderFeeBps'] as int?,
      isPublic: jsonSerialization['isPublic'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isPublic']),
      isEnabled: jsonSerialization['isEnabled'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isEnabled']),
      isSystem: jsonSerialization['isSystem'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isSystem']),
      sortOrder: jsonSerialization['sortOrder'] as int?,
      maxEmployees: jsonSerialization['maxEmployees'] as int?,
      maxTables: jsonSerialization['maxTables'] as int?,
      maxCategories: jsonSerialization['maxCategories'] as int?,
      maxArticles: jsonSerialization['maxArticles'] as int?,
      maxIngredients: jsonSerialization['maxIngredients'] as int?,
      customerDiscovery: jsonSerialization['customerDiscovery'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['customerDiscovery'],
            ),
      tableQr: jsonSerialization['tableQr'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['tableQr']),
      customerOrdering: jsonSerialization['customerOrdering'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['customerOrdering'],
            ),
      inventory: jsonSerialization['inventory'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['inventory']),
      allowAppendingItems: jsonSerialization['allowAppendingItems'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['allowAppendingItems'],
            ),
      tableMultiOrder: jsonSerialization['tableMultiOrder'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['tableMultiOrder'],
            ),
      strictMode: jsonSerialization['strictMode'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['strictMode']),
      customAccessProfiles: jsonSerialization['customAccessProfiles'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['customAccessProfiles'],
            ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      buildings: jsonSerialization['buildings'] == null
          ? null
          : _iaib1p48.Protocol().deserialize<List<_iaohraio.Building>>(
              jsonSerialization['buildings'],
            ),
      assignments: jsonSerialization['assignments'] == null
          ? null
          : _iaib1p48.Protocol()
                .deserialize<List<_iq3bhcsv.BuildingPackAssignment>>(
                  jsonSerialization['assignments'],
                ),
    );
  }

  static final t = PackTable();

  static const db = PackRepository._();

  @override
  _is.UuidValue? id;

  /// Stable id (`free`, `counter`). Set on create.
  String code;

  String name;

  int monthlyMillimes;

  int? annualMillimes;

  /// Customer-app order fee in basis points. 150 = 1.5%. Staff tickets are not charged.
  int customerOrderFeeBps;

  /// When true, apps may list this pack so an owner can upgrade.
  bool isPublic;

  /// When false, hidden from the public list.
  bool isEnabled;

  /// The free pack. Cannot be deleted.
  bool isSystem;

  int sortOrder;

  int? maxEmployees;

  int? maxTables;

  int? maxCategories;

  int? maxArticles;

  int? maxIngredients;

  bool customerDiscovery;

  bool tableQr;

  bool customerOrdering;

  bool inventory;

  bool allowAppendingItems;

  bool tableMultiOrder;

  bool strictMode;

  bool customAccessProfiles;

  DateTime createdAt;

  List<_iaohraio.Building>? buildings;

  List<_iq3bhcsv.BuildingPackAssignment>? assignments;

  @override
  _is.Table<_is.UuidValue?> get table => t;

  /// Returns a shallow copy of this [Pack]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Pack copyWith({
    _is.UuidValue? id,
    String? code,
    String? name,
    int? monthlyMillimes,
    int? annualMillimes,
    int? customerOrderFeeBps,
    bool? isPublic,
    bool? isEnabled,
    bool? isSystem,
    int? sortOrder,
    int? maxEmployees,
    int? maxTables,
    int? maxCategories,
    int? maxArticles,
    int? maxIngredients,
    bool? customerDiscovery,
    bool? tableQr,
    bool? customerOrdering,
    bool? inventory,
    bool? allowAppendingItems,
    bool? tableMultiOrder,
    bool? strictMode,
    bool? customAccessProfiles,
    DateTime? createdAt,
    List<_iaohraio.Building>? buildings,
    List<_iq3bhcsv.BuildingPackAssignment>? assignments,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Pack',
      if (id != null) 'id': id?.toJson(),
      'code': code,
      'name': name,
      'monthlyMillimes': monthlyMillimes,
      if (annualMillimes != null) 'annualMillimes': annualMillimes,
      'customerOrderFeeBps': customerOrderFeeBps,
      'isPublic': isPublic,
      'isEnabled': isEnabled,
      'isSystem': isSystem,
      'sortOrder': sortOrder,
      if (maxEmployees != null) 'maxEmployees': maxEmployees,
      if (maxTables != null) 'maxTables': maxTables,
      if (maxCategories != null) 'maxCategories': maxCategories,
      if (maxArticles != null) 'maxArticles': maxArticles,
      if (maxIngredients != null) 'maxIngredients': maxIngredients,
      'customerDiscovery': customerDiscovery,
      'tableQr': tableQr,
      'customerOrdering': customerOrdering,
      'inventory': inventory,
      'allowAppendingItems': allowAppendingItems,
      'tableMultiOrder': tableMultiOrder,
      'strictMode': strictMode,
      'customAccessProfiles': customAccessProfiles,
      'createdAt': createdAt.toJson(),
      if (buildings != null)
        'buildings': buildings?.toJson(valueToJson: (v) => v.toJson()),
      if (assignments != null)
        'assignments': assignments?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static PackInclude include({
    _iaohraio.BuildingIncludeList? buildings,
    _iq3bhcsv.BuildingPackAssignmentIncludeList? assignments,
  }) {
    return PackInclude._(
      buildings: buildings,
      assignments: assignments,
    );
  }

  static PackIncludeList includeList({
    _is.WhereExpressionBuilder<PackTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PackTable>? orderBy,
    _is.OrderByListBuilder<PackTable>? orderByList,
    PackInclude? include,
  }) {
    return PackIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Pack.t),
      orderByList: orderByList?.call(Pack.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PackImpl extends Pack {
  _PackImpl({
    _is.UuidValue? id,
    required String code,
    required String name,
    required int monthlyMillimes,
    int? annualMillimes,
    int? customerOrderFeeBps,
    bool? isPublic,
    bool? isEnabled,
    bool? isSystem,
    int? sortOrder,
    int? maxEmployees,
    int? maxTables,
    int? maxCategories,
    int? maxArticles,
    int? maxIngredients,
    bool? customerDiscovery,
    bool? tableQr,
    bool? customerOrdering,
    bool? inventory,
    bool? allowAppendingItems,
    bool? tableMultiOrder,
    bool? strictMode,
    bool? customAccessProfiles,
    DateTime? createdAt,
    List<_iaohraio.Building>? buildings,
    List<_iq3bhcsv.BuildingPackAssignment>? assignments,
  }) : super._(
         id: id,
         code: code,
         name: name,
         monthlyMillimes: monthlyMillimes,
         annualMillimes: annualMillimes,
         customerOrderFeeBps: customerOrderFeeBps,
         isPublic: isPublic,
         isEnabled: isEnabled,
         isSystem: isSystem,
         sortOrder: sortOrder,
         maxEmployees: maxEmployees,
         maxTables: maxTables,
         maxCategories: maxCategories,
         maxArticles: maxArticles,
         maxIngredients: maxIngredients,
         customerDiscovery: customerDiscovery,
         tableQr: tableQr,
         customerOrdering: customerOrdering,
         inventory: inventory,
         allowAppendingItems: allowAppendingItems,
         tableMultiOrder: tableMultiOrder,
         strictMode: strictMode,
         customAccessProfiles: customAccessProfiles,
         createdAt: createdAt,
         buildings: buildings,
         assignments: assignments,
       );

  /// Returns a shallow copy of this [Pack]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Pack copyWith({
    Object? id = _Undefined,
    String? code,
    String? name,
    int? monthlyMillimes,
    Object? annualMillimes = _Undefined,
    int? customerOrderFeeBps,
    bool? isPublic,
    bool? isEnabled,
    bool? isSystem,
    int? sortOrder,
    Object? maxEmployees = _Undefined,
    Object? maxTables = _Undefined,
    Object? maxCategories = _Undefined,
    Object? maxArticles = _Undefined,
    Object? maxIngredients = _Undefined,
    bool? customerDiscovery,
    bool? tableQr,
    bool? customerOrdering,
    bool? inventory,
    bool? allowAppendingItems,
    bool? tableMultiOrder,
    bool? strictMode,
    bool? customAccessProfiles,
    DateTime? createdAt,
    Object? buildings = _Undefined,
    Object? assignments = _Undefined,
  }) {
    return Pack(
      id: id is _is.UuidValue? ? id : this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      monthlyMillimes: monthlyMillimes ?? this.monthlyMillimes,
      annualMillimes: annualMillimes is int?
          ? annualMillimes
          : this.annualMillimes,
      customerOrderFeeBps: customerOrderFeeBps ?? this.customerOrderFeeBps,
      isPublic: isPublic ?? this.isPublic,
      isEnabled: isEnabled ?? this.isEnabled,
      isSystem: isSystem ?? this.isSystem,
      sortOrder: sortOrder ?? this.sortOrder,
      maxEmployees: maxEmployees is int? ? maxEmployees : this.maxEmployees,
      maxTables: maxTables is int? ? maxTables : this.maxTables,
      maxCategories: maxCategories is int? ? maxCategories : this.maxCategories,
      maxArticles: maxArticles is int? ? maxArticles : this.maxArticles,
      maxIngredients: maxIngredients is int?
          ? maxIngredients
          : this.maxIngredients,
      customerDiscovery: customerDiscovery ?? this.customerDiscovery,
      tableQr: tableQr ?? this.tableQr,
      customerOrdering: customerOrdering ?? this.customerOrdering,
      inventory: inventory ?? this.inventory,
      allowAppendingItems: allowAppendingItems ?? this.allowAppendingItems,
      tableMultiOrder: tableMultiOrder ?? this.tableMultiOrder,
      strictMode: strictMode ?? this.strictMode,
      customAccessProfiles: customAccessProfiles ?? this.customAccessProfiles,
      createdAt: createdAt ?? this.createdAt,
      buildings: buildings is List<_iaohraio.Building>?
          ? buildings
          : this.buildings?.map((e0) => e0.copyWith()).toList(),
      assignments: assignments is List<_iq3bhcsv.BuildingPackAssignment>?
          ? assignments
          : this.assignments?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class PackUpdateTable extends _is.UpdateTable<PackTable> {
  PackUpdateTable(super.table);

  _is.ColumnValue<String, String> code(String value) => _is.ColumnValue(
    table.code,
    value,
  );

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<int, int> monthlyMillimes(int value) => _is.ColumnValue(
    table.monthlyMillimes,
    value,
  );

  _is.ColumnValue<int, int> annualMillimes(int? value) => _is.ColumnValue(
    table.annualMillimes,
    value,
  );

  _is.ColumnValue<int, int> customerOrderFeeBps(int value) => _is.ColumnValue(
    table.customerOrderFeeBps,
    value,
  );

  _is.ColumnValue<bool, bool> isPublic(bool value) => _is.ColumnValue(
    table.isPublic,
    value,
  );

  _is.ColumnValue<bool, bool> isEnabled(bool value) => _is.ColumnValue(
    table.isEnabled,
    value,
  );

  _is.ColumnValue<bool, bool> isSystem(bool value) => _is.ColumnValue(
    table.isSystem,
    value,
  );

  _is.ColumnValue<int, int> sortOrder(int value) => _is.ColumnValue(
    table.sortOrder,
    value,
  );

  _is.ColumnValue<int, int> maxEmployees(int? value) => _is.ColumnValue(
    table.maxEmployees,
    value,
  );

  _is.ColumnValue<int, int> maxTables(int? value) => _is.ColumnValue(
    table.maxTables,
    value,
  );

  _is.ColumnValue<int, int> maxCategories(int? value) => _is.ColumnValue(
    table.maxCategories,
    value,
  );

  _is.ColumnValue<int, int> maxArticles(int? value) => _is.ColumnValue(
    table.maxArticles,
    value,
  );

  _is.ColumnValue<int, int> maxIngredients(int? value) => _is.ColumnValue(
    table.maxIngredients,
    value,
  );

  _is.ColumnValue<bool, bool> customerDiscovery(bool value) => _is.ColumnValue(
    table.customerDiscovery,
    value,
  );

  _is.ColumnValue<bool, bool> tableQr(bool value) => _is.ColumnValue(
    table.tableQr,
    value,
  );

  _is.ColumnValue<bool, bool> customerOrdering(bool value) => _is.ColumnValue(
    table.customerOrdering,
    value,
  );

  _is.ColumnValue<bool, bool> inventory(bool value) => _is.ColumnValue(
    table.inventory,
    value,
  );

  _is.ColumnValue<bool, bool> allowAppendingItems(bool value) =>
      _is.ColumnValue(
        table.allowAppendingItems,
        value,
      );

  _is.ColumnValue<bool, bool> tableMultiOrder(bool value) => _is.ColumnValue(
    table.tableMultiOrder,
    value,
  );

  _is.ColumnValue<bool, bool> strictMode(bool value) => _is.ColumnValue(
    table.strictMode,
    value,
  );

  _is.ColumnValue<bool, bool> customAccessProfiles(bool value) =>
      _is.ColumnValue(
        table.customAccessProfiles,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class PackTable extends _is.Table<_is.UuidValue?> {
  PackTable({super.tableRelation}) : super(tableName: 'pack') {
    updateTable = PackUpdateTable(this);
    code = _is.ColumnString(
      'code',
      this,
    );
    name = _is.ColumnString(
      'name',
      this,
    );
    monthlyMillimes = _is.ColumnInt(
      'monthlyMillimes',
      this,
    );
    annualMillimes = _is.ColumnInt(
      'annualMillimes',
      this,
    );
    customerOrderFeeBps = _is.ColumnInt(
      'customerOrderFeeBps',
      this,
      hasDefault: true,
    );
    isPublic = _is.ColumnBool(
      'isPublic',
      this,
      hasDefault: true,
    );
    isEnabled = _is.ColumnBool(
      'isEnabled',
      this,
      hasDefault: true,
    );
    isSystem = _is.ColumnBool(
      'isSystem',
      this,
      hasDefault: true,
    );
    sortOrder = _is.ColumnInt(
      'sortOrder',
      this,
      hasDefault: true,
    );
    maxEmployees = _is.ColumnInt(
      'maxEmployees',
      this,
    );
    maxTables = _is.ColumnInt(
      'maxTables',
      this,
    );
    maxCategories = _is.ColumnInt(
      'maxCategories',
      this,
    );
    maxArticles = _is.ColumnInt(
      'maxArticles',
      this,
    );
    maxIngredients = _is.ColumnInt(
      'maxIngredients',
      this,
    );
    customerDiscovery = _is.ColumnBool(
      'customerDiscovery',
      this,
      hasDefault: true,
    );
    tableQr = _is.ColumnBool(
      'tableQr',
      this,
      hasDefault: true,
    );
    customerOrdering = _is.ColumnBool(
      'customerOrdering',
      this,
      hasDefault: true,
    );
    inventory = _is.ColumnBool(
      'inventory',
      this,
      hasDefault: true,
    );
    allowAppendingItems = _is.ColumnBool(
      'allowAppendingItems',
      this,
      hasDefault: true,
    );
    tableMultiOrder = _is.ColumnBool(
      'tableMultiOrder',
      this,
      hasDefault: true,
    );
    strictMode = _is.ColumnBool(
      'strictMode',
      this,
      hasDefault: true,
    );
    customAccessProfiles = _is.ColumnBool(
      'customAccessProfiles',
      this,
      hasDefault: true,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final PackUpdateTable updateTable;

  /// Stable id (`free`, `counter`). Set on create.
  late final _is.ColumnString code;

  late final _is.ColumnString name;

  late final _is.ColumnInt monthlyMillimes;

  late final _is.ColumnInt annualMillimes;

  /// Customer-app order fee in basis points. 150 = 1.5%. Staff tickets are not charged.
  late final _is.ColumnInt customerOrderFeeBps;

  /// When true, apps may list this pack so an owner can upgrade.
  late final _is.ColumnBool isPublic;

  /// When false, hidden from the public list.
  late final _is.ColumnBool isEnabled;

  /// The free pack. Cannot be deleted.
  late final _is.ColumnBool isSystem;

  late final _is.ColumnInt sortOrder;

  late final _is.ColumnInt maxEmployees;

  late final _is.ColumnInt maxTables;

  late final _is.ColumnInt maxCategories;

  late final _is.ColumnInt maxArticles;

  late final _is.ColumnInt maxIngredients;

  late final _is.ColumnBool customerDiscovery;

  late final _is.ColumnBool tableQr;

  late final _is.ColumnBool customerOrdering;

  late final _is.ColumnBool inventory;

  late final _is.ColumnBool allowAppendingItems;

  late final _is.ColumnBool tableMultiOrder;

  late final _is.ColumnBool strictMode;

  late final _is.ColumnBool customAccessProfiles;

  late final _is.ColumnDateTime createdAt;

  _iaohraio.BuildingTable? ___buildings;

  _is.ManyRelation<_iaohraio.BuildingTable>? _buildings;

  _iq3bhcsv.BuildingPackAssignmentTable? ___assignments;

  _is.ManyRelation<_iq3bhcsv.BuildingPackAssignmentTable>? _assignments;

  _iaohraio.BuildingTable get __buildings {
    if (___buildings != null) return ___buildings!;
    ___buildings = _is.createRelationTable(
      relationFieldName: '__buildings',
      field: Pack.t.id,
      foreignField: _iaohraio.Building.t.packId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iaohraio.BuildingTable(tableRelation: foreignTableRelation),
    );
    return ___buildings!;
  }

  _iq3bhcsv.BuildingPackAssignmentTable get __assignments {
    if (___assignments != null) return ___assignments!;
    ___assignments = _is.createRelationTable(
      relationFieldName: '__assignments',
      field: Pack.t.id,
      foreignField: _iq3bhcsv.BuildingPackAssignment.t.packId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iq3bhcsv.BuildingPackAssignmentTable(
            tableRelation: foreignTableRelation,
          ),
    );
    return ___assignments!;
  }

  _is.ManyRelation<_iaohraio.BuildingTable> get buildings {
    if (_buildings != null) return _buildings!;
    var relationTable = _is.createRelationTable(
      relationFieldName: 'buildings',
      field: Pack.t.id,
      foreignField: _iaohraio.Building.t.packId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iaohraio.BuildingTable(tableRelation: foreignTableRelation),
    );
    _buildings = _is.ManyRelation<_iaohraio.BuildingTable>(
      tableWithRelations: relationTable,
      table: _iaohraio.BuildingTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _buildings!;
  }

  _is.ManyRelation<_iq3bhcsv.BuildingPackAssignmentTable> get assignments {
    if (_assignments != null) return _assignments!;
    var relationTable = _is.createRelationTable(
      relationFieldName: 'assignments',
      field: Pack.t.id,
      foreignField: _iq3bhcsv.BuildingPackAssignment.t.packId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iq3bhcsv.BuildingPackAssignmentTable(
            tableRelation: foreignTableRelation,
          ),
    );
    _assignments = _is.ManyRelation<_iq3bhcsv.BuildingPackAssignmentTable>(
      tableWithRelations: relationTable,
      table: _iq3bhcsv.BuildingPackAssignmentTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _assignments!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    code,
    name,
    monthlyMillimes,
    annualMillimes,
    customerOrderFeeBps,
    isPublic,
    isEnabled,
    isSystem,
    sortOrder,
    maxEmployees,
    maxTables,
    maxCategories,
    maxArticles,
    maxIngredients,
    customerDiscovery,
    tableQr,
    customerOrdering,
    inventory,
    allowAppendingItems,
    tableMultiOrder,
    strictMode,
    customAccessProfiles,
    createdAt,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'buildings') {
      return __buildings;
    }
    if (relationField == 'assignments') {
      return __assignments;
    }
    return null;
  }
}

class PackInclude extends _is.IncludeObject {
  PackInclude._({
    _iaohraio.BuildingIncludeList? buildings,
    _iq3bhcsv.BuildingPackAssignmentIncludeList? assignments,
  }) {
    _buildings = buildings;
    _assignments = assignments;
  }

  _iaohraio.BuildingIncludeList? _buildings;

  _iq3bhcsv.BuildingPackAssignmentIncludeList? _assignments;

  @override
  Map<String, _is.Include?> get includes => {
    'buildings': _buildings,
    'assignments': _assignments,
  };

  @override
  _is.Table<_is.UuidValue?> get table => Pack.t;
}

class PackIncludeList extends _is.IncludeList {
  PackIncludeList._({
    _is.WhereExpressionBuilder<PackTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Pack.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<_is.UuidValue?> get table => Pack.t;
}

class PackRepository {
  const PackRepository._();

  final attach = const PackAttachRepository._();

  final attachRow = const PackAttachRowRepository._();

  /// Returns a list of [Pack]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<Pack>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PackTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PackTable>? orderBy,
    _is.OrderByListBuilder<PackTable>? orderByList,
    _is.Transaction? transaction,
    PackInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Pack>(
      where: where?.call(Pack.t),
      orderBy: orderBy?.call(Pack.t),
      orderByList: orderByList?.call(Pack.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Pack] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<Pack?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PackTable>? where,
    int? offset,
    _is.OrderByBuilder<PackTable>? orderBy,
    _is.OrderByListBuilder<PackTable>? orderByList,
    _is.Transaction? transaction,
    PackInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Pack>(
      where: where?.call(Pack.t),
      orderBy: orderBy?.call(Pack.t),
      orderByList: orderByList?.call(Pack.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Pack] by its [id] or null if no such row exists.
  Future<Pack?> findById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    _is.Transaction? transaction,
    PackInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Pack>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Pack]s in the list and returns the inserted rows.
  ///
  /// The returned [Pack]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Pack>> insert(
    _is.DatabaseSession session,
    List<Pack> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Pack>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Pack] and returns the inserted row.
  ///
  /// The returned [Pack] will have its `id` field set.
  Future<Pack> insertRow(
    _is.DatabaseSession session,
    Pack row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Pack>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Pack]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [Pack]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Pack>> upsert(
    _is.DatabaseSession session,
    List<Pack> rows, {
    required _is.ColumnSelections<PackTable> conflictColumns,
    _is.ColumnSelections<PackTable>? updateColumns,
    _is.WhereExpressionBuilder<PackTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Pack>(
      rows,
      conflictColumns: conflictColumns(Pack.t),
      updateColumns: updateColumns?.call(Pack.t),
      updateWhere: updateWhere?.call(Pack.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Pack] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [Pack] will have its `id` field set.
  Future<Pack?> upsertRow(
    _is.DatabaseSession session,
    Pack row, {
    required _is.ColumnSelections<PackTable> conflictColumns,
    _is.ColumnSelections<PackTable>? updateColumns,
    _is.WhereExpressionBuilder<PackTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Pack>(
      row,
      conflictColumns: conflictColumns(Pack.t),
      updateColumns: updateColumns?.call(Pack.t),
      updateWhere: updateWhere?.call(Pack.t),
      transaction: transaction,
    );
  }

  /// Updates all [Pack]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Pack>> update(
    _is.DatabaseSession session,
    List<Pack> rows, {
    _is.ColumnSelections<PackTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Pack>(
      rows,
      columns: columns?.call(Pack.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Pack]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Pack> updateRow(
    _is.DatabaseSession session,
    Pack row, {
    _is.ColumnSelections<PackTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Pack>(
      row,
      columns: columns?.call(Pack.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Pack] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Pack?> updateById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    required _is.ColumnValueListBuilder<PackUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Pack>(
      id,
      columnValues: columnValues(Pack.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Pack]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Pack>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<PackUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<PackTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PackTable>? orderBy,
    _is.OrderByListBuilder<PackTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Pack>(
      columnValues: columnValues(Pack.t.updateTable),
      where: where(Pack.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Pack.t),
      orderByList: orderByList?.call(Pack.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Pack]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Pack>> delete(
    _is.DatabaseSession session,
    List<Pack> rows, {
    _is.OrderByBuilder<PackTable>? orderBy,
    _is.OrderByListBuilder<PackTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Pack>(
      rows,
      orderBy: orderBy?.call(Pack.t),
      orderByList: orderByList?.call(Pack.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Pack].
  Future<Pack> deleteRow(
    _is.DatabaseSession session,
    Pack row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Pack>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Pack>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PackTable> where,
    _is.OrderByBuilder<PackTable>? orderBy,
    _is.OrderByListBuilder<PackTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Pack>(
      where: where(Pack.t),
      orderBy: orderBy?.call(Pack.t),
      orderByList: orderByList?.call(Pack.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PackTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Pack>(
      where: where?.call(Pack.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Pack] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PackTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Pack>(
      where: where(Pack.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class PackAttachRepository {
  const PackAttachRepository._();

  /// Creates a relation between this [Pack] and the given [Building]s
  /// by setting each [Building]'s foreign key `packId` to refer to this [Pack].
  Future<void> buildings(
    _is.DatabaseSession session,
    Pack pack,
    List<_iaohraio.Building> building, {
    _is.Transaction? transaction,
  }) async {
    if (building.any((e) => e.id == null)) {
      throw ArgumentError.notNull('building.id');
    }
    if (pack.id == null) {
      throw ArgumentError.notNull('pack.id');
    }

    var $building = building.map((e) => e.copyWith(packId: pack.id)).toList();
    await session.db.update<_iaohraio.Building>(
      $building,
      columns: [_iaohraio.Building.t.packId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Pack] and the given [BuildingPackAssignment]s
  /// by setting each [BuildingPackAssignment]'s foreign key `packId` to refer to this [Pack].
  Future<void> assignments(
    _is.DatabaseSession session,
    Pack pack,
    List<_iq3bhcsv.BuildingPackAssignment> buildingPackAssignment, {
    _is.Transaction? transaction,
  }) async {
    if (buildingPackAssignment.any((e) => e.id == null)) {
      throw ArgumentError.notNull('buildingPackAssignment.id');
    }
    if (pack.id == null) {
      throw ArgumentError.notNull('pack.id');
    }

    var $buildingPackAssignment = buildingPackAssignment
        .map((e) => e.copyWith(packId: pack.id))
        .toList();
    await session.db.update<_iq3bhcsv.BuildingPackAssignment>(
      $buildingPackAssignment,
      columns: [_iq3bhcsv.BuildingPackAssignment.t.packId],
      transaction: transaction,
    );
  }
}

class PackAttachRowRepository {
  const PackAttachRowRepository._();

  /// Creates a relation between this [Pack] and the given [Building]
  /// by setting the [Building]'s foreign key `packId` to refer to this [Pack].
  Future<void> buildings(
    _is.DatabaseSession session,
    Pack pack,
    _iaohraio.Building building, {
    _is.Transaction? transaction,
  }) async {
    if (building.id == null) {
      throw ArgumentError.notNull('building.id');
    }
    if (pack.id == null) {
      throw ArgumentError.notNull('pack.id');
    }

    var $building = building.copyWith(packId: pack.id);
    await session.db.updateRow<_iaohraio.Building>(
      $building,
      columns: [_iaohraio.Building.t.packId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Pack] and the given [BuildingPackAssignment]
  /// by setting the [BuildingPackAssignment]'s foreign key `packId` to refer to this [Pack].
  Future<void> assignments(
    _is.DatabaseSession session,
    Pack pack,
    _iq3bhcsv.BuildingPackAssignment buildingPackAssignment, {
    _is.Transaction? transaction,
  }) async {
    if (buildingPackAssignment.id == null) {
      throw ArgumentError.notNull('buildingPackAssignment.id');
    }
    if (pack.id == null) {
      throw ArgumentError.notNull('pack.id');
    }

    var $buildingPackAssignment = buildingPackAssignment.copyWith(
      packId: pack.id,
    );
    await session.db.updateRow<_iq3bhcsv.BuildingPackAssignment>(
      $buildingPackAssignment,
      columns: [_iq3bhcsv.BuildingPackAssignment.t.packId],
      transaction: transaction,
    );
  }
}
