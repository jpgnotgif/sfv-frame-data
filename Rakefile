require 'yaml'
require 'logger'

@logger = Logger.new($stdout)

namespace :data do
  desc 'Generate SFV frame data for a given season'
  task :generate, [:season] do |task, args|
    parser_command = 'bundle exec ./bin/sfv_parser'
    season = "s#{args[:season]}"
    config = YAML.load(File.read('config.yml'))
    data_path = File.join(config['frda_api']['path'], season)
    base_path = File.join(Dir.pwd, 'sfv', season)
    data_files = Dir.glob(File.join(base_path, 'csv/*.csv'))

    data_files.each do |file|
      @logger.info("Generating JSON data given file #{file.inspect}")
      `#{parser_command} #{file} -#{season}`
    end

    @logger.info("Copying JSON files to #{data_path.inspect}")
    copy_command = "cp #{base_path}/json/* #{data_path}"
    @logger.info(copy_command)
    `#{copy_command}`
  end
end
