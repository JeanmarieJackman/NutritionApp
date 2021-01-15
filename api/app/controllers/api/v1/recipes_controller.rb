class Api::V1::RecipesController < ApplicationController
    before_action :find_recipe, only: [:show, :update, :destroy]

    def index
        @recipes = Recipe.all
        render json: @recipes
    end

    def show 
        render json: @recipe
    end

    def create 
        @recipe = Recipe.new(recipe_params)
        if @recipe.save
            render json: @recipe
        else
            render error: { error: "Couldn't create recipe." }, status: 400
        end
    end

    def update 
        if @recipe 
            @recipe.update(recipe_params)
            render json: { message: 'Recipe successfully updated.' }, status: 200
        else
            render json: { error: 'Unable to update recipe.' }, status:400 
        end
    end

    def destroy
        if @recipe
            @recipe.destroy
            render json: { message: 'Recipe successfully deleted.' }, status: 200 
        else
            render json: { error: 'Unable to delete recipe.' }, status: 400
        end
    end

    private

    def recipe_params
        params.require(:recipe).permit(:title, :user_id)
    end 

    def find_recipe
        @recipe = Recipe.find(params[:id])
    end


end
