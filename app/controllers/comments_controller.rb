class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :destroy, :update,:show]
  # コメントを保存、投稿するためのアクションです。
  def create
    # topicをパラメータの値から探し出し,Topicに紐づくcommentsとしてbuildします。
    @comment = current_user.comments.build(comment_params)
    @topic = @comment.topic
    # クライアント要求に応じてフォーマットを変更
    respond_to do |format|
      if @comment.save
        format.html { redirect_to topic_path(@topic), notice: 'コメントを投稿しました。' }
      else
        format.html { render :new }
      end
    end
  end

  def edit
    #どのブログの情報かを取得。
    @topic = @comment.topic
  end
  def update
    #binding.pry
    if @comment.update(comment_params)
      redirect_to topic_path(@comment.topic), notice: "コメントを更新しました"
    else
      render 'edit'
    end
  end

  def show
    @topic = @comment.topic
    render 'index'
  end
  #_をつけたファイルは共通部品。呼び出す時はrenderを使う
  def destroy
    @comment.destroy
    flash.now[:message] = "コメントを削除しました！"
    #renderで非同期通信となる
    render 'index'
  end

  private
    def comment_params
      params.require(:comment).permit(:topic_id, :content)
    end
    def set_comment
      #ブログのどのコメントの情報かを取得する
      @comment=Comment.find(params[:id])
    end
end
