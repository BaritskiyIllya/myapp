config = {
  host: ENV['ELASTIC_INVEST_HOST'],
  transport_options: {
    request: { timeout: 5 }
  }
}

if File.exist?('config/elasticsearch.yml')
  config.merge!(YAML.load_file('config/elasticsearch.yml')[Rails.env].symbolize_keys)
end

Elasticsearch::Model.client = Elasticsearch::Client.new(config)
