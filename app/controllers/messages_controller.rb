class MessagesController < ApplicationController
	protect_from_forgery except: [:send_message]

	def show_conversations
    @user = User.find(params[:user_id])

    @conversations = @user.mailbox.conversations.includes(:receipts => [:receiver])

		# @conversations = @conversations.reject do |conversation|
		# 	user = conversation.participants.select{ |p| !p.id.eql?(current_user.id)}
		# 	user.empty? || user.nil?
		# end

    if current_user == @user
      if @conversations.present?
      	#Last conversation (chronologically, the first in the inbox)
      	@conversation = @conversations.first
      	@messages = @conversation.messages.includes(:sender).order('created_at DESC')
      	@messages.each do |message|
          message.mark_as_read(@user) if message.is_unread?(@user)
        end
      end

      respond_to do |format|
        format.html { redirect_to user_conversations_path(@user), status: :moved_permanently if request.path != user_conversations_path(@user) }
        format.js
      end

    else
      redirect_to user_path(@user)
    end
  end

  def reply
		@user = UserDecorator.decorate User.find(params[:user_id])

		@conversation = Conversation.find(params[:conversation_id])
		@conversation.touch

		@message_text = params[:message][:body]
		@message_time = Time.now

		@conversations = @user.mailbox.conversations.includes(:receipts => [:receiver])

		@conversations = @conversations.reject do |conversation|
			user = conversation.participants.select{ |p| !p.id.eql?(current_user.id)}
			user.empty?
		end

		@conversations = @conversations.paginate(:page => params[:conversations_page], :per_page => 5)

		@user.reply_to_conversation(@conversation, @message_text)

		MessagingMailWorker.perform_async(@user.id, @conversation.id, @message_text)

		@message = @conversation.messages.last

		participant = @conversation.participants.select{ |p| !p.id.eql?(@user.id)}

		recipient_id = participant[0].id

		PushToIosWorker.perform_async(@conversation.id, recipient_id, @user.name, @message_text, current_user.id)

  	respond_to do |format|
  		format.html
  		format.js
  	end
  end

  def show_messages
    @user = User.find(params[:user_id])
  	@conversation = Mailboxer::Conversation.find(params[:conversation_id])
  	@messages = @conversation.messages.order('created_at DESC')
    @messages.each do |message|
        message.mark_as_read(@user) if message.is_unread?(@user)
      end
  	@unread_messages = @user.mailbox.inbox(read: false).size

  	respond_to do |format|
    	format.html {render 'show_conversations'}
    	format.js {render 'show_conversations' if params[:messages_page].present? || params[:conversations_page].present?}
    end
  end


  def count_unread_messages
    @user = User.find(params[:user_id])
    @unread_messages = @user.mailbox.inbox(read: false).size
    return @unread_messages
    respond_to do |format|
        format.js
    end
  end

  def mark_as_read
    @user = User.find(params[:user_id])
    @message = Message.find(params[:message_id])
    @message.mark_as_read(@user)
    respond_to do |format|
        format.html { render nothing: true }
    end
  end

  def message_form
    @user = current_user
    @recipient = User.find(params[:recipient_id])

		@conversation = Conversation.participant(@user).where('conversations.id in (?)', Conversation.participant(@recipient).collect(&:id)).first

    respond_to do |format|
      format.js
    end
  end

  def send_message
    @user = current_user
    @subject = params[:subject].blank? ? "Chat message" : params[:subject]
    @recipient = User.find(params[:recipient_id])
		@message_text = params[:body].gsub(/(?:\n\r?|\r\n?)/, '<br>')
		@attachment = params[:attachment]

		@conversation = Mailboxer::Conversation.participant(@user).where('mailboxer_conversations.id in (?)', Mailboxer::Conversation.participant(@recipient).collect(&:id)).first

		if @conversation.present?
			@user.reply_to_conversation(@conversation, @message_text, subject=nil, should_untrash=true, sanitize_text=true, @attachment)
		else
			@user.send_message(@recipient, @message_text, @subject, sanitize_text=true, @attachment)
		end

    redirect_to :back
  end

  def incoming_conversation
    @user = User.find(params[:user_id])
    @render_section = to_boolean(params[:render_section])
    if @render_section
      @conversations = @user.mailbox.conversations.includes(:receipts => [:receiver])

			@conversations = @conversations.reject do |conversation|
				user = conversation.participants.select{ |p| !p.id.eql?(current_user.id)}
				user.empty?
			end

      if @conversations.present?
       #Last conversation (chronologically, the first in the inbox)
       @conversation = @conversations.first
       @messages = @conversation.messages
        @messages.each do |message|
          message.mark_as_read(@user) if message.is_unread?(@user)
        end
      end
    else
      @conversation = Conversation.includes(:receipts => [:receiver]).find(params[:conversation_id])
      @messages = @conversation.messages
    end
    respond_to do |format|
        format.js
    end
  end

  def to_boolean(str)
      str == 'true'
  end

end
