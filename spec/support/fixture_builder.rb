FixtureBuilder.configure do |fixture_builder|
  # rebuild fixtures automatically when these files change:
  fixture_builder.files_to_check += Dir["spec/factory.rb", "spec/factories/*.rb", "spec/support/fixture_builder.rb"]


  # now declare objects
  fixture_builder.factory do
    health_tag = Factory(:tag, :title => "health")
    exercise_tag = Factory(:tag, :title => "exercise")
    addiction_tag = Factory(:tag, :title => "addiction")

    quit_smoking = Factory(:goal, :title => "quit smoking")
    lose_weight = Factory(:goal, :title => "lose weight")
    run = Factory(:goal, :title => "go running")

    quit_smoking.tags << addiction_tag
    quit_smoking.tags << health_tag

    lose_weight.tags << addiction_tag
    lose_weight.tags << health_tag

    run.tags << exercise_tag
    run.tags << health_tag

    commenter = Factory(:user)

    Factory(:user_goal, :goal => quit_smoking, :created_at => 18.days.ago).tap do |user_goal|
      user_goal.updates.create(:status => 3, :comment => "Broke down and smoked about half a pack during a break today. Fucking boss was driving me insane.", :created_at => 15.days.ago)
      user_goal.updates.create(:status => 6, :comment => "Still feeling guilty about smoking yesterday, but haven't had a smoke since.", :created_at => 14.days.ago)
      user_goal.updates.create(:status => 8, :comment => "Ok, been a few days since having a smoke. Feeling pretty good.", :created_at => 10.days.ago)
      user_goal.updates.create(:status => 5, :comment => "Really having a hard time resisting right now. It's all I can think about.", :created_at => 4.days.ago)
      user_goal.updates.create(:status => 2, :comment => "Had a few drinks last night and just had to have a smoke. Ended up having 5 or so. Fuck this is hard.", :created_at => 1.day.ago).tap do |update|
        update.replies.create!(:commenter => commenter, :reply_type => "support", :comment => "You can do it!")
        update.replies.create!(:commenter => commenter, :reply_type => "reply", :comment => "Just drink more next time and skip the smokes.  Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
        update.replies.create!(:commenter => commenter, :reply_type => "congratulation", :comment => "No, drink less")
      end

      user_goal.updates.create(:status => 1, :comment => "I don't think I can do this. Had another smoke tonight feeling guilty about having smokes over the weekend... Trying to quit is stressing me out and of couse I want to smoke more when I'm stressed.", :created_at => 2.hours.ago)
    end

    Factory(:user_goal, :goal => quit_smoking, :created_at => 8.days.ago).tap do |user_goal|
      user_goal.updates.create(:status => 7, :comment => "It's been 3 days since my last smoke. Feeling pretty good", :created_at => 6.days.ago)
      user_goal.updates.create(:status => 9, :comment => "Made it through the weekend, and didn't have a single smoke despite getting pretty drunk", :created_at => 3.days.ago)
      user_goal.updates.create(:status => 5, :comment => "Ok, seems to be even harder when you're hungover. I'm seriously craving a smoke.", :created_at => 54.hours.ago)
      user_goal.updates.create(:status => 3, :comment => "Ok, had one smoke. I don't feel good about it, but it was killing me.", :created_at => 2.days.ago)
      user_goal.updates.create(:status => 10, :comment => "Had a smoke a few days ago, but now feeling reenergized to make this happen. Nothing's gonna stop me now!", :created_at => 3.hours.ago).tap do |update|
        update.replies.create!(:commenter => commenter, :reply_type => "support", :comment => "You can do it!")
        update.replies.create!(:commenter => commenter, :reply_type => "congratulation", :comment => "Just drink more next time and skip the smokes")
        update.replies.create!(:commenter => commenter, :reply_type => "reply", :comment => "No, drink less")
      end
    end


    Factory(:user_goal, :goal => lose_weight, :created_at => 9.days.ago).tap do |user_goal|
      user_goal.updates.create(:status => 8, :comment => "Feeling good about this. Going to do my best to avoid the junk food attack during the holidays", :created_at => 9.days.ago)
      user_goal.updates.create(:status => 5, :comment => "Ha, one christmas party and I already feel like I'm slipping.", :created_at => 7.days.ago)
      user_goal.updates.create(:status => 6, :comment => "Ok, slipped up a little at the Christmas party, but feel like I'm back on track now.", :created_at => 6.days.ago)
      user_goal.updates.create(:status => 7, :comment => "Finding that having a glass or two of wine at night along with a lighter dinner is really helping.", :created_at => 1.hour.ago).tap do |update|
        update.replies.create!(:commenter => commenter, :reply_type => "support", :comment => "You can do it!")
        update.replies.create!(:commenter => commenter, :reply_type => "reply", :comment => "Just drink more next time and skip the smokes.  Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
        update.replies.create!(:commenter => commenter, :reply_type => "congratulation", :comment => "No, drink less")
      end
    end

    Factory(:user_goal, :goal => run, :created_at => 6.days.ago).tap do |user_goal|
      user_goal.updates.create(:status => 7, :comment => "The winter months have been tough on me, so I'm committing myself to running more often starting now.", :created_at => 5.days.ago)
      user_goal.updates.create(:status => 8, :comment => "Was dark, cold and raining when I woke up this morning, but went running anyways. Feeling good.", :created_at => 4.days.ago)
      user_goal.updates.create(:status => 5, :comment => "Was out late last night, so didn't get up in time for a run today, but hoping to get one in tomorrow.", :created_at => 1.days.ago)
      user_goal.updates.create(:status => 8, :comment => "Crap, really raining this morning. Should have gone for a run yesterday...", :created_at => 30.minutes.ago).tap do |update|
        update.replies.create!(:commenter => commenter, :reply_type => "support", :comment => "You can do it!")
        update.replies.create!(:commenter => commenter, :reply_type => "congratulation", :comment => "Just drink more next time and skip the smokes")
        update.replies.create!(:commenter => commenter, :reply_type => "reply", :comment => "No, drink less")
      end
    end

  end
end

Factory.sequences.each do |name, seq|
  seq.instance_variable_set(:@value, 1000)
end

