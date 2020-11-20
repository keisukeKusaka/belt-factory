$(function () {
  let tabs = $(".menu__tab");
  function tabSwitch() {
    $(".active-tab").removeClass("active-tab");
    $(this).addClass("active-tab");

    const index = tabs.index(this);
    $(".content").removeClass("show").eq(index).addClass("show");
  };
  tabs.click(tabSwitch);
});
