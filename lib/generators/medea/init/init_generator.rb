require 'generators/medea'
require 'rails/generators/generated_attribute'
require 'medea'

require 'rest_client'

module Medea
  module Generators
    class InitGenerator < Base
      no_tasks { attr_accessor :topic, :user, :pass }
      argument :jason_topic, :type => :string, :required => false, :banner => "Topic"
      argument :username, :type => :string, :required => false, :banner => "username"
      argument :password, :type => :string, :required => false, :banner => "password"

      class_option :skip_topics, :desc => 'Don\'t automatically create topics.', :type => :boolean

      def initialize(*args, &block)
        super

        @topic = jason_topic
        if not @topic
          @topic ||= random_string 10
          if @topic[0] =~ /[0-9]/
            @topic[0] = "abcdefghij"[@topic[0].to_i]
          end
        end
        @user = username
        @user ||= random_string
        @pass = password
        @pass ||= random_string
      end

      def init
        #we can't create the topic, but we can create database.yml
        template "database.yml", "config/database.yml"
        template "jasondb.rb", "config/initializers/jasondb.rb"
        create_topics
      end

      def patch_application
        new_requires = <<-END
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'active_resource/railtie'
require 'rails/test_unit/railtie'
        END

        #open up application.rb
        application_rb = File.new("#{Rails.root}/config/application.rb")
        lines = application_rb.readlines
        application_rb.close

        changes = false
        #find the line that reads require 'rails/all'
        lines.each do |line|
          #replace that line with the new four
          changes = true if line.gsub!(/require 'rails\/all'/, new_requires)
        end

        if changes
          application_rb = File.new("#{Rails.root}/config/application.rb", "w")
          lines.each do |line|
            application_rb.write line
          end

          application_rb.close
          say_status "patch", "config/application.rb", :green
        else
          say_status "check", "config/application.rb", :blue
        end
      end

      protected
      
        def random_string length = 25
          rand(32**length).to_s(32)
        end

        def create_topic topic
          payload = {
              "..USERNAME" => @user,
              "..PASSWORD" => @pass,
              "..CONFIRM_PASSWORD" => @pass,
              "..PERMISSIONS" => "S",
              "..CHECKSUM" => "FALSE",
              "..DOMAIN" => %({"domain":"http://rest.jasondb.com/#{topic}"}),
              "..STATE" => "0 EQ 0 THEN ..NEW THEN ..NEW",
              "..A_new_domain" => "Your new domain #{topic} has been created"
          }
          success = true
          begin
            resp = RestClient.post "https://rest.jasondb.com/#{topic}", payload
            if resp.code == 201
              #success!
            else
              success = false
            end
          rescue
            success = false
          end

          if success
            say_status "create", "JasonDB Topic: #{topic}"
          else
            if topic[0] =~ /[0-9]/
              say_status "error", "An error occurred while creating the Topic. It must start with a letter", :red
            else
              say_status "warning", "An error occurred while creating the Topic. Does it already exist?", :yellow
            end
          end

        end

        def create_topics
          unless options.skip_topics?
            create_topic "#{@topic}-dev"
            create_topic "#{@topic}-test"
            create_topic @topic
          end
        end
    end
  end
end
