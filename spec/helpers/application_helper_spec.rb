require 'spec_helper'

describe ApplicationHelper do

  describe "remove_emails" do
    it "should remove any emails from text" do
      text = "hey person@example.com, this is an email: soandso@example.com and another email test123@test123.ca."
      remove_emails(text).should == "hey [private], this is an email: [private] and another email [private]."
    end
  end
end
