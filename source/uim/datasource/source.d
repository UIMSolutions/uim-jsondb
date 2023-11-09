module uim.datasource.source;

@safe:
import uim.datasource;

abstract class DJSNDb {
  this() { this.separator(":"); }

  mixin(SProperty!("string", "separator"));

  DJSNDb connect() { return this; }
  DJSNDb cleanupConnections() { return this; }

  string[] collectionNames() { return null; }
  
  string uniqueName(string source, string pool, string startName) {
    return uniqueName(source ~ separator ~ pool, startName); }
  string uniqueName(string collectionName, string startName) {
    string result = startName;
    while (count(collectionName, ["name": result]) > 0)
      result = startName ~ "-" ~ to!string(uniform(0, 999999));
    return result;
  }

  Json lastVersion(string colName, UUID id) { return Json(null); }
  size_t lastVersionNumber(string colName, UUID id) { return 0; }
  
  Json[] lastVersions(string colName) {
    Json[] results;
    return results;
  }

  Json[] versions(string colName, UUID id) {
    return null;
  }

  Json[] versions(Json[size_t][UUID] col, UUID id) {
    if (id !in col) return null;
    return col[id].byValue.array; }

  Json[] versions(Json[size_t] entity) { 
    return entity.byValue.array; }

  // link structure = uuid.versionMajor.versionMinor
  size_t countAll(string source, string pool, bool allVersions = false) {
    return countAll(source ~ separator ~ pool, allVersions); }
  size_t countAll(string collectionName, bool allVersions = false) { 
    return find(collectionName, allVersions).length; }

  size_t count(string source, string pool, UUID id, bool allVersions = false) {
    return count(source ~ separator ~ pool, id, allVersions); }
  size_t count(string collectionName, UUID id, bool allVersions = false) {
    return find(collectionName, id, allVersions).length; }

  size_t count(string source, string pool, DOOPEntity anEntity, bool allVersions = false) {
    return count(source ~ separator ~ pool, anEntity, allVersions); }
  size_t count(string collectionName, DOOPEntity anEntity, bool allVersions = false) {
    return find(collectionName, anEntity, allVersions).length; }

  size_t count(string source, string pool, STRINGAA select, bool allVersions = false) {
    return count(source ~ separator ~ pool, select, allVersions); }
  size_t count(string collectionName, STRINGAA select, bool allVersions = false) {
    return find(collectionName, select, allVersions).length; }

  size_t count(string source, string pool, Json select, bool allVersions = false) {
    return count(source ~ separator ~ pool, select, allVersions); }
  size_t count(string collectionName, Json select, bool allVersions = false) {
    return find(collectionName, select, allVersions).length; }

  Json[] find(string source, string[] pools, bool allVersions = false) {
    return pools
      .map!(pool => find(source, pool, allVersions))
      .array;
  }

  Json[] find(string[] pools, bool allVersions = false) {
    return pools
      .map!(pool => find(pool, allVersions))
      .array;
  }

  Json[] find(string source, string[] pools, UUID[] ids, bool allVersions = false) {
    return pools
      .map!(pool => find(source, pool, ids, allVersions))
      .array
  }

  Json[] find(string[] pools, UUID[] ids, bool allVersions = false) {
    return pools
      .map!(pool => find(pool, ids, allVersions))
      .array
  }

  Json[] find(string source, string[] pools, UUID id, bool allVersions = false) {
    return pools
      .map!(a => find(source, a, id, allVersions))
      .array;
  }

  Json[] find(string[] pools, UUID id, bool allVersions = false) {
    return pools
      .map!(pool => find(pool, id, allVersions))
      .array;
  }

  Json[] find(string source, string[] pools, DOOPEntity entity, bool allVersions = false) {
    return pools
      .map!(pool => find(source, pool, entity, allVersions))
      .array;
  }

  Json[] find(string[] pools, DOOPEntity entity, bool allVersions = false) {
    Json[] results;
    foreach(pool; pools) results ~= find(pool, entity, allVersions);
    return results;
  }

  Json[] find(string source, string[] pools, STRINGAA select, bool allVersions = false) {
    return pools
      .map!(pool => find(pool, select, allVersions))
      .array;
  }

  Json[] find(string[] collectionNames, STRINGAA select, bool allVersions = false) {
    return collectionNames
      .map!(cName => find(cName, select, allVersions))
      .array;
  }

  Json[] find(string source, string[] collectionNames, Json select, bool allVersions = false) {
    return collectionNames
      .map!(cName => find(source, cName, select, allVersions))
      .array;
  }

  Json[] find(string[] collectionNames, Json select, bool allVersions = false) {
    return collectionNames
      .map!(cName => find(cName, select, allVersions))
      .array
  }

  // Search pool
  Json[] find(string source, string pool, bool allVersions = false) {
    return find(source ~ separator ~ pool, allVersions);
  }

  Json[] find(string collectionName, bool allVersions = false) { return null; }

  Json[] find(string source, string pool, UUID[] ids, bool allVersions = false) {    
    return find(source ~ separator ~ pool, ids, allVersions);
  }

  Json[] find(string collectionName, UUID[] ids, bool allVersions = false) {
    Json[] results;
    ids.each!(a => results ~= find(collectionName, a, allVersions));
    return results;
  }

