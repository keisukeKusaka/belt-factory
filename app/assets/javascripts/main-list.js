$(function () {
  $("tbody tr[data_link]").addClass(".clickable").click(function () {
    window.location = $(this).attr("data_link");
  }).find("a").hover(function () {
    $(this).parents('tr').unbind('click');
  });
});
