require 'survey/questions'
class SiteController < ApplicationController
  def ceshi
  	@data = Questions.data
  	@survey = Survey.new
  end

  def fenxi
  	
  end
end
