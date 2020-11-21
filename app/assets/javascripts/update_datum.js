$(function () {
  // file_fieldを表示する関数
  var buildInput = (index, category) => {
    var html = `<input type="file"
                      name="${category}_datum[${category}_images_attributes][${index}][image]" style="display:none"
                      id="${category}_datum_${category}_images_attributes_${index}_image" class="hidden-field ${category}-file-field">`;
    return html;
  }

  // プレビュー画像を表示する関数
  let buildImage = (index, url, category) => {
    let html = `<div class = "${category}-image add-${category}-image" data-index = "${index}" id="item-image--${category}_${index}">
                    <img src = "${url}" width = "200px" height = "200px" class = "image-src">
                    </br>
                    <div class = "btn image-delete-btn image-delete-btn--${category}" id = "delete-btn--${category}_${index}" data-datum = "${category}">
                      削除
                    </div>
                  </div>`
    return html
  }

  // 3枚以上は挿入できない表示をする関数
  let buildMessage = (category) => {
    let html = `<div class = "image-count-message" id = "image-count-message--${category}">
                    これ以上挿入できません
                  </div>`
    return html
  }

  // file_fieldとチェックボックスを非表示にするcss
  $(`.hidden-field`).hide();
  $(`.hidden-destroy`).hide();

  // 各データ毎の画像にindexを割り振るための配列を用意
  let productionIndex = [0, 1, 2, 3]
  productionIndex.splice(0, productionIndex.splice(0, $(`.production-image:last`).data(`index`) + 1))

  let inspectionIndex = [0, 1, 2, 3]
  inspectionIndex.splice(0, inspectionIndex.splice(0, $(`.inspection-image:last`).data(`index`) + 1))

  let evaluationIndex = [0, 1, 2, 3]
  evaluationIndex.splice(0, evaluationIndex.splice(0, $(`.evaluation-image:last`).data(`index`) + 1))

  // 各データに対するindexを取得
  let fileIndexes = {
    production: productionIndex,
    inspection: inspectionIndex,
    evaluation: evaluationIndex
  }

  // 隠し要素の設定
  $(`.image-btn--edit`).hide();
  $(`.cancel-btn`).hide();
  $(`.submit-btn--edit`).hide();
  $(`.image-delete-btn`).hide();

  // readonlyの設定
  $(`.comment-area__main-area--edit`).attr(`readonly`, true);
  $(`.image-btn--edit`).attr(`readonly`, true);
  $(`.size-input--edit`).attr(`readonly`, true);

  //「内容の変更」ボタンを押した時の処理
  $(`.edit-btn`).on(`click`, function () {
    // データの種類を識別するためのカスタムデータ属性を取得
    let datumCategory = $(this).attr(`data-datum`);

    // 現在の値を取得
    let baseComment = $(`#comment-area__main-area--${datumCategory}`).val();
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
      if (datumCategory == `inspection`) {
        $(`#size-input--length`).val(baseLength);
        $(`#size-input--width`).val(baseWidth);
        $(`#size-input--weight`).val(baseWeight);
      }

      // 画像挿入に関する変更の中止
      // 追加しようとしていた画像を消去
      $(`.add-${datumCategory}-image`).remove();
      // file-fieldを消去して再生成する
      $(`.${datumCategory}-file-field`).remove();
      $(`#image-btn--${datumCategory}`).append(buildInput(fileIndexes[datumCategory][0], datumCategory));
      // 非表示にしていた保存済みの画像を再表示させ、クラス名を元に戻す
      $(`.hidden-${datumCategory}-image`).show().removeClass(`hidden-${datumCategory}-image`).addClass(`${datumCategory}-image`);
      // 削除用のチェックボックスを全て空にする
      $(`.hidden-destroy--${datumCategory}`).prop('checked', false);

    });
  });

  // 画像を挿入する処理
  $(`.image-btn`).on(`change`, `.hidden-field`, function (e) {
    // データの種類を識別するためのカスタムデータ属性を取得
    let datumCategory = $(this).parent().attr(`data-datum`);

    // ファイルのブラウザ上でのURLを取得する
    let file = e.target.files[0];
    let blobUrl = window.URL.createObjectURL(file);

    // 画像のプレビューを表示する
    $(`#image-area--${datumCategory}`).append(buildImage(fileIndexes[datumCategory][0], blobUrl, datumCategory));
    // fileIndexの先頭の数字を使って新しくinputを作る
    $(`#image-btn--${datumCategory}`).append(buildInput((fileIndexes[datumCategory][0] + 1), datumCategory));

    fileIndexes[datumCategory].shift();
    // 末尾の数に1足した数を追加する
    fileIndexes[datumCategory].push(fileIndexes[datumCategory][fileIndexes[datumCategory].length - 1] + 1);

    // 入力ボタンが対象としているフォームのidを切り替える
    $(`#image-btn--${datumCategory}`).attr(`for`, `${datumCategory}_datum_${datumCategory}_images_attributes_${fileIndexes[datumCategory][0]}_image`)

    // 画像が3枚になったら入力ボタンを非表示にする
    if ($(`.${datumCategory}-image`).length >= 3) {
      $(`#image-btn--${datumCategory}`).hide();
      $(`#image-btn--${datumCategory}`).before(buildMessage(datumCategory));
    };
  });

  // 画像を削除する処理
  $(document).on(`click`, `.image-delete-btn`, function () {
    // データの種類を識別するためのカスタムデータ属性を取得
    let datumCategory = $(this).attr(`data-datum`);

    // 選択した画像を取得する
    let target_image = $(this).parent();
    // 選択した画像のindexを取得する
    let target_index = $(target_image).data('index');

    // 選択した画像が登録済みの場合、対応するチェックボックスにチェックする
    let hiddenCheck = $(`input[data-index="${target_index}"].hidden-destroy--${datumCategory}`);
    if (hiddenCheck) {
      hiddenCheck.prop('checked', true)
    };

    // 選択した画像の表示を非表示にし、クラス名を変更する
    target_image.hide().removeClass(`${datumCategory}-image`).addClass(`hidden-${datumCategory}-image`);
    // 選択した画像と対応するfile_fieldを消去する
    $(`#${datumCategory}_datum_${datumCategory}_images_attributes_${target_index}_image`).remove();


    // 画像が3枚以下になったら入力ボタンを再表示する
    if ($(`.${datumCategory}-image`).length <= 2) {
      $(`#image-btn--${datumCategory}`).show();
      $(`#image-count-message--${datumCategory}`).remove();
    };

    // 画像が全て消されてもfile_fieldがゼロ個にならない様にする（画像表示が全て消されたら入力欄を復活させる）
    if ($(`.${datumCategory}-image`).length == 0) {
      $(`#image-btn--${datumCategory}`).append(buildInput(fileIndexes[datumCategory][0], datumCategory));
    }
  });
});