  Json[] find(string source, string pool, UUID id, bool allVersions = false) {
    return find(source ~ separator ~ pool, id, allVersions); }
  Json[] find(string collectionName, UUID id, bool allVersions = false) {
    return find(collectionName, ["id": id.toString]); }

  Json[] find(string source, string pool, DOOPEntity anEntity, bool allVersions = false) {
    return find(source ~ separator ~ pool, anEntity, allVersions); }
  Json[] find(string collectionName, DOOPEntity anEntity, bool allVersions = false) {
    return find(collectionName, ["id": anEntity.id.toString, "versionNumber": to!string(anEntity.versionNumber)], allVersions); }

  Json[] find(string source, string pool, STRINGAA select, bool allVersions = false) {
    return find(source ~ separator ~ pool, select, allVersions); }
  Json[] find(string collectionName, STRINGAA select, bool allVersions = false) {
    auto results = find(collectionName, allVersions); 
    foreach(k; select.byKey()) results = results.filter!(a => k in a && select[k] == a[k].get!string).array;
    return results;
  }

  Json[] find(string source, string pool, Json select, bool allVersions = false) {
    return find(source ~ separator ~ pool, select, allVersions); }
  Json[] find(string collectionName, Json select, bool allVersions = false) {
    auto results = find(collectionName, allVersions); 
    foreach(kv; select.byKeyValue) 
      results = results.filter!(a => kv.key in a && kv.value.get!string == a[kv.key].get!string).array;
    return results;
  }

  // findOne (find first)
  Json findOne(string source, string colName, UUID id) {
    return findOne(source ~ separator ~ colName, id); }
  Json findOne(string collectionName, UUID id) {
    if (auto findings = find(collectionName, ["id": id.toString])) 
      return findings[0];
    return Json(null); } 

  Json findOne(string source, string colName, DOOPEntity anEntity) {
    return findOne(source ~ separator ~ colName, anEntity); }
  Json findOne(string collectionName, DOOPEntity anEntity) {
    if (auto findings = find(collectionName, anEntity)) 
      return findings[0]; 
    return Json(null); } 

  Json findOne(string source, string colName, STRINGAA select) {
    return findOne(source ~ separator ~ colName, select); }
  Json findOne(string collectionName, STRINGAA select) {
    if (auto findings = find(collectionName, select)) 
      return findings[0]; 
    return Json(null); } 

  Json findOne(string source, string colName, Json select) {
    return findOne(source ~ separator ~ colName, select); }
  Json findOne(string collectionName, Json select) {
    if (auto findings = find(collectionName, select)) 
      return findings[0]; 
    return Json(null); } 

  Json[] opIndex(UUID id) {
    Json[] results;
    results ~= find("attclasses", ["id": id.toString]);
    results ~= find("objclasses", ["id": id.toString]);
    results ~= find("attributes", ["id": id.toString]);
    results ~= find("objects", ["id": id.toString]);
    return results;
  }

  DJSNDb create(DOOPEntity[] entities) {
    entities.each!(a => create(a.entityClasses, a.toJson));
    return this;
  }

  DJSNDb create(string source, string aPool, Json newData) {
    return this.create(source ~ separator ~ aPool, newData); }
  DJSNDb create(string collectionName, Json newData) {
    return this; }

  // --- Update
  DJSNDb update(string source, string aPool, STRINGAA aSelector, DOOPEntity anEntity) {
    return this.update(source ~ separator ~ aPool, aSelector, anEntity); }
  DJSNDb update(string collectionName, STRINGAA aSelector, DOOPEntity anEntity) {
    return this.update(collectionName, aSelector, anEntity.toJson);
  }

  DJSNDb update(string source, string aPool, Json aSelector, DOOPEntity anEntity) {
    return this.update(source ~ separator ~ aPool, aSelector, anEntity); }
  DJSNDb update(string collectionName, Json aSelector, DOOPEntity anEntity) {
    return this.update(collectionName, aSelector, anEntity.toJson); }

  DJSNDb update(string source, string aPool, STRINGAA aSelector, Json updateData) {
    return this.update(source ~ separator ~ aPool, aSelector, updateData); }
  DJSNDb update(string collectionName, STRINGAA aSelector, Json updateData) {
    return this.update(collectionName, aSelector.serializeToJson, updateData); }

  DJSNDb update(string source, string aPool, Json aSelector, Json updateData) {
    return this.update(source ~ separator ~ aPool, aSelector, updateData); }
  DJSNDb update(string collectionName, Json aSelector, Json updateData) {
    return this; }

  DJSNDb remove(STRINGAA selector) {
    this
    .remove("models", selector)
    .remove("attclasses", selector)
    .remove("objclasses", selector)
    .remove("objects", selector);
    return this;
  }

  DJSNDb remove(string source, string aPool, STRINGAA aSelector) {
    return this.remove(source ~ separator ~ aPool, aSelector); }
  DJSNDb remove(string collectionName, STRINGAA selector) {
    return this; }

  DJSNDb remove(string source, string aPool, Json aSelector) {
    return this.remove(source ~ separator ~ aPool, aSelector); }
  DJSNDb remove(string collectionName, Json selector) {
    return this; }

  Json[] log(UUID id) {
    return find("logs", id);
  }

  DJSNDb log(UUID id, Json json) {
    auto logEntry = Json.emptyObject;
    logEntry["id"] = id.toString;
    logEntry["data"] = json;

    create("logs", logEntry);
    return this;
  } 
}