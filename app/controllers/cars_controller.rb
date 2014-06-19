class CarsController < ActionController::Base
  def index
    @cars = Car.all
  end

  def create
    if User.find_by(api_authentication_token: request.headers['Authorization'])
      attributes = JSON.parse(request.body.read)
      @car = Car.create(attributes)

      render status: 201
    else
      render json: {}, status: 401
    end
  end

  def show
    @car = Car.find_by(id: params[:id])

    if @car.present?
      render :show
    else
      render json: {}, status: 404
    end
  end
end