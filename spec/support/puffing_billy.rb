Billy.configure do |c|
  c.record_requests = true
end

RSpec.configure do |config|
  # Print out requests received via the Puffing Billy proxy
  config.prepend_after(:example, type: :feature, js: true) do
    # puts "Requests received via Puffing Billy Proxy:"

    # puts TablePrint::Printer.table_print(Billy.proxy.requests, [
    #   :status,
    #   :handler,
    #   :method,
    #   { url: { width: 100 } },
    #   :headers,
    #   :body
    # ])
  end
end
