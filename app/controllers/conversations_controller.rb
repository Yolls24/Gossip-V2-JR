# app/controllers/conversations_controller.rb
class ConversationsController < ApplicationController
    before_action :authenticate_user!
  
    def index
      @conversations = Conversation.where("sender_id = ? OR recipient_id = ?", current_user.id, current_user.id)
    end
  
    def show
      @conversation = Conversation.find(params[:id])
      @messages = @conversation.messages.order(created_at: :asc)
      @message = Message.new
    end
  
    def create
      recipient = User.find(params[:recipient_id])
      conversation = Conversation.between(current_user.id, recipient.id).first
  
      unless conversation
        conversation = Conversation.create(sender_id: current_user.id, recipient_id: recipient.id)
      end
  
      redirect_to conversation_path(conversation)
    end
  end
  