class MessageController < ApplicationController
    before_action :require_login

  # Get unique users that current user has sent/received messages to/from
  def index
    sent_to_users = Message.where(from_id: session[:user]["id"]).includes(:to).map(&:to)
    received_from_users = Message.where(to_id: session[:user]["id"]).includes(:from).map(&:from)
    @users = (sent_to_users + received_from_users).uniq
  end

  # Query and get all messages between current and other user
  def show_messages
    @user2 = User.find(params[:user_id])
    @messages = Message.where(
      "(from_id = ? AND to_id = ?) OR (from_id = ? AND to_id = ?)",
      session[:user]["id"], @user2.id,
      @user2.id, session[:user]["id"]
    ).order(created_at: :asc)
    @new_message = Message.new
  end

  def create
    @message = Message.new(message_params)
    @message.from_id = session[:user]["id"]
    @message.to_id = params[:user_id]

    if @message.save
      redirect_to conversation_path(params[:user_id]), notice: "Message sent!"
    else
      redirect_to conversation_path(params[:user_id]), alert: "Failed to send message."
    end
  end

  def require_login
    unless session[:user]
      redirect_to login_path
    end
  end

  private

  # require content for message
  def message_params
    params.require(:message).permit(:content)
  end
end
