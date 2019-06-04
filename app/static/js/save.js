
function Save(){
  var input = document.getElementById("input")
  localStorage.text = input.value
  document.getElementById("result").innerHTML = localStorage.getItem("text");
}
