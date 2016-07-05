$(document).ready(function () {
  var $spaces = $('.one-sock');

  $('#space_filter_climates').on('change', function () {
    var currentStyle = this.value;
    $spaces.each(function (index, space) {
      $space = $(space);
      console.log($space.data('style'));
      if ($space.data('style') === currentStyle) {
        $space.show();
      } else {
        $space.hide();
      }
    });
  });

});
