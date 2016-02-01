module CapybaraHelpers
  def self.included( config )
    p '8888888888888888888888888888888888888888888888'
    config.after( :each ) do |example|
      p 'fffffffffffffffffffffffffffffffffffffffffffffffffff'
      if example.exception and example.metadata[:js]
        meta = example.metadata
        filename, line_number = File.basename( meta[ :file_path ] ), meta[ :line_number ]
        screenshot_name = "#{filename}-#{line_number}.png"
        html_name = "#{filename}-#{line_number}.html"

        puts
        puts "A capybara error was detected, the following files were saved to help you debug it:"
        sreenshot_path = Rails.root.join( 'tmp', 'snapshots', screenshot_name )
        page.save_screenshot sreenshot_path
        puts "  screenshot: #{sreenshot_path}"

        html_path = Rails.root.join( 'tmp', 'snapshots', html_name )
        save_page html_path
        puts "  html file: #{html_path}"
        puts
      end
    end
  end
end
