 require_relative 'spec_helper'
 require 'pry'
 require 'vcr'

describe TwitterApi do
  let(:client) {TwitterApi.new}

  describe "#most_recent_friend" do
    it "returns the most recent friend" do
      VCR.use_cassette('twitter/most_recent_friend') do
        user = client.most_recent_friend
        expect(user.class).to eq(Twitter::User)
        expect(user.name).to eq("Forrest Chang")
      end
    end
  end

  describe "#find_user_for" do
    it "given a username, it returns the Twitter user object" do
      VCR.use_cassette('twitter/find_user_for') do
        user = client.find_user_for("sm_debenedetto")
        expect(user.class).to eq(Twitter::User)
        expect(user.username).to eq("sm_debenedetto")
      end
    end
  end

  describe "#find_followers_for" do
    it "given a username, it returns an array of the first 10 followers, with each follower's data represented in a hash" do
      VCR.use_cassette('twitter/find_followers_for') do
        user = client.find_followers_for("sm_debenedetto")
        expect(user).to be_a(Array)
        expect(user.count).to eq(10)
        expect(user.first.class).to eq(Hash)
        expect(user.first[:name]).to eq("Adeline Gross")
      end
    end
  end

  describe "#homepage_timeline" do
    it "returns an array of tweet objects from the client user's homepage" do
      VCR.use_cassette('twitter/homepage_timeline') do
        tweet = client.homepage_timeline
        expect(tweet).to be_a(Array)
        expect(tweet.first.class).to eq(Twitter::Tweet)
        expect(tweet.first.id).to eq(629359789647265792)
      end
    end
  end
end
