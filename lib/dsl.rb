module DSL
    def self.included(base)
        base.extend(ClassMethods)
        
        base.class_eval do
            @routes = Routes.new
        end
    end
    
    module ClassMethods
        attr_reader :routes

        def get   (path, opts={}, &block) @routes.add(:get,    path, &block) end
        def post  (path, opts={}, &block) @routes.add(:post,   path, &block) end
        def put   (path, opts={}, &block) @routes.add(:put,    path, &block) end
        def delete(path, opts={}, &block) @routes.add(:delete, path, &block) end
    end
    
end
