require 'spec_helper'

describe "Questions" do
  let(:question) {FactoryGirl.create(:question)}

  describe "POST /posts" do
    it "should allow an author to post a post" do
      login(author)

      visit new_post_path
      fill_in "", :with => ""
      click_button I18n.t('buttons.create_post')
      page.should have_content("A Sample post title")
      page.should have_content("A sample photo title")
      page.should have_content("this is the photo caption")
      page.should have_xpath("//img[contains(@src,\"hutchhead.png\")]") 
    end
  end

end
