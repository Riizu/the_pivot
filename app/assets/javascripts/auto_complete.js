$( document ).ready(function() {

  function parseData(data){
    var planets = [];
    data.forEach(function(planet){
      planets.push({value: planet.name});
    });
    $('#autocomplete').autocomplete({
      source: planets
    });
  }

  var handlers = {
    get: $.ajax({
      url: "/api/getplanetnames",
      verb: "GET",
      success: function(data){
        parseData(data);
      },
      error: function(){
        alert("We were not able to retrieve any planets");
      }
    })
  };

});
