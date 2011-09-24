$(function() {
  $("#table_main th a, #searchPartialView .pagination a").live("click", function() {
    $.getScript(this.href);
    return false;
  });
  $("#listSearch input").keyup(function() {
    $.get($("#listSearch").attr("action"), $("#listSearch").serialize(), null, "script");
    return false;
  });
  $("#listSearch select").change(function() {
    $.get($("#listSearch").attr("action"), $("#listSearch").serialize(), null, "script");
    return false;
  });
  $("#listSearch").submit(function() {
    $.get(this.action, $(this).serialize(), null, "script");
    return false;
  });
});