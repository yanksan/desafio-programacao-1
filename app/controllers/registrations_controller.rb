class RegistrationsController < Devise::RegistrationsController
  # Overwriting a function destroy registration controller of devise
  def destroy
    if resource.id
      user = resource.id
      
      # Deletes the relationship between the user and sale
      SalesUser.where('user_id = ?', user).delete_all

      resource.destroy
    end
    super
  end
end
