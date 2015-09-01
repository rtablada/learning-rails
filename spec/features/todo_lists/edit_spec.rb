require 'rails_helper'

describe "Creating todo lists" do
    def update_todo_list(options={})
        options[:title] ||= "New title"
        options[:description] ||= "New description"

        visit '/todo_lists'
        todo_list = TodoList.create(title: "Groceries", description: "Grocery List.")

        visit "/todo_lists"
        within "#todo_list_#{todo_list.id}" do
            click_link "Edit"
        end

        fill_in "Title", with: options[:title]
        fill_in "Description", with: options[:description]
        click_button "Update Todo list"

        todo_list.reload
    end

    it "updates a todo list successfully with correct information" do
        todo_list = update_todo_list

        expect(page).to have_content "Todo list was successfully updated."
        expect(todo_list.title).to eq "New title"
        expect(todo_list.description).to eq "New description"
    end

end
