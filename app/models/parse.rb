class Parse < ApplicationRecord

	def self.save_transaction_financial(file)

    	File.open(file, 'r').each_line do |line|
    		
    		if line[0].to_i == 1 || line[0].to_i == 4
    			
    			date_transaction = self.transform_date_utc(line[1..8], line[42..47])

    			transaction = Transaction.find_or_create_by(type_transaction:line[0].to_i, date_time:date_transaction, value:line[9..18].to_f/100, cpf:line[19..29], credit_card:line[30..41])
    			transaction.save
    		end
    		
    	end
    end

    def self.transform_date_utc(date_transaction, hours_transaction)
    	
    	datetime_transaction = Date.strptime(date_transaction, "%s").strftime("%d-%m-%Y")
    	hours_transaction = DateTime.strptime(hours_transaction, "%s").strftime("%H:%M:%S")
    	datetime_transaction = datetime_transaction+" "+hours_transaction
    	nova_datetime = datetime_transaction.to_datetime
    	return nova_datetime + 3.hours

    end



end
