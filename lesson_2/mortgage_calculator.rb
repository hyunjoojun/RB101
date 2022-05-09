require 'yaml'
MESSAGES = YAML.load_file('mortgage_calc_messages.yml')

def prompt(key, opts = {})
  message = format(messages(key), opts)
  puts "=> #{message}"
end

def messages(message)
  MESSAGES[message]
end

def valid_number?(num)
  positive?(num) && (integer?(num) || float?(num))
end

def positive?(num)
  num.to_i > 0
end

def integer?(num)
  num.to_i.to_s == num
end

def float?(num)
  num.to_f.to_s == num
end

prompt('welcome')

loop do
  amount = ''
  loop do
    prompt('amount')
    amount = gets.chomp
    if valid_number?(amount)
      break
    else
      prompt('invalid_number')
    end
  end

  annual_interest_rate = ''
  loop do
    prompt('annual_interest_rate')
    annual_interest_rate = gets.chomp
    if valid_number?(annual_interest_rate)
      break
    else
      prompt('invalid_number')
    end
  end

  years = ''
  loop do
    prompt('years')
    years = gets.chomp
    if valid_number?(years)
      break
    else
      prompt('invalid_number')
    end
  end

  monthly_interest_rate = ((annual_interest_rate.to_f * 0.01) / 12)
  months = (years.to_i * 12)
  denominator = 1 - (1 + monthly_interest_rate)**(-months)
  monthly_payment = amount.to_f * (monthly_interest_rate / denominator)

  prompt('monthly_payment', { monthly_payment:
                              format('%.2f', monthly_payment) })

  prompt('again')
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt('thank_you')
prompt('good_bye')
