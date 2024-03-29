# frozen_string_literal: true

class CustomFailure < Devise::FailureApp
  def respond
    if http_auth?
      http_auth
    else
      redirect
    end
  end
end
