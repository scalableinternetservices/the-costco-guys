class RatingsController < ApplicationController
    def create_rating
        if !session[:user]
            redirect_to login_path
            return
        end
    
        @item = Item.find(params[:item_id]) # Ensure :item_id is passed correctly
        @rating = @item.ratings.build(rating_params)
        @rating.user_id = session[:user]["id"]
    
        if @rating.save
            redirect_to item_path(@item), notice: "Successfully added rating"
        else
            redirect_to item_path(@item), alert: "Could not create review"
        end
    end

    private 

    def rating_params
        params.require(:rating).permit(:score, :comment)
    end 
end