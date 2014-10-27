class Invitations::FBChatSender

  #send a message using xmpp4r_facebook
  def self.send_message(sender_id, sender_access_token, recipient_id, subject, body)
    app_id = ENV.fetch('FB_APP_ID')
    app_secret = ENV.fetch('FB_SECRET_KEY')
    puts "Maxim -- FBChatSender -- send_message -- app_id is #{app_id}"
    puts "Maxim -- FBChatSender -- send_message -- app_secret is #{app_secret}"
	
    puts "Maxim -- FBChatSender -- send_message -- sender_id is #{sender_id}"
    puts "Maxim -- FBChatSender -- send_message -- sender_access_token is #{sender_access_token}"
    puts "Maxim -- FBChatSender -- send_message -- recipient_id is #{recipient_id}"
	subject = "AwesomeBox Staging"
    #puts "Maxim -- FBChatSender -- send_message -- subject is #{subject}"
	body = "Test message via xmpp4r_facebook"
    #puts "Maxim -- FBChatSender -- send_message -- body is #{body}"
	

    #Thread::abort_on_exception = false
	jabber_message = Jabber::Message.new(chat_address(recipient_id), body)
    jabber_message.subject = subject
	
    #puts "Maxim -- FBChatSender -- send_message -- jabber_message.subject is #{jabber_message.subject}"
	Jabber::debug = true
    client = Jabber::Client.new(Jabber::JID.new(chat_address(sender_id)))

	#client.allow_tls = false
	puts "Maxim -- FBChatSender -- send_message -- client.allow_tls is #{client.allow_tls}"
	
	#client.on_exception do |ex, stream, phase|
	#    puts "Jabber::Client Exception occurred -- #{ex.inspect} ON phase #{phase}"
    #    Rails.logger.error "Jabber::Client Exception occurred --#{ex.inspect} ON phase #{phase}"
    #    raise ex
    #end
	puts "Maxim -- FBChatSender -- send_message -- trying to connect..."
    client.connect
    puts "Maxim -- FBChatSender -- send_message -- connected!"
	
	begin
      client.auth_sasl(Jabber::SASL::XFacebookPlatform.new(client, app_id, sender_access_token, app_secret), nil)
      client.send(jabber_message)
      client.close
    rescue => e
      puts "Maxim -- FBChatSender -- send_message -- FAILED!"
      Rails.logger.error "Failed to send Facebook message via xmpp4r_facebook: #{e.message}"
      return false
    else
	  puts "Maxim -- FBChatSender -- send_message -- SENT!"
      return true
    end
  end
  
  #send a message using FacebookChat
  def self.send_message_2(sender_access_token, recipient_id, subject, body)
    app_secret = ENV.fetch('FB_SECRET_KEY')
  
    puts "Maxim -- FBChatSender -- send_chat_message2 -- configuring a Client..."
    Jabber::debug = true
	Thread::abort_on_exception = false
	
    FacebookChat::Client.configure do |config|
    config.api_key = app_secret # facebook application's api key
    end
	
	#staging FB access token
	sender_access_token = 'CAAGkN1BKSV0BAMJiwgcTf9KoPb8MARIg18BMGypq0Ab8tLHJxRPxH8xP8PHHtsERO2fVUOWc64DOR9fjbXgb6eXXH75AyysT5PW7i66KSAZCOyWzsmqYwxKVYYGHU4f1wZCQHNwZAQ1ZBkosQHQV70Koy6aiCqtk44ZCPnZBZA4IJugWYyxO6yYESclON9Hd9AvBrDSg2E3vb7tIH9bAajh'
	#maxim fb id
	#recipient_id = '100008335089304'
	recipient_id = '100007252308090'
	
	body = "Test message via FacebookChat"
	puts "Maxim -- FBChatSender -- send_chat_message2 -- getting client..."
    client = FacebookChat::Client.new(sender_access_token)
	   
	begin
	  puts "Maxim -- FBChatSender -- send_chat_message2 -- sending message..."
      client.send(recipient_id, body)
      puts "Maxim -- FBChatSender -- send_chat_message2 -- message sent..."
      rescue => e
      puts "Maxim -- FBChatSender -- send_chat_message2 -- FAILED!"
      Rails.logger.error "Failed to send Facebook message via facebook_chat: #{e.message}"
      return false
      else
      puts "Maxim -- FBChatSender -- send_chat_message2 -- SENT!"
      return true
    end
  end
  
  
  def self.send_message_test_xmpp4r_facebook_new()
	message = Jabber::Message.new '-100007252308090@chat.facebook.com', "test -- hello old friend! (sent from xmpp4r_facebook/Maxim)!"
	message.subject = 'message from ruby!'
	puts "Testing xmpp4r_facebook"

	client = Jabber::Client.new Jabber::JID.new('-100008335089304@chat.facebook.com')
	#sleep 2
	client.connect
	#sleep 2
	puts "Testing xmpp4r_facebook -- client.connected"
	sender_access_token = 'CAAGkN1BKSV0BAMJiwgcTf9KoPb8MARIg18BMGypq0Ab8tLHJxRPxH8xP8PHHtsERO2fVUOWc64DOR9fjbXgb6eXXH75AyysT5PW7i66KSAZCOyWzsmqYwxKVYYGHU4f1wZCQHNwZAQ1ZBkosQHQV70Koy6aiCqtk44ZCPnZBZA4IJugWYyxO6yYESclON9Hd9AvBrDSg2E3vb7tIH9bAajh'

	client.auth_sasl(Jabber::SASL::XFacebookPlatform.new(client, '462032453912925', sender_access_token, 'c47c19ae03443f9e9f8fea3e8a06a1f7'), nil)
	puts "Testing xmpp4r_facebook -- auth_sasl complete"

	client.send message
	puts "Testing xmpp4r_facebook -- message sent"
	sleep 1
	client.close
  end
  
  def self.send_message_test_xmpp4r_facebook()
	app_id = '462032453912925'
    sender_id = '100008335089304'
  	recipient_id = '100007252308090'
	sender_access_token = 'CAAGkN1BKSV0BAMJiwgcTf9KoPb8MARIg18BMGypq0Ab8tLHJxRPxH8xP8PHHtsERO2fVUOWc64DOR9fjbXgb6eXXH75AyysT5PW7i66KSAZCOyWzsmqYwxKVYYGHU4f1wZCQHNwZAQ1ZBkosQHQV70Koy6aiCqtk44ZCPnZBZA4IJugWYyxO6yYESclON9Hd9AvBrDSg2E3vb7tIH9bAajh'
  #app_secret = ENV.fetch('FB_SECRET_KEY')
  app_secret = 'c47c19ae03443f9e9f8fea3e8a06a1f7'
	body = "Test message via xmpp4r_facebook"
	
	jabber_message = Jabber::Message.new(chat_address(recipient_id), body)
    jabber_message.subject = "xmpp4r_facebook test -- Alex H."
	
   	Jabber::debug = true
    client = Jabber::Client.new(Jabber::JID.new(chat_address(sender_id)))

	#client.on_exception do |ex, stream, phase|
	#    puts "Jabber::Client Exception occurred -- #{ex.inspect} ON phase #{phase}"
    #    Rails.logger.error "Jabber::Client Exception occurred --#{ex.inspect} ON phase #{phase}"
    #    raise ex
    #end
    client.connect
	
	begin
      client.auth_sasl(Jabber::SASL::XFacebookPlatform.new(client, app_id, sender_access_token, app_secret), nil)
      client.send(jabber_message)
      client.close
    rescue => e
      puts "Maxim -- FBChatSender -- send_message_test_1 -- FAILED!"
      Rails.logger.error "Failed to send Facebook message via xmpp4r_facebook: #{e.message}"
      return false
    else
	  puts "Maxim -- FBChatSender -- send_message_test_1 -- SENT!"
      return true
    end
	
  end
  
  def self.send_message_test_FacebookChat()
    Jabber::debug = true
	Thread::abort_on_exception = false
	
    FacebookChat::Client.configure do |config|
      #config.api_key = ENV.fetch('FB_SECRET_KEY') # facebook application's api key
	  config.api_key = 'c47c19ae03443f9e9f8fea3e8a06a1f7'
    end
	
	#staging FB access token
	sender_access_token = 'CAAGkN1BKSV0BAMJiwgcTf9KoPb8MARIg18BMGypq0Ab8tLHJxRPxH8xP8PHHtsERO2fVUOWc64DOR9fjbXgb6eXXH75AyysT5PW7i66KSAZCOyWzsmqYwxKVYYGHU4f1wZCQHNwZAQ1ZBkosQHQV70Koy6aiCqtk44ZCPnZBZA4IJugWYyxO6yYESclON9Hd9AvBrDSg2E3vb7tIH9bAajh'
	#maxim fb id
	#recipient_id = '100008335089304'
	#mario fb id 
	recipient_id = '100007252308090'
	
	body = "send_message_test_2 -- Test message via FacebookChat -- Alex H."
	client = FacebookChat::Client.new(sender_access_token)
	   
	begin
      client.send(recipient_id, body)
      rescue => e
      puts "Maxim -- FBChatSender -- send_message_test_2 -- FAILED!"
      Rails.logger.error "Failed to send Facebook message via facebook_chat: #{e.message}"
      return false
      else
      puts "Maxim -- FBChatSender -- send_message_test_2 -- SENT!"
      return true
    end
	
  end

  private
  def self.chat_address(facebook_id)
    "-#{facebook_id}@chat.facebook.com"
  end
 
  
end
