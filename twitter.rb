require 'twitter'
require 'yaml'
require 'pry'

class TwitterApi
  attr_reader :client

  def initialize
    keys = YAML.load_file('application.yml')
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = keys['CONSUMER_KEY']
      config.consumer_secret     = keys['CONSUMER_SECRET']
      config.access_token        = keys['ACCESS_TOKEN']
      config.access_token_secret = keys['ACCESS_TOKEN_SECRET']
    end
  end


  def most_recent_friend
    self.client.friends.first.name
  end

  def find_user_for(username)
    self.client.user(username).name
  end

  def find_followers_for(username)
    self.client.followers(username).attrs[:users][0..9].map do |user|
      user[:name]
    end
  end

  def homepage_timeline
    self.client.home_timeline.map do |tweet|
      tweet.text
    end
  end

end

# Bonus:
#
# uncomment out the following and read the bonus instructions.
# remember to comment out the WebMock line of your spec_helper, as the instructions dictate.

tweet_client = TwitterApi.new
puts tweet_client.most_recent_friend
puts tweet_client.find_user_for("julesdotnyc")
puts tweet_client.find_followers_for("julesdotnyc")
puts tweet_client.homepage_timeline
