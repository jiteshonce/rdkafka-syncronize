# Create Kafka Topic if it does not exist
Rdkafka::Config.logger = Rails.logger
begin
  create_topic_handle = Rdkafka::Config.new({:"bootstrap.servers" => "172.23.16.1:9092"}).admin
                  .create_topic('our.new.topic', 1, 1)
  create_topic_handle.wait(max_wait_timeout: 1.0)
rescue Rdkafka::RdkafkaError
  Rails.logger.warn 'Kafka topic already exists'
rescue StandardError => e
  Rails.logger.error "Kafka error- (kafka_queues_init.rb): #{e.message}"
end