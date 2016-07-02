$( document ).ready(function() {
  var checkInInput = $('#datepicker-checkin');
  var checkOutInput = $('#datepicker-checkout');
  setUpCheckInDatePicker();
  setUpCheckOutDatePicker();
  setUpCheckInListener();
  setUpCheckOutListener();

  function setUpCheckInDatePicker(maxDate) {
    var today = new Date();
    $(checkInInput).datepicker({
      minDate: today,
      maxDate: maxDate
    });
  }

  function setUpCheckOutDatePicker(today) {
    if (today === undefined)
      today = new Date();
    $(checkOutInput).datepicker({
      minDate: today
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
