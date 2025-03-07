# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController # rubocop:todo Style/Documentation
      before_action :authorize

      def show
        if user
          render json: user
        else
          render json: user.errors
        end
      end


      private

      def user
        @user ||= current_user()
      end
    end
  end
end
