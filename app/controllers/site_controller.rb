require 'survey/questions'
class SiteController < ApplicationController
  def ceshi
  	@agent = request.env['HTTP_USER_AGENT']
  	@data = Questions.data
  	@survey = Survey.new
  end

  def fenxi
  	
  end
end
