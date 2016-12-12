require 'spec_helper'

feature "user joins a meetup" do
  let(:user) do
    User.create(
      provider: "github",
      uid: "1",
      username: "jarlax1",
      email: "jarlax1@launchacademy.com",
      avatar_url: "https://avatars2.githubusercontent.com/u/174825?v=3&s=400"
    )
 end

 let!(:meetup_1) do
  Meetup.create(
  name: "Free Code Camp Scarborough weekly meetup",
  description: "Come join us saturday as usual to code with us. bring a laptop and anything you want to work on",
  date: "03/12/2016",
  time: "1:00pm - 3:00pm",
  creator: "Chadd980",
  location: "Scarborough"
  )
end

  scenario "on meetup page there is a button to join the meetup" do
    visit "/meetups/#{meetup_1.id}"
    join_link = find("#join").value

    expect(join_link).to eq("Join_Meetup")
  end

  scenario "user clicks join button" do
    sign_in_as user
    visit "/meetups/#{meetup_1.id}"
    click_on("Join_Meetup")

    expect(page).to have_content("Congrats! you joined this meetup")
  end
end
