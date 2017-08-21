class MessagesController < ApplicationController
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end

  def new
      if params[:back]
    @message = Message.new(params[:conversation_id])
    else
      @message = Message.new
    end
  end

  def index
  @messages = @conversation.messages
  if @messages.length > 10
    @over_ten = true
    @messages = @messages[-10..-1]
  end

  if params[:m]
    @over_ten = false
    @messages = @conversation.messages
  end

  if @messages.last
    if @messages.last.user_id != current_user.id
     @messages.last.read = true
    end
  end

  @message = @conversation.messages.build
end

def create
  if @message.save
  redirect_to conversation_messages_path(@conversation), notice: "メッセージを作成しました！"
end


private
  def message_params
    params.require(:message).permit(:body, :user_id)
  end

end
