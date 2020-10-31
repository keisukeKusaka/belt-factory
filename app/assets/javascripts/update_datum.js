$(function () {
  // 隠し要素の設定
  $(`.image-btn--edit`).hide();
  $(`.cancel-btn`).hide();
  $(`.submit-btn--edit`).hide();
  $(`.image-delete-btn`).hide();

  // readonlyの設定
  $(`.comment-area__main-area--edit`).attr(`readonly`, true);
  $(`.image-btn--edit`).attr(`readonly`, true);
  $(`.size-input--edit`).attr(`readonly`, true);

  // 3枚以上は画像挿入できない表示をする関数
  let buildMessage = (category) => {
    let html = `<div class = "image-count-message" id = "image-count-message--${category}">
                  これ以上挿入できません
                </div>`
    return html
  }

  //「内容の変更」ボタンを押した時の処理
  $(`.edit-btn`).on(`click`, function () {
    // データの種類を識別するためのカスタムデータ属性を取得
    let datumCategory = $(this).attr(`data-datum`);

    // 現在の値を取得
    let baseComment = $(`#comment-area__main-area--${datumCategory}`).val();
    let baseImage = $(`#image-btn--${datumCategory}`).val();
    let baseLength = $(`#size-input--length`).val();
    let baseWidth = $(`#size-input--width`).val();
    let baseWeight = $(`#size-input--weight`).val();

    // 隠し要素の表示
    if ($(`.${datumCategory}-image`).length < 3) {
      $(`#image-btn--${datumCategory}`).show();
    } else {
      $(`#image-btn--${datumCategory}`).before(buildMessage(datumCategory));
    };
    $(`#cancel-btn--${datumCategory}`).show();
    $(`#submit-btn--${datumCategory}`).show();
    $(`.image-delete-btn--${datumCategory}`).show();

    // readonlyの解除
    $(`#comment-area__main-area--${datumCategory}`).attr(`readonly`, false);
    $(`#image-btn--${datumCategory}`).attr(`readonly`, false);
    if (datumCategory == `inspection`) {
      $(`.size-input--edit`).attr(`readonly`, false);
    }

    // 「変更の中止」ボタンを押した時の処理
    $(`#cancel-btn--${datumCategory}`).on(`click`, function () {
      // 要素を再び隠す
      $(`#image-btn--${datumCategory}`).hide();
      $(`#image-count-message--${datumCategory}`).remove();
      $(`#cancel-btn--${datumCategory}`).hide();
      $(`#submit-btn--${datumCategory}`).hide();
      $(`.image-delete-btn--${datumCategory}`).hide();

      // readonlyの再設定
      $(`#comment-area__main-area--${datumCategory}`).attr(`readonly`, true);
      $(`#image-btn--${datumCategory}`).attr(`readonly`, true);
      if (datumCategory == `inspection`) {
        $(`.size-input--edit`).attr(`readonly`, true);
      }

      // 元の値を再表示
      $(`#comment-area__main-area--${datumCategory}`).val(baseComment);
      $(`#image-btn--${datumCategory}`).val(baseImage);
      if (datumCategory == `inspection`) {
        $(`#size-input--length`).val(baseLength);
        $(`#size-input--width`).val(baseWidth);
        $(`#size-input--weight`).val(baseWeight);
      }
    });
  });
});
