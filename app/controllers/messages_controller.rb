class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :upsate, :destroy]
  
  def index
      # @messages = Message.all.page(params[:page]).per(10)
      @messages = Message.order(id: :desc).page(params[:page]).per(10)
  end

  def show
      set_message
  end

  def new
      @message = Message.new
    #   Message.new(content: 'sample')
    # デフォルトで入力された状態で表示
  end

  def create
    @message = Message.new(message_params)

    if @message.save
      flash[:success] = 'Message が正常に投稿されました'
      redirect_to @message
    else
      flash.now[:danger] = 'Message が投稿されませんでした'
      render :new
    end
  end

  def edit
    set_message
      
  end

  def update
    set_message
    if @message.update(message_params)
      flash[:success] = 'Message は正常に更新されました'
      redirect_to @message
    else
      flash.now[:danger] = 'Message は更新されませんでした'
      render :edit
    end
  end

  def destroy
    set_message
    @message.destroy

    flash[:success] = 'Message は正常に削除されました'
    redirect_to messages_url
  end

  private

  # Strong Parameter
  def set_message
    @message = Message.find(params[:id])
  end
  
  def message_params
    params.require(:message).permit(:content, :title)
  end
  
end