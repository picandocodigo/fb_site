# -*- coding: utf-8 -*-
require 'wordpress_plugins'
require 'twitter_api'

class PagesController < ApplicationController

  def home
  end

  def contact
    @title = "Contacto"
  end

  def wordpress
    @title = 'Trabajo con WordPress'
    @plugins = WordPressPlugins.get_plugins 'fernandobt'
  end

  def about
    @title = 'Acerca de este sitio'
  end

  def twitter
    #TODO - make this parametrizable
    @title = 'Perfil de Twitter'
    @twitter_user = TwitterApi.get_user 'picandocodigo'
    @tweets = TwitterApi.get_user_tweets 'picandocodigo'
    @tweets.delete_if {|tweet| !tweet['in_reply_to_status_id'].nil? } 
  end

end
