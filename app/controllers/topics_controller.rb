class TopicsController < ApplicationController
 before_action :authenticate_user!

  before_action :set_topic, only: [:show, :edit, :update, :destroy]

  def confirm
    @topic = Topic.new(topicss_params)
    render :new if @topic.invalid?
  end

  def index
    @topics = Topic.all
  end

  def show
    @comment = @topic.comments.build
    @comments = @topic.comments
    Notification.find(params[:notification_id]).update(read: true) if params[:notification_id]
   end

  def new
    if params[:back]
      @topic = Topic.new(topics_params)
    else
      @topic = Topic.new
    end
  end

  def edit
    @topics = Topic.all
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])
    if @topic.update(topics_params)
      redirect_to topics_path, notice: "ブログを更新しました！"
    else
      render 'edit'
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy
    redirect_to topics_path, notice: "ブログを削除しました！"
   end

  def create
    @topic = Topic.new(topics_params)
    @topic.user_id = current_user.id
    if @topic.save
      redirect_to topics_path, notice: "ブログを作成しました！"
      NoticeMailer.sendmail_topic(@topic).deliver
    else
      render  'new'
    end
   end



  private
    def topics_params
      params.require(:topic).permit(:title, :content, :user_id, :name)
    end
end
    # idをキーとして値を取得するメソッド
    def set_topic
      @topic = Topic.find(params[:id])
    end
  private
    def topics_params
      params.require(:topic).permit(:title, :content)
    end
  end# idをキーとして値を取得するメソッド
    
end