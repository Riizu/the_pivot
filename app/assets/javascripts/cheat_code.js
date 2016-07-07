var secretCode = [38, 38, 40, 40, 37, 39, 37, 39, 66, 65],
    codeIndex = 0;

var audioElement = document.createElement('audio');
    audioElement.setAttribute('src', "http://www.pacdv.com/sounds/fart-sounds/fart-1.wav");
    $.get();
    audioElement.addEventListener("load", function() {
      audioElement.play();
    }, true);

$(document).keyup(function(e){
    if (e.which === secretCode[codeIndex]) {
        codeIndex++;
    } else {
        codeIndex = 0;
    }
    if (codeIndex === secretCode.length) {
        codeIndex = 0;
        $('#cheat-image').fadeIn();
        audioElement.play();
        $('#cheat-image').delay(3000).fadeOut();
    }
});
