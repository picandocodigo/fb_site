# -*- coding: utf-8 -*-
require 'wordpress_plugins'

class PagesController < ApplicationController
include WordPressPlugins

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


end
