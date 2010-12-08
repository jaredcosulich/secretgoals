FixtureBuilder.configure do |fixture_builder|
  # rebuild fixtures automatically when these files change:
  fixture_builder.files_to_check += Dir["spec/factory.rb", "spec/factories/*.rb", "spec/support/fixture_builder.rb"]

  
  # now declare objects
  fixture_builder.factory do
    smoker = Factory(:user)
    quit_smoking = Factory(:goal, :user => smoker, :title => "quit smoking before I graduate")
    quit_smoking.updates.create(:status => 3, :comment => "Broke down and smoked about half a pack during a break today. Fucking boss was driving me insane.", :created_at => 15.days.ago)
    quit_smoking.updates.create(:status => 6, :comment => "Still feeling guilty about smoking yesterday, but haven't had a smoke since.", :created_at => 14.days.ago)
    quit_smoking.updates.create(:status => 8, :comment => "Ok, been a few days since having a smoke. Feeling pretty good.", :created_at => 10.days.ago)
    quit_smoking.updates.create(:status => 5, :comment => "Really having a hard time resisting right now. It's all I can think about.", :created_at => 4.days.ago)
    quit_smoking.updates.create(:status => 2, :comment => "Had a few drinks last night and just had to have a smoke. Ended up having 5 or so. Fuck this is hard.", :created_at => 1.day.ago)
    quit_smoking.updates.create(:status => 1, :comment => "I don't think I can do this. Had another smoke tonight feeling guilty about having smokes over the weekend... Trying to quit is stressing me out and of couse I want to smoke more when I'm stressed.", :created_at => 3.hours.ago)

    another_smoker = Factory(:user)
    quit_smoking_2 = Factory(:goal, :user => another_smoker, :title => "quit smoking now!")
    quit_smoking_2.updates.create(:status => 7, :comment => "It's been 3 days since my last smoke. Feeling pretty good", :created_at => 6.days.ago)
    quit_smoking_2.updates.create(:status => 9, :comment => "Made it through the weekend, and didn't have a single smoke despite getting pretty drunk", :created_at => 3.days.ago)
    quit_smoking_2.updates.create(:status => 5, :comment => "Ok, seems to be even harder when you're hungover. I'm seriously craving a smoke.", :created_at => 54.hours.ago)
    quit_smoking_2.updates.create(:status => 3, :comment => "Ok, had one smoke. I don't feel good about it, but it was killing me.", :created_at => 2.days.ago)
    quit_smoking_2.updates.create(:status => 10, :comment => "Had a smoke a few days ago, but now feeling reenergized to make this happen. Nothing's gonna stop me now!", :created_at => 3.hours.ago)

    quit_smoking_tag = Factory(:tag, :title => "quit smoking")
    addiction_tag = Factory(:tag, :title => "addiction")

    quit_smoking.tags << quit_smoking_tag
    quit_smoking.tags << addiction_tag

    quit_smoking_2.tags << quit_smoking_tag
    quit_smoking_2.tags << addiction_tag
  end
end

Factory.sequences.each do |name, seq|
  seq.instance_variable_set(:@value, 1000)
end

