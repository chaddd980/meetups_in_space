require 'spec_helper'

feature "user views index page" do
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

  let!(:meetup_2) do
    Meetup.create(
    name: "Free Code Camp Markham weekly meetup",
    description: "Come join us sunday as usual to code with us. bring a laptop and anything you want to work on",
    date: "04/12/2016",
    time: "1:00pm - 3:00pm",
    creator: "stef980",
    location: "Markham"

    )
  end

  let!(:meetup_3) do
    Meetup.create(
    name: "Free Code Camp Toronto weekly meetup",
    description: "Come join us sunday as usual to code with us. bring a laptop and anything you want to work on",
    date: "04/12/2016",
    time: "5:00pm - 8:00pm",
    creator: "kwashi980",
    location: "Toronto"
    )
  end


  let!(:meetup_4) do
    Meetup.create(
    name: "Free Code Camp Richmond Hill weekly meetup",
    description: "Come join us saturday as usual to code with us. bring a laptop and anything you want to work on",
    date: "04/12/2016",
    time: "6:00pm - 8:00pm",
    creator: "hally990",
    location: "Richmond Hill"
    )
  end

  scenario "user visits main page" do
    visit '/meetups'

    expect(page).to have_content("Free Code Camp Scarborough weekly meetup")
  end
end
