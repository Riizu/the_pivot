$(document).ready(function () {
  var $spaces = $('.space');

  $('#space_filter_climates').on('change', function () {
    var currentStyle = this.value;
    $spaces.each(function (index, space) {
      $space = $(space);
      if ($space.data('climate') === currentStyle) {
        $space.show();
      } else if (currentStyle === "All Spaces") {
        $space.show();
      } else {
        $space.hide();
      }
    });
  });

});
