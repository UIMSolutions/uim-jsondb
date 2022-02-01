module uim.datasource.mongo;

@safe:
import uim.datasource;

class DJSNMongoDb : DJSNDb {
  this() { super(); }
}
auto JSNMongoDb() { return new DJSNMongoDb; }