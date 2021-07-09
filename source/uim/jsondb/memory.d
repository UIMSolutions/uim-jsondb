module uim.jsondb.memory;

@safe:
import uim.jsondb;

class DJSNMemoryDb : DJSNDb {
  this() {}
}
auto JSNMemoryDb() { return new DJSNMemoryDb; }