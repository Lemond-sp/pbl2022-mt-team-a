// 入力行数に合わせてtextareaの行数を伸ばすように変更する

// 最低行数
const min_len = 10
window.onload = function(){
  // ページ読み込み時に実行したい処理
  textarea_event();
}


//textarea
const src_textarea = document.querySelector('#js-src-textarea');
const tgt_textarea = document.querySelector('#js-tgt-textarea');

//textarea event
src_textarea.addEventListener('keyup', textarea_event);
tgt_textarea.addEventListener('keyup', textarea_event);

function textarea_event() {
  //valueから行数を取得
  let line_s = src_textarea.value.split('\n').length;
  let line_t = tgt_textarea.value.split('\n').length;

  if(line_s <= min_len){
    line_s = min_len;
  }

  if(line_t <= min_len){
    line_t = min_len;
  }

  //行数分のrowsに変更
  src_textarea.rows = line_s + 1;
  tgt_textarea.rows = line_t + 1;
}
