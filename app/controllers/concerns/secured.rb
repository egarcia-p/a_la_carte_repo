# frozen_string_literal: true

# Module that manages the scopes and jwt verification
module Secured
  extend ActiveSupport::Concern

  SCOPES = {
    '/api/v1/categories/index' => nil,
    '/api/private' => nil,
    '/api/private-scoped' => ['read'],
    'recipes/index' => ['read:recipe'],
    'recipes/create' => ['create:recipe'],
    'recipes/show/:id' => ['read:recipe'],
    'recipes/destroy/:id' => ['delete:recipe'],
    'sections/create' => ['create:recipe'],
    'sections/save_multiple' => ['create:recipe','update:recipe'],
    'sections/edit/:id' => ['update:recipe'],
    'sections/find_by_recipe_id/:id' => ['read:recipe'],
    'sections/update/:id' => ['update:recipe'],
    'sections/destroy/:id' => ['delete:recipe'],
    'steps/create' => ['create:recipe'],
    'steps/edit/:id' => ['create:recipe','update:recipe'],
    'steps/find_by_recipe_id/:id' => ['read:recipe'],
    'steps/find_by_section_id/:id' => ['read:recipe'],
    'steps/update/:id' => ['update:recipe'],
    'steps/destroy/:id' => ['delete:recipe'],
    'tags/index' => ['read:tag'],
    'tags/create' => ['create:tag'],
    'tags/edit/:id' => ['update:tag'],
    'tags/update/:id' => ['update:tag'],
    'tags/destroy/:id' => ['delete:tag'],
    'categories/index' => ['read:category'],
    'categories/create' => ['create:category'],
    'categories/edit/:id' => ['update:category'],
    'categories/update/:id' => ['update:category'],
    'categories/destroy/:id' => ['delete:category'],
    'subcategories/index' => ['read:subcategory'],
    'subcategories/create' => ['create:subcategory'],
    'subcategories/edit/:id' => ['update:subcategory'],
    'subcategories/update/:id' => ['update:subcategory'],
    'subcategories/destroy/:id' => ['delete:subcategory'],
    'ingredients/index' => ['read:ingredient'],
    'ingredients/create' => ['create:ingredient'],
    'ingredients/edit/:id' => ['update:ingredient'],
    'ingredients/update/:id' => ['update:ingredient'],
    'ingredients/destroy/:id' => ['delete:ingredient'],
    'uoms/index' => ['read:uom'],
    'uoms/create' => ['create:uom'],
    'uoms/edit/:id' => ['update:uom'],
    'uoms/update/:id' => ['update:uom'],
    'uoms/destroy/:id' => ['delete:uom'],
  }.freeze

  included do
    before_action :authenticate_request!
  end

  private

  def authenticate_request!
    @auth_payload, @auth_header = auth_token

    render json: { errors: ['Insufficient scope'] }, status: :forbidden unless scope_included
  rescue JWT::VerificationError, JWT::DecodeError
    render json: { errors: ['Not Authenticated'] }, status: :unauthorized
  end

  def http_token
    request.headers['Authorization'].split(' ').last if request.headers['Authorization'].present?
  end

  def auth_token
    JsonWebToken.verify(http_token)
  end

  def scope_included
    # The intersection of the scopes included in the given JWT and the ones in the SCOPES hash needed to access
    # the PATH_INFO, should contain at least one element
    if SCOPES[request.env['PATH_INFO']].nil?
      true
    else
      (String(@auth_payload['scope']).split(' ') & (SCOPES[request.env['PATH_INFO']])).any?
    end
  end
end
