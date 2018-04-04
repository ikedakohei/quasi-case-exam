$(function () {
  $('#mypage-image-form').on('change', function (e) {
    var file = e.target.files[0],
      reader = new FileReader();

    if (file.type.indexOf('image') < 0) {
      return false;
    }

    reader.onload = (function (file) {
      return function (e) {
        $('#mypage-avator').hide();
        $('#preview').empty().append($('<img>').attr({
          src: e.target.result,
          class: 'rounded-circle mypage-image',
          id: 'preview'
        }));
      };
    })(file);

    reader.readAsDataURL(file);
  });
});