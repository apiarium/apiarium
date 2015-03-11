top.config = {};

// Grid is based on 12 sections, so 12/statusHorizPanels should be a whole number. 
// Usually 3, 4, and 6 seem to look the best. 
top.config.statusHorizPanels = 4;

// Number of horizontal panels to be used on the "Injects" page. Keep in mind that 
// there's a sidebar to choose the inject along the left-hand side of the page.
top.config.injectHorizPanels = 3; 

// Use the  number of horizontal panels desired into a usable width.
// Ceiling function used to fail gracefully if  3, 4, or 6 isn't used.
function columnWidthSubstitution(horizPanels){
    return Math.ceil(12/(horizPanels));
}

// converts error codes 0 through 4 to usable strings
function stateToColorName(state){
    switch(state){
        //  RUNNING, STOPPED, WAITING, UNKNOWN, ERROR = range(5)
        case 0:
            return ['success','RUNNING','green'];    // green
        break;
        case 1:
            return ['warning',"STOPPED",'red'];    // yellow
        break;
        case 2:
            return ['info',"WAITING",'yellow'];       // light blue
        break;
        case 3:
            return ['default',"UNKNOWN",'black'];    // white/gray
        break;
        case 4:
            return ['danger',"ERROR",'red'];       // red
        break;
    }
}

function DumpObject(obj)
{
    return '{' + DumpObjectHelper(obj).replace(/\n/g,'\\n').replace(/\r/g,'\\r').replace(/\t/g,'\\t') + '}';
}

function DumpObjectHelper(obj)
{
  var result = "";

  for (var property in obj)
  {
    var value = obj[property];
    if (typeof value == 'string')
      value = "'" + value + "'";
    else if (typeof value == 'object')
    {
      var od = DumpObjectHelper(value);
      value = "{" + od + "}";
    }
	value = ""+value;
	value = value.replace(/"/g,"\\'").replace(/\r/g,"\\r").replace(/\n/g,"\\n");
    result += "'" + property + "':" + value + ",\n";
  }
  return result.replace(/,\n$/, "").replace(/\n/g,"");
}

// Use to print out an object's properties recursively
function DumpObjectIndented(obj, indent)
{
  var result = "";
  if (indent == null) indent = "";

  for (var property in obj)
  {
    var value = obj[property];
    if (typeof value == 'string')
      value = "'" + value + "'";
    else if (typeof value == 'object')
    {
      var od = DumpObjectIndented(value, indent + "  ");
      value = "\n" + indent + "{\n" + od + "\n" + indent + "}";
    }
    result += indent + "'" + property + "' : " + value + ",\n";
  }
  return result.replace(/,\n$/, "");
}


if(typeof console === 'undefined'){
    // Make a logger
    console = Object();
    appendError = function(str){
        throw new Error("Debug: "+str);
    }
    console.log = function(str){
        var caller_line = (new Error).stack.split('\n')[4];
        var patt = /([0-9]+)$/;
        var line =  patt.exec(caller_line);
        if(line != null){
            setTimeout("appendError('Line "+line[0]+": "+str+"')",0.01);
        } else {
            setTimeout("appendError('"+caller_line+": "+str+"')",0.01);
        }
    }
}
if(typeof String.prototype.contains === 'undefined') {
    String.prototype.contains = function(it){return this.indexOf(it) != -1;}
}

