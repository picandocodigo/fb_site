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
