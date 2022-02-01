module uim.datasource.file;

@safe:
import uim.datasource;

class DJSNFileDb : DJSNDb {
  this() { super(); }
  
  
}
auto JSNFileDb() { return new DJSNFileDb; }