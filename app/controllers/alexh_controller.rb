require 'rest_client'
require 'json'


class AlexhController < ApplicationController

  def facebook_fbchat_test1
    puts "Maxim -- AlexhController -- facebook_fbchat_test1"
    Invitations::FBChatSender::send_message_test_xmpp4r_facebook(allow_tls: true)
    render json: {}
  end

 def facebook_fbchat_test1_no_tls
    puts "Maxim -- AlexhController -- facebook_fbchat_test1_no_tls"
    Invitations::FBChatSender::send_message_test_xmpp4r_facebook(allow_tls: false)
    render json: {}
  end
  
  def facebook_fbchat_test1_new
    puts "Maxim -- AlexhController -- send_message_test_xmpp4r_facebook_new"
    Invitations::FBChatSender::send_message_test_xmpp4r_facebook_new
    render json: {}
  end
  
  def facebook_fbchat_test2
    puts "Maxim -- AlexhController -- facebook_fbchat_test2"
    Invitations::FBChatSender::send_message_test_FacebookChat
    render json: {}
  end

  
end
