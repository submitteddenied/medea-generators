require 'generators/medea'
require 'rails/generators/generated_attribute'
require 'medea'

module Medea
  module Generators
    class InitGenerator < Base
      no_tasks {
        attr_accessor :topic, :user, :pass

        def random_string length = 25
          rand(32**length).to_s(32)
        end
      }
      argument :jason_topic, :type => :string, :required => true, :banner => "Topic"
      argument :username, :type => :string, :required => false, :banner => "username"
      argument :password, :type => :string, :required => false, :banner => "s3cretp@ssword"

      def initialize(*args, &block)
        super

        @topic = jason_topic
        @user = username
        @user ||= random_string
        @pass = password
        @pass ||= random_string
      end

      def init_jasondb
        #we can't create the topic, but we can create database.yml
        template "database.yml", "config/database.yml"

#        #we will also deploy templates at this point.
#        jason_base = "http://#{@user}:#{@pass}@rest.jason.com/"
#        topics = [@topic, "#{@topic}-dev", "#{@topic}-test"]
#        for t in topics
#          Medea::setup_templates "#{jason_base}#{t}/"
#        end
      end
    end
  end
end
