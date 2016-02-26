$(document).ready( function(){
  $('#search-form').submit(function(){
    $('#input_1').hide();
    $('#input_2').hide();
    $('#input_3').hide();
    $('#results').html('<div class="text-center"><h3>Loading</h3><div class="drip"></div></div>');
    var timeout1 = setTimeout(function(){
      $('#results').html("<div class='text-center'><h3 >Loading</h3><p>Sometimes Wolfram|Alpha takes a while to load</p><div class='drip'></div></div>");
    }, 5000);
    var timeout2 = setTimeout(function(){
      $('#results').html("<div class='text-center'><h3 >Loading</h3><p>Sometimes Wolfram|Alpha takes a while to load.</p><p>Maybe Wolfram|Alpha doesn't have all of the answers ... </p><div class='drip'></div></div>");
    }, 15000);
      clearTimeout(timeout1);
      clearTimeout(timeout2);
  });

  $('#user1_event').click(function(){
    $('#input_1').toggle();
  });
  $('#user2_event').click(function(){
    $('#input_2').toggle();
  });
  $('#user3_event').click(function(){
    $('#input_3').toggle();
  });
});
