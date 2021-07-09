module uim.jsondb.hybrid;

@safe:
import uim.jsondb;

class DJSNHybridDb : DJSNDb {
  this() {}
}
auto JSNHybridDb() { return new DJSNHybridDb; }