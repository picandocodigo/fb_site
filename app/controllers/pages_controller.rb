class PagesController < ApplicationController
  def home
  end

  def contact
    @title = "Contacto"
  end

  def wordpress
    @title = 'Trabajo con WordPress'
  end

  def github
    @title = 'Proyectos en GitHub'
  end

  def freesoftware
    @title = 'Software libre y Open Source'
  end

end
