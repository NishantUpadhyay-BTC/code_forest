var Common = {
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
    if($("#description")[0].value.trim() == "")
    {
      Materialize.toast("description can't be blank. <a href='javascript:;' onclick='closeToast();'><i class='material-icons close'>close</i></a>", 4000, 'red');
      return false;
    }
    $("#p_decription").text($("#description")[0].value);
    $("#repository_description").val($("#description")[0].value);
    if($('#tag_list')[0].value != ""){
      $("#repository_tag_list").val($('#tag_list')[0].value);
      $("#display_tags").append(Common.displayTags());
    }
    $("#repository_preview").show();
    $("#repository_update").hide();
  },

  showRepositoriesOnScroll: function () {
    if ((previousPage < nextPage) && $(window).scrollTop() > $(document).height() - $(window).height() - 60) {
      path = "/repositories/";
      data = { page: nextPage };
      if ($("#header_keyword")[0].value != "" || $('#language')[0].value != "All")
      {
        path = "/repositories/search/";
        data = Object.assign({},data, {key_word: $("#header_keyword")[0].value,
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
    Common.syncTwoForms(searchFormId);
    $(searchFormId).trigger('submit.rails');
    $("html,body").animate({
      scrollTop: $(window).height() - 64
    }, "slow");
    $('#search_fields').css({
      'display': 'block'
    });
    return false;
  },

  searchRepoByKeyword: function (searchFormId, keywordId) {
    if($(keywordId)[0].value.length == 0){
      $(searchFormId).trigger('submit.rails');
      $("html,body").animate({
        scrollTop: $(window).height() - 64
      }, "slow");
      return false;
    }
  },

  displayTags: function() {
    var tags = $('#tag_list')[0].value.split(",");
    var tag_divs = "";
    for(i=0; i<tags.length; i++)
    {
      tag_divs= tag_divs + "<div class='chip'><a href='/repositories/tag/"+tags[i] +"'>" + tags[i] + "</a></div>";
    }
    return tag_divs;
  },

  scrollTopOnSearch: function (searchFormId) {
    Common.syncTwoForms(searchFormId);
    $("html,body").animate({
      scrollTop: $(window).height() - 64
    }, "slow");
  },

  syncTwoForms: function (searchFormId) {
    var selectedLanguage = $(searchFormId)[0].elements[1].value;
    var keyword = $(searchFormId)[0].elements[3].value
    var changeSelect = searchFormId.id == 'index_search' ? '#header_search' : '#index_search';
    $(changeSelect)[0].elements[1].value = selectedLanguage;
    $(changeSelect)[0].elements[3].value = keyword;
  }
}
