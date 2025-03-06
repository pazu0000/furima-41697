class ItemsController < ApplicationController
  def
  private

    def item_params
      params.require(:item).permit(:name, :description, :category_id, :condition_id, :shipping_fee_id, :prefecture_id,
                                   :shipping_day_id, :sale_price)
    end
  end
end
