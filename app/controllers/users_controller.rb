class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome #{@user.name} to the BMI calculator"
      redirect_to @user
    else
      render 'new'
    end
  end

  def bmi_calc
    bmi_table = {
      "Very severely underweight"             => { from: 0.0, to: 15.0 },
      "Severely underweight"                  => { from: 15.1, to: 16.0 },
      "Underweight"                           => { from: 16.1, to: 18.5 },
      "Normal (healthy weight)"               => { from: 18.51, to: 25.0 },
      "Overweight"                            => { from: 25.1, to: 30.0 },
      "Obese class I (moderately obese)"      => { from: 30.1, to: 35.0 },
      "Obese class II (severely obese)"       => { from: 35.1, to: 40.0 },
      "Obese class III (very severely obese)" => { from: 40.1, to: 60.0 },
      "Pure fat factor"                       => { from: 60.1, to: 100.0}
    }
    weight = params[:mass].to_f
    height = params[:height].to_f
    if weight > 0 && height > 0
      puts weight
      puts height
      @resultado = ''
      @bmi = weight / height ** 2
      bmi_table.each do |advice, range|
        puts advice
        puts range[:from], range[:to]
        puts @bmi
        if (@bmi > range[:from]) && (@bmi < range[:to])
          @resultado = advice
        end
      end
      respond_to do |format|
        format.html
        format.json { render json: {bmi_calcul: @resultado} }
      end
    else
      redirect_to current_user
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
