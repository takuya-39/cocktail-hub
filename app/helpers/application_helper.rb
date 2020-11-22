module ApplicationHelper
  # デバイスのエラーメッセージ出力メソッド
  def devise_error_messages
    return '' if resource.errors.empty?

    html = ''
    # エラーメッセージ用のHTMLを生成
    resource.errors.full_messages.each do |msg|
      html += <<-RUBY
        <div class="error_field alert alert-danger" role="alert">
          <p class="error_msg">#{ msg }</p>
        </div>
      RUBY
    end
    html.html_safe
  end
end
