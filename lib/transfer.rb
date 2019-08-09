class Transfer
  attr_reader :sender, :receiver
  attr_accessor :status, :amount

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = 'pending'
  end

  def execute_transaction
    if @sender.balance < @amount
      @status = 'rejected'
      return "Transaction rejected. Please check your account balance."
    end
    return if @status == 'complete'
    @sender.withdraw(@amount)
    @receiver.deposit(@amount)
    @status = 'complete'
  end

  def reverse_transfer
    return if @status != 'complete'
    @sender.deposit(@amount)
    @receiver.withdraw(@amount)
    @status = 'reversed'
  end

  def valid?
    @sender.valid? && @receiver.valid?
  end

end
