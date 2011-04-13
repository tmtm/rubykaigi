class AdminAssistant
  class Index
    class View
      def delete_link(record)
        @action_view.link_to(
          'Delete',
          :remote => true,
          :url => {:action => 'destroy', :id => record.id},
          :confirm => 'Are you sure?',
          :success =>
            "Effect.Fade('#{@admin_assistant.model_class.name.underscore}_#{record.id}', {duration: 0.25})",
          :method => :delete
        )
      end
    end
  end
end
