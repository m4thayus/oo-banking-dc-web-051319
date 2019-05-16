require 'pry'

class Transfer
    attr_accessor :status
    attr_reader :sender, :receiver, :amount

    def initialize(sender, receiver, amount, status="pending")
        @sender = sender
        @receiver = receiver
        @amount = amount
        @status = status
    end

    def valid?
        self.sender.valid? && self.receiver.valid?
    end

    def available_balance?
        self.sender.balance >= self.amount
    end

    def execute_transaction
        if self.valid? && self.status != "complete" && self.available_balance?
            self.sender.withdrawal(self.amount)
            self.receiver.deposit(self.amount)
            self.status = "complete"
        else
            self.status = "rejected"
            "Transaction rejected. Please check your account balance."
        end
    end
    
    def reverse_transfer
        if self.status == "complete"
            self.receiver.withdrawal(self.amount)
            self.sender.deposit(self.amount)
            self.status = "reversed"
        end
    end

end
