$(function() {
  $('.datepicker').datetimepicker({
    locale: 'ja',
    format: 'YYYY/MM/DD',
    icons: {
      previous: 'fa fa-arrow-left',
      next:     'fa fa-arrow-right',
    },
  }
  );
});