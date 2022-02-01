module uim.datasource.hybrid;

@safe:
import uim.datasource;

class DJSNHybridDb : DJSNDb {
  this() { super(); }
}
auto JSNHybridDb() { return new DJSNHybridDb; }