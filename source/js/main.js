var code = [38, 38, 40, 40, 37, 39, 37, 39, 66, 65];
var input = [];

document.onkeyup = function(key){
  for(var i = 0; i < code.length; i++){
    if (key.which == code[i]){
      input.push(code[i]);
      if (input[i] == code[i]){
        if (arraysEqual(code, input)){
          document.getElementById("konami").className = "visible";
          document.getElementById("contra").className = "visible";
          document.getElementById("main").style.marginTop = "195px";
        }
      }else{
        input = [];
      }
      break;
    }
  }
  return false;
};

function arraysEqual(a, b) {
  if (a === b) return true;
  if (a === null || b === null) return false;
  if (a.length != b.length) return false;

  for (var i = 0; i < a.length; ++i) {
    if (a[i] !== b[i]) return false;
  }
  return true;
}
