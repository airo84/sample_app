require 'rest_client'
require 'json'
#require 'cloudinary'

class AlexhController < ApplicationController

  def facebook_fbchat_test1
    puts "Maxim -- AlexhController -- facebook_fbchat_test1"
    Invitations::FBChatSender::send_message_test_xmpp4r_facebook
    render json: {}
  end

  def facebook_fbchat_test2
    puts "Maxim -- AlexhController -- facebook_fbchat_test2"
    Invitations::FBChatSender::send_message_test_FacebookChat
    render json: {}
  end

  
end
