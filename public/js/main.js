var _gaq = _gaq || [];
_gaq.push(['_setAccount', 'UA-2107177-10']);
_gaq.push(['_trackPageview']);
(function() {
  var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
  ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
  var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
})();

var code = [38, 38, 40, 40, 37, 39, 37, 39, 66, 65];
var input = []

document.onkeyup = function(key){
  for(var i = 0; i < code.length; i++){
    if (key.which == code[i]){
      input.push(code[i]);
      if (input[i] == code[i]){
        if (arraysEqual(code, input)){
          alert("****KONAMI CODE****\nYou get 30 lives! :D");
          window.location = "https://github.com/picandocodigo/konami_code#konami-code";
        }
      }else{
        input = [];
      }
      break;
    }
  }
  return false;
}

function arraysEqual(a, b) {
  if (a === b) return true;
  if (a == null || b == null) return false;
  if (a.length != b.length) return false;

  for (var i = 0; i < a.length; ++i) {
    if (a[i] !== b[i]) return false;
  }
  return true;
}