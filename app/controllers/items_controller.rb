class ItemsController < ApplicationController
  def create
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :condition_id, :shipping_fee_id, :prefecture_id,
                                 :shipping_day_id, :sale_price).margeU(usr_id: current_user.id)
  end
end
