require 'slack-ruby-bot'

class JiraBot < SlackRubyBot::Bot
  match(/((EVENT|ENG|BKS)-[0-9]*)/i) do |client, data, issues|
    results = []
    data.text.scan(/((EVENT|ENG|BKS)-[0-9]*)/i) do |i,j|
    	results << 'https://ticketfly.jira.com/browse/'+i
    end
    client.say(channel: data.channel, text: results.join("\n"))
  end
end

JiraBot.run