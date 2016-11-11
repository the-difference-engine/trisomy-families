class AddIbdToIntestinalIssues < ActiveRecord::Migration[5.0]
  def change
    add_column :intestinal_issues, :ibd, :boolean
  end
end
