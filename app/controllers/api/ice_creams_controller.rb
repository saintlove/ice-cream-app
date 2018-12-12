class Api::IceCreamsController < ApplicationController
  def index
    @ice_creams = Ice_Cream.all

    search_term = params[:search]
    if search_term
      @ice_creams = @ice_creams.where("flavor iLIKE ? OR description iLIKE ?", "%#{search_term}%", "%#{search_term}%")
    end

    sort_attribute = params[:sort_by]
    sort_order = params[:sort_order]

    if sort_attribute && sort_order
      @ice_creams = @ice_creams.order(sort_attribute => sort_order)
    elsif sort_attribute
      @ice_creams = @ice_creams.order(sort_attribute => :asc)
    else
      @ice_creams = @ice_creams.order(:id => :asc)
    end

    category_name = params[:category]
      if category_name
        category = Category.find_by(flavor: category_name)
        @ice_creams = category.ice_creams
       end

    render 'index.json.jbuilder'
  end

  def show
    ice_cream_id = params[:id]
    @ice_cream = Ice_Cream.find(ice_cream_id)
    render 'show.json.jbuilder'
  end

  def create
    @ice_cream = Ice_Cream.new(
                            flavor: params[:flavor],
                            description: params[:description],
                            vegan: params[:vegan],
                            gluten_free: params[:gluten_free],
                            ingredients: params[:ingredients],
                            pairs_with: params[:pairs_with]
                           )

    if @ice_cream.save
       render 'show.json.jbuilder'
    else
      render json: {errors: @ice_cream.errors.full_messages}, status: :unprocessable_entity
    end
  end
 

  def update
    ice_cream_id = params[:id]
    @ice_cream = Ice_Cream.find(ice_cream_id)

    @ice_cream.flavor = params[:flavor] || @ice_cream.flavor
    @ice_cream.description = params[:description] || @ice_cream.description
    @ice_cream.vegan = params[:vegan] || @ice_cream.vegan
    @ice_cream.gluten_free = params[:gluten_free] || @ice_cream.gluten_free
    @ice_cream.ingredients = params[:ingredients] || @ice_cream.ingredients
    @ice_cream.pairs_with = params[:pairs_with] || @ice_cream.pairs_with


      
      if @ice_cream.save
        render 'show.json.jbuilder'
      else
        render json: {errors: @ice_cream.errors.full_messages}, status: :unprocessable_entity
      end
    end

  def destroy
    ice_cream_id = params[:id]
    @ice_cream = Ice_Cream.find(ice_cream_id)
    @ice_cream.destroy
    render json: {message: "Ice Cream successfully destroyed"}
  end
end



