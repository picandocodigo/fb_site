document.getElementById("programmer").addEventListener("click", function(){
  toggleVisible('programming');
});

document.getElementById("speaker").addEventListener("click", function(){
  toggleVisible('speaking');
});

function toggleVisible(id){
  var thing =  document.getElementById(id);
  if(thing.classList.contains("hidden")){
    thing.className = "visible";
  } else {
    thing.className = "hidden";
  }
}

var elements = document.querySelectorAll('.hiddable');
var length = elements.length;

for(var i = 0; i < length; i++){
  elements[i].childNodes[1].addEventListener('click', function(){
    var element = get_hiddable(this.parentNode);
    if(element){
      if(element.classList.contains('hidden')){
        element.className = "hiddable_content visible";
      } else {
        element.className = "hiddable_content hidden";
      }
    }
  });
}

function get_hiddable(element){
  var length = element.childElementCount;
  var children = element.children;
  for(var i = 0; i < length; i++){
    if (children[i].className.indexOf("hiddable_content") > - 1){
      return children[i];
    }
  }
}
