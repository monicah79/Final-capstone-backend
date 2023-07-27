class Users::RegistrationsController < Devise::RegistrationsController
  include RackSessionsFix
  respond_to :json

  def create
    # dont include admin_password in the params sent to Devise
    build_resource(sign_up_params.except(:admin_password))

    resource.role = if params[:user][:admin_password] == '69420lesgooo'
                      :admin
                    else
                      :normal_user # Set default role for normal users
                    end

    resource.save
    yield resource if block_given?

    if resource.persisted?
      render json: {
        status: { code: 200, message: 'Signed up successfully.' },
        data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
      }
    else
      render json: {
        status: { message: "User couldn't be created successfully. #{resource.errors.full_messages.to_sentence}" }
      }, status: :unprocessable_entity
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :admin_password)
  end
end
