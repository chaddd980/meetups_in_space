require 'spec_helper'

feature "User creates new meetup" do
  let(:user) do
      User.create(
        provider: "github",
        uid: "1",
        username: "jarlax1",
        email: "jarlax1@launchacademy.com",
        avatar_url: "https://avatars2.githubusercontent.com/u/174825?v=3&s=400"
      )
   end


  scenario "User fills out form to create new meetup" do
    visit '/'
    sign_in_as user
    click_link 'Create New Meetup'
    fill_in 'name', with: 'chadd meetup'
    fill_in 'description', with: 'linkup fam!'
    fill_in 'date', with: '02/02/1999'
    fill_in 'time', with: '3:30pm'
    fill_in 'location', with: 'Wherever mans are deh fam!'
    click_button 'Submit'

    expect(page).to have_content("Congrats! You successfuly created a new meetup")
  end

  scenario "User fills out form to create new meetup incorrectly" do
    visit '/'
    sign_in_as user
    click_link 'Create New Meetup'
    fill_in 'name', with: ''
    fill_in 'description', with: 'linkup fam!'
    fill_in 'date', with: '02/02/1999'
    fill_in 'time', with: '3:30pm'
    fill_in 'location', with: 'Wherever mans are deh fam!'
    click_button 'Submit'

    expect(page).to have_content("Name can't be blank")
  end
end
