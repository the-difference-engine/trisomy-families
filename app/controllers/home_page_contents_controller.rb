class HomePageContentsController < ApplicationController


  def create
    @home_page_content = HomePageContent.new(
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

    if params["home_page_content"]["banner_image"] != nil
      charset = Array('A'..'Z') + Array('a'..'z')
      random_string = Array.new(20) { charset.sample }.join
      object_name = random_string + '_' + params["home_page_content"]["banner_image"].original_filename
      obj = S3_BUCKET.object(object_name)
      obj.upload_file(params["home_page_content"]["banner_image"].tempfile.path)
      @home_page_content.banner_image = obj.public_url
    end
    if params["home_page_content"]["create_profile_image1"] != nil
      charset = Array('A'..'Z') + Array('a'..'z')
      random_string = Array.new(20) { charset.sample }.join
      object_name = random_string + '_' + params["home_page_content"]["create_profile_image1"].original_filename
      obj = S3_BUCKET.object(object_name)
      obj.upload_file(params["home_page_content"]["create_profile_image1"].tempfile.path)
      @home_page_content.create_profile_image1 = obj.public_url
    end
    if params["home_page_content"]["create_profile_image2"] != nil
      charset = Array('A'..'Z') + Array('a'..'z')
      random_string = Array.new(20) { charset.sample }.join
      object_name = random_string + '_' + params["home_page_content"]["create_profile_image2"].original_filename
      obj = S3_BUCKET.object(object_name)
      obj.upload_file(params["home_page_content"]["create_profile_image2"].tempfile.path)
      @home_page_content.create_profile_image2 = obj.public_url
    end
    if params["home_page_content"]["create_profile_image3"] != nil
      charset = Array('A'..'Z') + Array('a'..'z')
      random_string = Array.new(20) { charset.sample }.join
      object_name = random_string + '_' + params["home_page_content"]["create_profile_image3"].original_filename
      obj = S3_BUCKET.object(object_name)
      obj.upload_file(params["home_page_content"]["create_profile_image3"].tempfile.path)
      @home_page_content.create_profile_image3 = obj.public_url
    end
    if params["home_page_content"]["family_center_image"] != nil
      charset = Array('A'..'Z') + Array('a'..'z')
      random_string = Array.new(20) { charset.sample }.join
      object_name = random_string + '_' + params["home_page_content"]["family_center_image"].original_filename
      obj = S3_BUCKET.object(object_name)
      obj.upload_file(params["home_page_content"]["family_center_image"].tempfile.path)
      @home_page_content.family_center_image = obj.public_url
    end
    if params["home_page_content"]["data_center_image"] != nil
      charset = Array('A'..'Z') + Array('a'..'z')
      random_string = Array.new(20) { charset.sample }.join
      object_name = random_string + '_' + params["home_page_content"]["data_center_image"].original_filename
      obj = S3_BUCKET.object(object_name)
      obj.upload_file(params["home_page_content"]["data_center_image"].tempfile.path)
      @home_page_content.data_center_image = obj.public_url
    end

    if @home_page_content.save 
      flash[:success] = "Home Page Created Successfully."
      redirect_to "/"
    else
      render :new 
    end
  end

  def new
    @home_page_content = HomePageContent.new
  end

  def edit
    if current_user && current_user.user_type == 'admin'
      @home_page_content = HomePageContent.first
    else
      redirect_to '/'
    end
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

    if params["home_page_content"]["banner_image"] != nil
      charset = Array('A'..'Z') + Array('a'..'z')
      random_string = Array.new(20) { charset.sample }.join
      object_name = random_string + '_' + params["home_page_content"]["banner_image"].original_filename
      obj = S3_BUCKET.object(object_name)
      obj.upload_file(params["home_page_content"]["banner_image"].tempfile.path)
      @home_page_content.update(banner_image: obj.public_url)
    elsif params[:no_banner_image] == "n/a"
      @home_page_content.update(banner_image: "")
    end
    if params["home_page_content"]["create_profile_image1"] != nil
      charset = Array('A'..'Z') + Array('a'..'z')
      random_string = Array.new(20) { charset.sample }.join
      object_name = random_string + '_' + params["home_page_content"]["create_profile_image1"].original_filename
      obj = S3_BUCKET.object(object_name)
      obj.upload_file(params["home_page_content"]["create_profile_image1"].tempfile.path)
      @home_page_content.update(create_profile_image1: obj.public_url)
    elsif params[:no_profile_image_1] == "n/a"
      @home_page_content.update(create_profile_image1: "")
    end
    if params["home_page_content"]["create_profile_image2"] != nil
      charset = Array('A'..'Z') + Array('a'..'z')
      random_string = Array.new(20) { charset.sample }.join
      object_name = random_string + '_' + params["home_page_content"]["create_profile_image2"].original_filename
      obj = S3_BUCKET.object(object_name)
      obj.upload_file(params["home_page_content"]["create_profile_image2"].tempfile.path)
      @home_page_content.update(create_profile_image2: obj.public_url)
    elsif params[:no_profile_image_2] == "n/a"
      @home_page_content.update(create_profile_image2: "")
    end
    if params["home_page_content"]["create_profile_image3"] != nil
      charset = Array('A'..'Z') + Array('a'..'z')
      random_string = Array.new(20) { charset.sample }.join
      object_name = random_string + '_' + params["home_page_content"]["create_profile_image3"].original_filename
      obj = S3_BUCKET.object(object_name)
      obj.upload_file(params["home_page_content"]["create_profile_image3"].tempfile.path)
      @home_page_content.update(create_profile_image3: obj.public_url)
    elsif params[:no_profile_image_3] == "n/a"
      @home_page_content.update(create_profile_image3: "")
    end
    if params["home_page_content"]["family_center_image"] != nil
      charset = Array('A'..'Z') + Array('a'..'z')
      random_string = Array.new(20) { charset.sample }.join
      object_name = random_string + '_' + params["home_page_content"]["family_center_image"].original_filename
      obj = S3_BUCKET.object(object_name)
      obj.upload_file(params["home_page_content"]["family_center_image"].tempfile.path)
      @home_page_content.update(family_center_image: obj.public_url)
    elsif params[:no_family_center_image] == "n/a"
      @home_page_content.update(family_center_image: "")
    end
    if params["home_page_content"]["data_center_image"] != nil
      charset = Array('A'..'Z') + Array('a'..'z')
      random_string = Array.new(20) { charset.sample }.join
      object_name = random_string + '_' + params["home_page_content"]["data_center_image"].original_filename
      obj = S3_BUCKET.object(object_name)
      obj.upload_file(params["home_page_content"]["data_center_image"].tempfile.path)
      @home_page_content.update(data_center_image: obj.public_url)
    elsif params[:no_data_center_image] == "n/a"
      @home_page_content.update(data_center_image: "")
    end

    redirect_to '/'
  end

end
