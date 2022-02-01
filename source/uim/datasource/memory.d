module uim.datasource.memory;

@safe:
import uim.datasource;

class DJSNMemoryDb : DJSNDb {
  this() { super(); }
}
auto JSNMemoryDb() { return new DJSNMemoryDb(); }