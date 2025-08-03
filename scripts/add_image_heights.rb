require 'yaml'
require 'mini_magick'

DATA_PATH = File.expand_path('../_data/portfolio.yaml', __dir__) # Adjust if needed

# Load YAML data
portfolio = YAML.load_file(DATA_PATH)

portfolio.each do |item|
  img_path = File.expand_path("../#{item['src']}", __dir__) # Assuming 'src' is relative to root folder

  if File.exist?(img_path)
    image = MiniMagick::Image.open(img_path)
    item['width'] = image.width
    item['height'] = image.height
    puts "Processed #{item['src']}: #{image.width}x#{image.height}"
  else
    puts "Image not found: #{img_path}"
  end
end

# Write updated YAML back
File.open(DATA_PATH, 'w') do |file|
  file.write portfolio.to_yaml
end

puts "Updated #{DATA_PATH}"