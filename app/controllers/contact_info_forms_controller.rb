class ContactInfoFormsController < ApplicationController
  def new
    @contact_info_form = ContactInfoForm.new
    if params[:child_id]
      @child_id = params[:child_id]
      render 'new.html.erb'
    else
      flash[:danger] = "Something went wrong"
      redirect_to '/'
    end
  end

  def create
    family = Family.find_by(user_id: current_user.id)
    contact_info = ContactInfoForm.new(contact_info_params)
    contact_info.update(child_id: params[:child_id])

    if contact_info.save      
      flash[:success] = "Contact info for your child registration has been submitted!"
      redirect_to "/profile/#{params[:child_id]}"
    else
      flash[:danger] = "Something went wrong. Please fill out every field in the form."
      render 'new.html.erb'
    end
  end

  def show
  end

  def edit
    @contact_info_form = ContactInfoForm.find_by(id: params[:id])
  end

  def update
    family = Family.find_by(user_id: current_user.id)
    contact_info = ContactInfoForm.find_by(id: params[:id])

    if contact_info.update(contact_info_params)
      flash[:success] = "Contact info for your child registration has been update!"
      redirect_to "/profile/#{contact_info.child_id}"
    else
      flash[:danger] = "Something went wrong. Please fill out every field in the form."
      render 'edit.html.erb'
    end
  end

  def contact_info_params
    params.require(:contact_info_form).permit(
      :contact_first_name,
      :contact_last_name,
      :contact_email,
      :contact_phone,
      :parent_first_name,
      :parent_last_name,
      :parent_email,
      :parent_phone,
      :relationship,
      :other_info
    )
  end
end
