$(function () {
  $("#product_design").on("change", function () {
    let valueLength = $("#product_length").val();
    let valueWidth = $("#product_width").val();
    let valueBasisWeight = $("#product_material_id option:selected").attr("basis_weight");

    let calculationWeight = (parseFloat(valueLength) * parseFloat(valueWidth) * parseFloat(valueBasisWeight) / 100).toFixed(1);

    if (calculationWeight > 0) {
      $("#calculation-weight").val(calculationWeight);
    };
  });
});
