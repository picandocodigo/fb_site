class PagesController < ApplicationController
  def home
  end

  def contact
    @title = "Contacto"
  end

  def wordpress
    @title = 'Trabajo con WordPress'
  end

  def about
    @title = 'Acerca de este sitio'
  end

end
