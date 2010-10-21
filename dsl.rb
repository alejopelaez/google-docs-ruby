module DSL
    def self.included(base)
        base.extend(ClassMethods)
        base.class_eval do
            @routes = Routes.new
        end
    end
    
    attr_reader :routes

    def get( path, opts={}, &block) routes.add(:get, path, opts, &block) end
    def post( path, opts={}, &block) routes.add(:post, path, opts, &block) end
    def put( path, opts={}, &block) routes.add(:put, path, opts, &block) end
    def delete(path, opts={}, &block) routes.add(:delete, path, opts, &block) end
    
end
