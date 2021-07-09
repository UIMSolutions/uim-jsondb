module uim.jsondb.mongo;

@safe:
import uim.jsondb;

class DJSNMongoDb : DJSNDb {
  this() {}
}
auto JSNMongoDb() { return new DJSNMongoDb; }