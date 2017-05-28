class MessagesController < ApplicationController

  # どの会話なのか
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end

  def index
    @messages = @conversation.messages  #会話に紐付くメッセージを取得

    # もしメッセージ数が10より大きければ、10より大きいというフラグを有効にし、
    # メッセージを最新の10こに絞る
    if @messages.length > 10          # もしメッセージ数が10より大きければ
      @over_ten = true                # 10より大きいフラグを有効にする
      @messages = @messages[-10..-1]  # 負の値を入れることで、最後から何番目を指定することができる
    end

    if params[:m]                         # もし10より小さければ
      @over_ten = false                   # 10より大きいフラグをたてない
      @messages = @conversation.messages  # 会話に紐付くメッセージをすべて取得
    end

    if @messages.last                               # もしメッセージが最新で
      if @messages.last.user_id != current_user.id  # かつユーザIDが自分のでなければ
        @messages.last.read = true                  # その最新のメッセージを既読にする
      end
    end

    # 新規投稿のメッセージ用の変数を作成
    @message = @conversation.messages.build

  end

  def create
    # HTTPリクエスト上のパラメータを利用して会話に紐付くメッセージを生成
    @message = @conversation.messages.build(message_params)

    if @message.save  # 保存ができれば、
      redirect_to conversation_messages_path(@conversation)  # 会話に紐付くメッセージ一覧の画面に遷移
    end
  end

  private
    def message_params
      params.require(:message).permit(:body, :user_id)
    end
end
