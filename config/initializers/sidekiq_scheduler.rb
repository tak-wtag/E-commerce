require 'sidekiq'
require 'sidekiq-scheduler'

Sidekiq.configure_server do |config|
  config.on(:startup) do
    yml_file = Rails.root.join('config', 'sidekiq.yml')

    if File.exist?(yml_file)
      config_data = YAML.load_file(yml_file)
      
      schedule_data = config_data[:schedule] || config_data['schedule']

      if schedule_data
        Sidekiq.schedule = schedule_data
        Sidekiq::Scheduler.reload_schedule!
        puts "✅ SUCCESS: Schedule loaded manually! Jobs: #{schedule_data.keys.join(', ')}"
      else
        puts "⚠️ WARNING: Found sidekiq.yml but no 'schedule' key found inside."
      end
    else
      puts "❌ ERROR: Could not find file at #{yml_file}"
    end
  end
end