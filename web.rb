require 'sinatra/base'

module JiraBot
  class Web < Sinatra::Base
    get '/' do
      'JiraBot has issues. In a good way.'
    end
  end
end