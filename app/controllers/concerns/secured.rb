# frozen_string_literal: true

# Module that manages the scopes and jwt verification
module Secured
  extend ActiveSupport::Concern
  # TODO: DELETE SCOPES FORM HERE
  SCOPES = {
    '/api/v1/categories/index' => nil,
    '/api/private' => nil,
    '/api/private-scoped' => ['read'],
    'recipes/index' => ['read:recipe'],
    'recipes/create' => ['create:recipe'],
    'recipes/show/:id' => ['read:recipe'],
    'recipes/destroy/:id' => ['delete:recipe'],
    'sections/create' => ['create:recipe'],
    'sections/save_multiple' => ['create:recipe', 'update:recipe'],
    'sections/edit/:id' => ['update:recipe'],
    'sections/find_by_recipe_id/:id' => ['read:recipe'],
    'sections/update/:id' => ['update:recipe'],
    'sections/destroy/:id' => ['delete:recipe'],
    'steps/create' => ['create:recipe'],
    'steps/edit/:id' => ['create:recipe', 'update:recipe'],
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
    'uoms/destroy/:id' => ['delete:uom']
  }.freeze

  REQUIRES_AUTHENTICATION = { message: 'Requires authentication' }.freeze
  BAD_CREDENTIALS = {
    message: 'Bad credentials1 '
  }.freeze
  MALFORMED_AUTHORIZATION_HEADER = {
    error: 'invalid_request',
    error_description: 'Authorization header value must follow this format: Bearer access-token',
    message: 'Bad credentials2'
  }.freeze
  INSUFFICIENT_PERMISSIONS = {
    error: 'insufficient_permissions',
    error_description: 'The access token does not contain the required permissions',
    message: 'Permission denied'
  }.freeze

  def authorize
    token = token_from_request

    return if performed?

    validation_response = Auth0Client.validate_token(token)

    @decoded_token = validation_response.decoded_token

    return unless (error = validation_response.error)

    render json: { message: error.message }, status: error.status
  end

  def validate_permissions(permissions)
    raise 'validate_permissions needs to be called with a block' unless block_given?
    return yield if @decoded_token.validate_permissions(permissions)

    render json: INSUFFICIENT_PERMISSIONS, status: :forbidden
  end

  def current_user
    sub = @decoded_token.token[0]['sub']

    User.find_by(sub: sub) || User.create(sub: sub)
  end

  private

  def token_from_request
    authorization_header_elements = request.headers['Authorization']&.split

    render json: REQUIRES_AUTHENTICATION, status: :unauthorized and return unless authorization_header_elements

    unless authorization_header_elements.length == 2
      render json: MALFORMED_AUTHORIZATION_HEADER, status: :unauthorized and return
    end

    scheme, token = authorization_header_elements

    render json: BAD_CREDENTIALS, status: :unauthorized and return unless scheme.downcase == 'bearer'

    token
  end
end
