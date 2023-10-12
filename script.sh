#!/bin/sh

function display_help() {
    gum style --background 255 --foreground 27 --align center --width 60 --border rounded \
        "Available Commands" \
        "'start a new project' - Initializes a new Git repository." \
        "'save my changes' - Adds and commits changes." \
        "'get latest updates' - Pulls the latest changes." \
        "'share my updates' - Pushes committed changes." \
        "'show my changes' - Shows the repository status." \
        "'create a branch' - Creates a new branch." \
        "'switch branch' - Switches to another branch." \
        "'show history' - Displays the commit history." \
        "'help' - Displays this help information." \
        "'exit' or 'quit' - Exits the script."
}

echo "Welcome to the enhanced Git assistant!"
gum spin --spinner globe -- sleep 2

# Loop forever until user quits
while true; do
    echo ""
    cmd=$(gum input --placeholder "Enter a Git Command (or 'help' for guidance):")

    case "$cmd" in
        "exit" | "quit")
            gum spin --spinner moon -- sleep 1
            echo "Goodbye!"
            break
            ;;

        "help")
            display_help
            ;;

        "start a new project")
            DIRNAME=$(gum input --placeholder "Directory name (empty for current directory):")
            if [ -z "$DIRNAME" ]; then
                git init
            else
                mkdir "$DIRNAME" && cd "$DIRNAME" && git init
            fi
            gum spin --spinner dot -- sleep 2
            ;;

        "save my changes")
            git add -A
            MSG=$(gum input --placeholder "Describe your changes:")
            git commit -m "$MSG"
            gum spin --spinner pulse -- sleep 2
            ;;

        "get latest updates")
            gum spin --spinner jump -- git pull
            ;;

        "share my updates")
            gum spin --spinner pulse -- git push
            ;;

        "show my changes")
            STATUS=$(git status)
            gum pager <<<$STATUS
            ;;

        "create a branch")
            BRANCH_NAME=$(gum input --placeholder "Branch name:")
            git checkout -b "$BRANCH_NAME"
            gum spin --spinner meter -- sleep 2
            ;;

        "switch branch")
            BRANCHES=$(git branch | sed 's/* //g')
            TARGET_BRANCH=$(echo "$BRANCHES" | gum choose)
            git checkout "$TARGET_BRANCH"
            gum spin --spinner hamburger -- sleep 2
            ;;

        "show history")
            LOGS=$(git log --oneline)
            gum pager <<<$LOGS
            ;;

        *)
            gum style --foreground 255 --background 124 --align center --width 50 --border rounded \
                "Unknown Command!" \
                "-------------------" \
                "Try 'help' for available commands."
            ;;

    esac
done

