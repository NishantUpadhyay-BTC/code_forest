var tagsString = "";
var Common = {
  displayTags: function (e) {
    var appendTags = "<div class='chip'>" + ($("#tag_list")[0].value + "</div>");
    if (e.which == 13 && $("#tag_list")[0].value.trim() != "") {
      $('#div_for_tags').append(appendTags);
      $('#display_tags').append(appendTags);
      tagsString = tagsString.concat($("#tag_list")[0].value.trim() + ", ");
      $("#tag_list")[0].value = "";
    }
  },

  uploadImage: function (e, file) {
    var reader = new FileReader();
    reader.onload = function (e) {
      $("#image").attr('src', e.target.result);
      $("#image_preview").attr('src', e.target.result);
      $("#poc_image").attr('src', e.target.result);
    };
    reader.readAsDataURL(file);
  },

  triggerPOCImage: function () {
    $("#poc_image").trigger('click');
  },

  displayPreview: function () {
    $("#p_decription").text($("#description")[0].value);
    $("#repository_description").val($("#description")[0].value);
    $("#repository_tag_list").val(tagsString);
    $("#repository_preview").show();
    $("#repository_update").hide();
  },

  showRepositoriesOnScroll: function () {
    if ((previousPage < nextPage) && $(window).scrollTop() > $(document).height() - $(window).height() - 60) {
      path = "/repositories/";
      data = { page: nextPage };
      if ($("#key_word")[0].value != "" || $('#language')[0].value != "All")
      {
        path = "/repositories/search/";
        data = Object.assign({},data, {key_word: $("#key_word")[0].value,
                                      language: $("#language")[0].value,
                                      append: true});
      }

      $.ajax({
        url: path,
        type: 'get',
        dataType: 'script',
        data: data
      });
      previousPage = nextPage;
      return;
    }
  },

  showOrHideRepo: function (path) {
    $.ajax({
    url: path,
    type: 'put'});
  },

  searchRepoByLanguage: function (searchFormId) {
    $(searchFormId).trigger('submit.rails');
  },

  searchRepoByKeyword: function (searchFormId) {
    if($('#key_word')[0].value.length == 0){
      $("#searchform").trigger('submit.rails');
    }
  }
}
