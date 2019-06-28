ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    columns :class => 'admin-columns' do
      column :class => 'admin-column' do
        panel "Screenshots backlog (#{Screenshot.unpublished.count})" do
          div :class => 'panel-content' do
            table_for Screenshot.unpublished do |t|
              t.column("Title") { |s| s.id }
              t.column("Game") { |s| s.game.name }
              t.column("Pub date") { |s| s.publication_date }
            end
          end
        end
      end

      column :class => 'admin-column' do
        panel "Submissions (#{Submission.all.count})" do
          div :class => 'panel-content' do
            table_for Submission.all.limit(5) do |t|
              t.column("Email") { |s| s.email }
              t.column("Game") { |s| s.game }
            end
          end
        end
      end
    end
  end # content
end
