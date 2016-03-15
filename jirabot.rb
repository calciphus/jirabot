require 'slack-ruby-bot'
require "net/https"
require "uri"

class JiraBot < SlackRubyBot::Bot
  match(/([a-z]+-[0-9]+)/i) do |client, data, issues|
    results = []
    tomatch = data.text
    
    # Remove links from text, since they're already links, by grabbing everything between < and >
    tomatch = tomatch.sub /(<.+>)/i, ''

    # Also remove emoji, because skin-tone-2 and similar were showing up
    tomatch = tomatch.sub /:\b\S*\b:/, ''
    
    # Now grab everything that looks like a JIRA ticket, dump it into an array, grab uniques.
    
    tomatch.scan(/([a-z]+-[0-9]+)/i) do |i,j|
    	results << i.upcase
    end
    results.uniq.each do |ticket|
        url = ENV["JIRA_PREFIX"]+"rest/api/latest/issue/"+ticket
        direct = ENV["JIRA_PREFIX"]+"browse/"+ticket
        uri = URI.parse(url)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        request = Net::HTTP::Get.new(uri.request_uri)
        request.basic_auth(ENV["JIRA_USER"],ENV["JIRA_PASS"])
        response = http.request(request)
        body = JSON.parse(response.body)
        if response.code != "404"
            if response.code == "200"
                message = "#{ticket}: #{body['fields']['summary']}\n#{direct}\n#{body['fields']['status']['name']} (#{body['fields']['issuetype']['name']})"
            else
                message = direct
            end
            client.say(channel: data.channel, text: message)
        end
    end


  end
end

JiraBot.run