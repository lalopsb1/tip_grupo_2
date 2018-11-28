# frozen_string_literal: true

class UsersController < ApplicationController
  before_filter :current_user_only
  skip_before_filter :redirect_if_address_nil, :except => [:show, :sign_out]
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update!(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:id, :name, :address, :avatar, :phone_number, :max_distance, :latitude, :longitude)
  end

  def current_user_only
    redirect_to root_path unless user_signed_in? && current_user.id == User.find(params[:id]).id
  end
end
