$( document ).ready(function() {
  var checkInInput = $('#datepicker-checkin');
  var checkOutInput = $('#datepicker-checkout');
  setUpCheckInDatePicker();
  setUpCheckOutDatePicker();
  setUpCheckInListener();
  setUpCheckOutListener();

  function setUpCheckInDatePicker(maxDate) {
    var today = new Date();
    if (maxDate !== undefined)
      maxDate = new Date(new Date(maxDate).getTime() - 24 * 60 * 60 * 1000);
    $(checkInInput).datepicker({
      minDate: today,
      maxDate: maxDate
    });
  }

  function setUpCheckOutDatePicker(minDate) {
    if (minDate === undefined)
      minDate = new Date(new Date().getTime() + 24 * 60 * 60 * 1000);
    else
      minDate = new Date(new Date(minDate).getTime() + 24 * 60 * 60 * 1000);
    $(checkOutInput).datepicker({
      minDate: minDate
    });
  }

  function setUpCheckInListener() {
    $(checkInInput).on('change', function() {
      var date = $(checkInInput).val();
      $(checkOutInput).datepicker("destroy");
      if (date === '')
        date = new Date();
      setUpCheckOutDatePicker(date);
    });
  }

  function setUpCheckOutListener() {
    $(checkOutInput).on('change', function() {
      var date = $(checkOutInput).val();
      $(checkInInput).datepicker("destroy");
      if (date === '')
        date = new Date();
      setUpCheckInDatePicker(date);
    });
  }
});
