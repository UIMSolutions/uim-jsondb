module uim.jsondb.file;

@safe:
import uim.jsondb;

class DJSNFileDb : DJSNDb {
  this() {}
}
auto JSNFileDb() { return new DJSNFileDb; }