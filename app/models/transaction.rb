class Transaction < ApplicationRecord
	scope :type_transaction, -> (type_transaction) { where type_transaction: type_transaction }
  	scope :value, -> (value) { where value: value }
  	scope :date_time, -> (date_time) { where date_time: date_time}
  	scope :cpf, -> (cpf) { where cpf: cpf }
  	scope :credit_card, -> (credit_card) { where credit_card: credit_card }
end
