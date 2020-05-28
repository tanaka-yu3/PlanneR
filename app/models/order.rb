class Order < ApplicationRecord

  enum order_status: {
    waiting_payment: 0,
    complete_payment: 1,
    review_done: 2,
    sales_request: 3,
    transfer_complete: 4
  }

  belongs_to :user
  belongs_to :item

  validates :amount ,presence: true
  validates :first_day ,presence: true
  validates :last_day ,presence: true

  # validate :date_before_first
  # validate :date_before_last


  # def date_before_first
  #   return if first_day.blank?
  #   errors.add(:first_day, "は開始日以降のものを選択してください") if first_day < item.start_day
  # end

  # def date_before_last
  #   @item = Item.find(params[:item_id])
  #   return if last_day.blank? || first_day.blank?
  #   errors.add(:last_day, "は開始日以降のものを選択してください") if last_day < item.first_day
  # end

end