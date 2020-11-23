$(function () {
  $("tbody tr[data_link]").addClass(".clickable").click(function () {
    window.location = $(this).attr("data_link");
  }).find("a").hover(function () {
    $(this).parents('tr').unbind('click');
  });

  var lines = $("tbody tr");
  function getActive() {
    $(this).addClass("active");
  };
  function removeActive() {
    $(".active").removeClass("active");
  };
  lines.mouseenter(getActive);
  lines.mouseleave(removeActive);
});
