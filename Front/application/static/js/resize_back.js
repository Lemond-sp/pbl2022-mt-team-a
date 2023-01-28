$(function () {
  // 画面読み込み時にテキストエリアの高さを更新
  autoResizeHeightForTextArea($('.js-target-textarea'), 1, 5);
  // 文字入力時にテキストエリアの高さを更新
  $(document).on('input', '.js-target-textarea', function () {
    autoResizeHeightForTextArea($(this), 1, 5);
  });
});

/**
  * 入力内容の行数によってテキストエリアの高さを変更する
  *
  * @param {jQuery Object} $textArea textareaタグの要素
  */
function autoResizeHeightForTextArea($textArea, minRow, maxRow) {
  // 一行の高さ
  const lineHeight = parseInt($textArea.css('line-height').replace('px', ''));
  const paddingTop = parseInt($textArea.css('padding-top').replace('px', ''));
  const paddingBottom = parseInt($textArea.css('padding-bottom').replace('px', ''));
  // 高さの下限
  const minHeight = minRow * lineHeight;
  // 高さの上限
  const maxHeight = maxRow * lineHeight;
  // scrollHeight を高さを更新するため height に小さな数値を指定
  $textArea.height(10);
  // 反映する高さ
  let reflectHeight = $textArea[0].scrollHeight - paddingTop - paddingBottom;
  // 高さの下限を下回らないように調整
  reflectHeight = reflectHeight < minHeight ? minHeight : reflectHeight;
  // 高さの上限を超えないように調整
  reflectHeight = reflectHeight < maxHeight ? reflectHeight : maxHeight;
  // 高さを更新
  $textArea.height(reflectHeight);
}
