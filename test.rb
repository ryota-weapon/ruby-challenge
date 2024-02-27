require "yaml"

begin
    yaml_file_path = ARGV[0]
    data = YAML.load(File.read(yaml_file_path))
rescue =>e
    puts "[PROGRAM EXITED]"
    puts "Please give a yaml file path like\n\t$ruby test.rb ./data/dummy.yml"
    puts e.message
    exit
end


data.each do |key, value|
    puts "#{key} has  #{value}"
end