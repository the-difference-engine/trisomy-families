class HomePageContentsController < ApplicationController

  def edit
    @home_page_content = HomePageContent.first
  end

  def update
    @home_page_content = HomePageContent.first

    @home_page_content.update(
                              banner_title: params[:home_page_content][:banner_title],
                              banner_text: params[:home_page_content][:banner_text],
                              mission_title: params[:home_page_content][:mission_title],
                              mission_sub_title: params[:home_page_content][:mission_sub_title],
                              mission_text: params[:home_page_content][:mission_text],
                              create_profile_title: params[:home_page_content][:create_profile_title],
                              create_profile_text: params[:home_page_content][:create_profile_text],
                              family_center_title: params[:home_page_content][:family_center_title],
                              family_center_text: params[:home_page_content][:family_center_text],
                              data_center_title: params[:home_page_content][:data_center_title],
                              data_center_text: params[:home_page_content][:data_center_text],
                              birthday_title: params[:home_page_content][:birthday_title],
                              birthday_text: params[:home_page_content][:birthday_text],
                              company_title: params[:home_page_content][:company_title],
                              company_phone_number: params[:home_page_content][:company_phone_number],
                              company_address: params[:home_page_content][:company_address]
                              )
    redirect_to '/'
  end

end
