$(function() {
  $("#searchPartialView .listHeaderSection a, #searchPartialView .pagination a").live("click", function() {
    $.getScript(this.href);
    return false;
  });
  $("#listSearch input").keyup(function() {
    $.get($("#listSearch").attr("action"), $("#listSearch").serialize(), null, "script");
    return false;
  });
  $("#listSearch").submit(function() {
    $.get(this.action, $(this).serialize(), null, "script");
    return false;
  });
});